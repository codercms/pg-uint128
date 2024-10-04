#include "postgres.h"
#include "fmgr.h"
#include <access/hash.h>
#include "lib/stringinfo.h"
#include <libpq/pqformat.h>
#include "uint_utils.h"
#include "uint32.h"

PG_FUNCTION_INFO_V1(uint4_in);
PG_FUNCTION_INFO_V1(uint4_out);
PG_FUNCTION_INFO_V1(uint4_send);
PG_FUNCTION_INFO_V1(uint4_recv);

PG_FUNCTION_INFO_V1(uint4_cmp);
PG_FUNCTION_INFO_V1(uint4_hash);

// Serialization ops

Datum uint4_in(PG_FUNCTION_ARGS)
{
    char *num_str = PG_GETARG_CSTRING(0);
    uint32 num = 0;

    if (num_str == NULL)
        elog(ERROR, "NULL pointer");

    if (*num_str == 0) {
        ereport(
            ERROR,
            (
                errcode(ERRCODE_INVALID_TEXT_REPRESENTATION),
                errmsg("invalid input syntax for type %s: \"%s\"", "uint4", num_str)
            )
        );
    }

    if (parse_uint32(num_str, &num) != 0) {
        ereport(
            ERROR,
            (
                errcode(ERRCODE_INVALID_TEXT_REPRESENTATION),
                errmsg("invalid input syntax for type %s: \"%s\"", "uint4", num_str)
            )
        );
    }

    PG_RETURN_UINT32(num);
}

Datum uint4_out(PG_FUNCTION_ARGS)
{
    uint32 num = PG_GETARG_UINT32(0);
    char *buf;
    char *bufPtr;
    char *str;

    buf = (char *) palloc(11);

    bufPtr = uint32_to_string(num, buf, 11);

    str = (char *) palloc(strlen(bufPtr));
    strcpy(str, bufPtr);

    pfree(buf);

    PG_RETURN_CSTRING(str);
}

/*
 *		uint4recv			- converts external binary format to uint4
 */
Datum uint4_recv(PG_FUNCTION_ARGS)
{
    uint32 result;

    StringInfo buf = (StringInfo) PG_GETARG_POINTER(0);

    result = pq_getmsgint(buf, 4);

    PG_RETURN_UINT32(result);
}

/*
 *		uint4send			- converts uint4 to binary format
 */
Datum uint4_send(PG_FUNCTION_ARGS)
{
    StringInfoData buf;
    uint32 arg1 = PG_GETARG_UINT32(0);

    pq_begintypsend(&buf);
    pq_sendint32(&buf, arg1);
    PG_RETURN_BYTEA_P(pq_endtypsend(&buf));
}

/* handler for btree index operator */
Datum uint4_cmp(PG_FUNCTION_ARGS)
{
    uint32 arg1 = PG_GETARG_UINT32(0);
    uint32 arg2 = PG_GETARG_UINT32(1);

    PG_RETURN_INT32(uint32_internal_cmp(arg1, arg2));
}

// Hashing ops

Datum uint4_hash(PG_FUNCTION_ARGS)
{
    uint32 val = PG_GETARG_UINT32(0);

    PG_RETURN_UINT64(hash_uint32(val));
}
