#include "postgres.h"
#include "fmgr.h"
#include <access/hash.h>
#include "lib/stringinfo.h"
#include <libpq/pqformat.h>
#include "uint_utils.h"
#include "int_utils.h"
#include "int128.h"

PG_FUNCTION_INFO_V1(int16_in);
PG_FUNCTION_INFO_V1(int16_out);
PG_FUNCTION_INFO_V1(int16_send);
PG_FUNCTION_INFO_V1(int16_recv);

PG_FUNCTION_INFO_V1(int16_cmp);
PG_FUNCTION_INFO_V1(int16_hash);

// Serialization ops

Datum int16_in(PG_FUNCTION_ARGS)
{
    char *num_str = PG_GETARG_CSTRING(0);
    int128 num = 0;

    if (num_str == NULL)
        elog(ERROR, "NULL pointer");

    if (*num_str == 0) {
        ereport(
            ERROR,
            (
                errcode(ERRCODE_INVALID_TEXT_REPRESENTATION),
                errmsg("invalid input syntax for type %s: \"%s\"", "int16", num_str)
            )
        );
    }

    // elog(INFO, "uint16in num_str: %s", num_str);

    if (parse_int128(num_str, &num) != 0) {
        ereport(
            ERROR,
            (
                errcode(ERRCODE_INVALID_TEXT_REPRESENTATION),
                errmsg("invalid input syntax for type %s: \"%s\"", "int16", num_str)
            )
        );
    }

    // elog(INFO, "uint16in high %llu low %llu", (uint64)((*num) >> 64), (uint64)low_part);

    PG_RETURN_INT128(num);
}

Datum int16_out(PG_FUNCTION_ARGS)
{
    char buf[INT128_STRBUFLEN];

    int128 num = PG_GETARG_INT128(0);

    char *bufPtr = int128_to_string(num, buf, sizeof(buf));

    PG_RETURN_CSTRING(pstrdup(bufPtr));
}

/*
 *		uint16recv			- converts external binary format to uint16
 */
Datum int16_recv(PG_FUNCTION_ARGS)
{
    int128 result = 0;
    int64 high_part, low_part;

    StringInfo buf = (StringInfo) PG_GETARG_POINTER(0);

    // Read the high 64 bits from the buffer
    high_part = pq_getmsgint64(buf);
    // Read the low 64 bits from the buffer
    low_part = pq_getmsgint64(buf);

    // Combine the two 64-bit parts into a 128-bit value
    result = ((int128) high_part << 64) | (int128) low_part;

    PG_RETURN_INT128(result);
}

/*
 *		uint16send			- converts uint16 to binary format
 */
Datum int16_send(PG_FUNCTION_ARGS)
{
    StringInfoData buf;
    int128 arg1 = PG_GETARG_INT128(0);

    pq_begintypsend(&buf);
    pq_sendint64(&buf, arg1 >> 64); // Extract the high 64 bits
    pq_sendint64(&buf, arg1); // Extract the low 64 bits
    PG_RETURN_BYTEA_P(pq_endtypsend(&buf));
}

/* handler for btree index operator */
Datum int16_cmp(PG_FUNCTION_ARGS)
{
    int128 *arg1 = PG_GETARG_INT128_P(0);
    int128 *arg2 = PG_GETARG_INT128_P(1);

    PG_RETURN_INT32(int128_internal_cmp(arg1, arg2));
}

// Hashing ops

Datum int16_hash(PG_FUNCTION_ARGS)
{
    int128 val = PG_GETARG_INT128(0);

    PG_RETURN_UINT64(
        hash_combine(
            DatumGetUInt32(hashuint8(val >> 64)),
            DatumGetUInt32(hashuint8(val))
        )
    );
}
