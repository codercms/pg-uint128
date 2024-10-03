#include "postgres.h"
#include "fmgr.h"
#include "utils/uuid.h"
#include "utils/memutils.h"
#include <access/hash.h>
#include "lib/stringinfo.h"
#include <libpq/pqformat.h>
#include <stdint.h>
#include "uint_utils.h"
#include "int_utils.h"
#include "uint128.h"
#include "misc.h"

PG_FUNCTION_INFO_V1(uint16_in);
PG_FUNCTION_INFO_V1(uint16_out);
PG_FUNCTION_INFO_V1(uint16_send);
PG_FUNCTION_INFO_V1(uint16_recv);

PG_FUNCTION_INFO_V1(uint16_cmp);
PG_FUNCTION_INFO_V1(uint16_hash);

PG_FUNCTION_INFO_V1(uint16_not);

PG_FUNCTION_INFO_V1(uint16_from_uuid);
PG_FUNCTION_INFO_V1(uint16_to_uuid);

// Serialization ops

Datum uint16_in(PG_FUNCTION_ARGS)
{
    char *num_str = PG_GETARG_CSTRING(0);
    uint128 num = 0;

    if (num_str == NULL)
        elog(ERROR, "NULL pointer");

    if (*num_str == 0) {
        ereport(
            ERROR,
            (
                errcode(ERRCODE_INVALID_TEXT_REPRESENTATION),
                errmsg("invalid input syntax for type %s: \"%s\"", "uint16", num_str)
            )
        );
    }

    // elog(INFO, "uint16in num_str: %s", num_str);

    if (parse_uint128(num_str, &num) != 0) {
        ereport(
            ERROR,
            (
                errcode(ERRCODE_INVALID_TEXT_REPRESENTATION),
                errmsg("invalid input syntax for type %s: \"%s\"", "uint16", num_str)
            )
        );
    }

    // elog(INFO, "uint16in high %llu low %llu", (uint64)((*num) >> 64), (uint64)low_part);

    PG_RETURN_UINT128(num);
}

Datum uint16_out(PG_FUNCTION_ARGS)
{
    uint128 *num = PG_GETARG_UINT128_P(0);
    char *buf;
    char *bufPtr;
    char *str;

    if (num == NULL)
        elog(ERROR, "NULL pointer");

    // elog(INFO, "uint16out high %llu low %llu", (uint64)((*num) >> 64), (uint64)(*num));

    buf = (char *) palloc(41);

    bufPtr = uint128_to_string_v2(*num, buf, 41);
    if (bufPtr == NULL) {
        pfree(buf);

        elog(ERROR, "Cannot convert uint16 to string");
    }

    // elog(INFO, "uint16out buf (%p) bufPtr (%p): %s", buf, bufPtr, bufPtr);

    str = (char *) palloc(strlen(bufPtr));
    strcpy(str, bufPtr);

    pfree(buf);

    // elog(INFO, "uint16out str: %s", str);

    PG_RETURN_CSTRING(str);
}

/*
 *		uint16recv			- converts external binary format to uint16
 */
Datum uint16_recv(PG_FUNCTION_ARGS)
{
    uint128 result = 0;
    uint64 high_part, low_part;

    StringInfo buf = (StringInfo) PG_GETARG_POINTER(0);

    // Read the high 64 bits from the buffer
    high_part = pq_getmsgint64(buf);
    // Read the low 64 bits from the buffer
    low_part = pq_getmsgint64(buf);

    // Combine the two 64-bit parts into a 128-bit value
    result = ((uint128) high_part << 64) | (uint128) low_part;

    PG_RETURN_UINT128(result);
}

/*
 *		uint16send			- converts uint16 to binary format
 */
Datum uint16_send(PG_FUNCTION_ARGS)
{
    StringInfoData buf;
    uint128 arg1 = PG_GETARG_UINT128(0);

    pq_begintypsend(&buf);
    pq_sendint64(&buf, arg1 >> 64); // Extract the high 64 bits
    pq_sendint64(&buf, arg1); // Extract the low 64 bits
    PG_RETURN_BYTEA_P(pq_endtypsend(&buf));
}

// Comparision ops

DEFINE_UINT16_CMP_SIGNED_AND_UNSIGNED_INT_FUNCS(eq, ==, CMP_EQ);
DEFINE_UINT16_CMP_SIGNED_AND_UNSIGNED_INT_FUNCS(ne, !=, CMP_NE);
DEFINE_UINT16_CMP_SIGNED_AND_UNSIGNED_INT_FUNCS(lt, <, CMP_LT);
DEFINE_UINT16_CMP_SIGNED_AND_UNSIGNED_INT_FUNCS(gt, >, CMP_GT);
DEFINE_UINT16_CMP_SIGNED_AND_UNSIGNED_INT_FUNCS(le, <=, CMP_LE);
DEFINE_UINT16_CMP_SIGNED_AND_UNSIGNED_INT_FUNCS(ge, >=, CMP_GE);

/* handler for btree index operator */
Datum uint16_cmp(PG_FUNCTION_ARGS)
{
    uint128 *arg1 = PG_GETARG_UINT128_P(0);
    uint128 *arg2 = PG_GETARG_UINT128_P(1);

    PG_RETURN_INT32(uint128_internal_cmp(arg1, arg2));
}

// Hashing ops

Datum uint16_hash(PG_FUNCTION_ARGS)
{
    uint128 val = PG_GETARG_UINT128(0);

    PG_RETURN_UINT64(
        hash_combine(
            DatumGetUInt32(hashuint8(val >> 64)),
            DatumGetUInt32(hashuint8(val))
        )
    );
}

// Arithmetic ops

DEFINE_UINT16_UNSIGNED_INT_OVERFLOW_ARITHMETIC_FUNCS(add, add_u128_overflow);
DEFINE_UINT16_UNSIGNED_INT_OVERFLOW_ARITHMETIC_FUNCS(sub, sub_u128_overflow);
DEFINE_UINT16_UNSIGNED_INT_OVERFLOW_ARITHMETIC_FUNCS(mul, mul_u128_overflow);
DEFINE_UINT16_UNSIGNED_INT_DIV_ARITHMETIC_FUNCS(div, /);
DEFINE_UINT16_UNSIGNED_INT_DIV_ARITHMETIC_FUNCS(mod, %);

DEFINE_UINT16_SIGNED_INT_OVERFLOW_ARITHMETIC_FUNCS(add, add_u128, OVERFLOW_OP_ADD);
DEFINE_UINT16_SIGNED_INT_OVERFLOW_ARITHMETIC_FUNCS(sub, sub_u128, OVERFLOW_OP_SUB);
DEFINE_UINT16_SIGNED_INT_OVERFLOW_ARITHMETIC_FUNCS(mul, mul_u128, OVERFLOW_OP_MUL);
DEFINE_UINT16_SIGNED_INT_DIV_ARITHMETIC_FUNCS(div, /);
DEFINE_UINT16_SIGNED_INT_DIV_ARITHMETIC_FUNCS(mod, %);

DEFINE_SIGNED_INT_UINT16_OVERFLOW_ARITHMETIC_FUNCS(add);
DEFINE_SIGNED_INT_UINT16_OVERFLOW_ARITHMETIC_FUNCS(sub);
DEFINE_SIGNED_INT_UINT16_OVERFLOW_ARITHMETIC_FUNCS(mul);

DEFINE_SIGNED_INT_UINT16_DIV_ARITHMETIC_FUNCS();
DEFINE_SIGNED_INT_UINT16_MOD_ARITHMETIC_FUNCS();

// Bitwise ops

Datum uint16_not(PG_FUNCTION_ARGS)
{
    PG_RETURN_UINT128(~(PG_GETARG_UINT128(0)));
}

DEFINE_UINT16_BITWISE_SHIFT_FUNC(shl, <<);
DEFINE_UINT16_BITWISE_SHIFT_FUNC(shr, >>);

DEFINE_UINT16_SIGNED_AND_UNSIGNED_INT_BITWISE_FUNCS(xor, ^);
DEFINE_UINT16_SIGNED_AND_UNSIGNED_INT_BITWISE_FUNCS(and, &);
DEFINE_UINT16_SIGNED_AND_UNSIGNED_INT_BITWISE_FUNCS(or, |);

DEFINE_SIGNED_INT_UINT16_BITWISE_FUNCS(xor, ^);
DEFINE_SIGNED_INT_UINT16_BITWISE_FUNCS(and, &);
DEFINE_SIGNED_INT_UINT16_BITWISE_FUNCS(or, |);

// Cast ops

DEFINE_UINT16_FROM_INT_FUNC(int2, int16, PG_GETARG_INT16);
DEFINE_UINT16_FROM_INT_FUNC(int4, int32, PG_GETARG_INT32);
DEFINE_UINT16_FROM_INT_FUNC(int8, int64, PG_GETARG_INT64);
DEFINE_UINT16_FROM_INT_FUNC(uint8, uint64, PG_GETARG_UINT64);

DEFINE_UINT16_TO_INT_FUNC(int2, int16, INT16_MAX, PG_RETURN_INT16);
DEFINE_UINT16_TO_INT_FUNC(int4, int32, INT32_MAX, PG_RETURN_INT32);
DEFINE_UINT16_TO_INT_FUNC(int8, int64, INT64_MAX, PG_RETURN_INT64);
DEFINE_UINT16_TO_INT_FUNC(uint8, uint64, UINT64_MAX, PG_RETURN_UINT64);


// Special cast to UUID and back

Datum uint16_from_uuid(PG_FUNCTION_ARGS)
{
    pg_uuid_t *uuid = PG_GETARG_UUID_P(0);
    uint128 *result = palloc(sizeof(uint128));

    *result = be128toh(*(uint128 *) (uuid->data));

    PG_RETURN_UINT128_P(result);
}

Datum uint16_to_uuid(PG_FUNCTION_ARGS)
{
    uint128   *uint = PG_GETARG_UINT128_P(0);
    pg_uuid_t *uuid = palloc(sizeof(pg_uuid_t));

    *(uint128 *) (uuid->data) = htobe128(*uint);

    PG_RETURN_UUID_P(uuid);
}
