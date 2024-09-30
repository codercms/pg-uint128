#include "postgres.h"
#include "fmgr.h"
#include "utils/builtins.h"
#include "utils/numeric.h"
#include "utils/memutils.h"
#include <access/hash.h>
#include "lib/stringinfo.h"
#include <libpq/pqformat.h>
#include <stdint.h>
#include "uint_utils.h"
#include "uint64.h"

#ifdef PG_MODULE_MAGIC
PG_MODULE_MAGIC;
#endif

PG_FUNCTION_INFO_V1(uint8_in);
PG_FUNCTION_INFO_V1(uint8_out);
PG_FUNCTION_INFO_V1(uint8_send);
PG_FUNCTION_INFO_V1(uint8_recv);

PG_FUNCTION_INFO_V1(uint8_cmp);
PG_FUNCTION_INFO_V1(uint8_hash);

PG_FUNCTION_INFO_V1(uint8_not);

PG_FUNCTION_INFO_V1(uint8_from_uint16);
PG_FUNCTION_INFO_V1(uint8_to_uint16);

PG_FUNCTION_INFO_V1(uint8_from_uuid);
PG_FUNCTION_INFO_V1(uint8_to_uuid);

// Serialization ops

Datum uint8_in(PG_FUNCTION_ARGS)
{
	char	   *num_str = PG_GETARG_CSTRING(0);
	uint64     num = 0;

    if (num_str == NULL)
		elog(ERROR, "NULL pointer");

    if (*num_str == 0) {
        ereport(
            ERROR,
            (
                errcode(ERRCODE_INVALID_TEXT_REPRESENTATION),
                errmsg("invalid input syntax for type %s: \"%s\"", "uint8", num_str)
            )
        );
    }

    // elog(INFO, "uint8in num_str: %s", num_str);

    if (parse_uint64(num_str, &num) != 0) {
        ereport(
            ERROR,
            (
                errcode(ERRCODE_INVALID_TEXT_REPRESENTATION),
                errmsg("invalid input syntax for type %s: \"%s\"", "uint8", num_str)
            )
        );
    }

    // elog(INFO, "uint8in high %llu low %llu", (uint64)((*num) >> 64), (uint64)low_part);

	PG_RETURN_UINT64(num);
}

Datum uint8_out(PG_FUNCTION_ARGS)
{
	uint64   num = PG_GETARG_UINT64(0);
    char     *buf;
    char     *bufPtr;
    char     *str;

    // elog(INFO, "uint8out high %llu low %llu", (uint64)((*num) >> 64), (uint64)(*num));

    buf = (char*)palloc(21);

    bufPtr = uint64_to_string_v2(num, buf, 21);

    // elog(INFO, "uint8out buf (%p) bufPtr (%p): %s", buf, bufPtr, bufPtr);

    str = (char*)palloc(strlen(bufPtr));
    strcpy(str, bufPtr);

    pfree(buf);

    // elog(INFO, "uint8out str: %s", str);

	PG_RETURN_CSTRING(str);
}

/*
 *		uint8recv			- converts external binary format to uint8
 */
Datum uint8_recv(PG_FUNCTION_ARGS)
{
    uint64 result;

	StringInfo	buf = (StringInfo)PG_GETARG_POINTER(0);

    result = (uint64)pq_getmsgint64(buf);

	PG_RETURN_UINT64(result);
}

/*
 *		uint8send			- converts uint8 to binary format
 */
Datum uint8_send(PG_FUNCTION_ARGS)
{
    StringInfoData buf;
	uint64 arg1 = PG_GETARG_UINT64(0);

	pq_begintypsend(&buf);
	pq_sendint64(&buf, arg1);
	PG_RETURN_BYTEA_P(pq_endtypsend(&buf));
}

// Comparision ops

DEFINE_UINT8_SELF_COMPARISON_FUNC(eq, ==);
DEFINE_UINT8_SELF_COMPARISON_FUNC(ne, !=);
DEFINE_UINT8_SELF_COMPARISON_FUNC(lt, <);
DEFINE_UINT8_SELF_COMPARISON_FUNC(gt, >);
DEFINE_UINT8_SELF_COMPARISON_FUNC(le, <=);
DEFINE_UINT8_SELF_COMPARISON_FUNC(ge, >=);

DEFINE_UINT8_CMP_INT_FUNCS(eq, ==);
DEFINE_UINT8_CMP_INT_FUNCS(ne, !=);
DEFINE_UINT8_CMP_INT_FUNCS(lt, <);
DEFINE_UINT8_CMP_INT_FUNCS(gt, >);
DEFINE_UINT8_CMP_INT_FUNCS(le, <=);
DEFINE_UINT8_CMP_INT_FUNCS(ge, >=);

/* handler for btree index operator */
Datum uint8_cmp(PG_FUNCTION_ARGS)
{
	uint64  arg1 = PG_GETARG_UINT64(0);
	uint64  arg2 = PG_GETARG_UINT64(1);

	PG_RETURN_INT32(uint64_internal_cmp(arg1, arg2));
}

// Hashing ops

Datum uint8_hash(PG_FUNCTION_ARGS)
{
    uint64 val = PG_GETARG_UINT64(0);

    PG_RETURN_UINT64(hashuint8(val));
}

// Arithmetic ops

DEFINE_UINT8_SELF_OVERFLOW_ARITHMETIC_FUNC(add, add_u64_overflow);
DEFINE_UINT8_SELF_OVERFLOW_ARITHMETIC_FUNC(sub, sub_u64_overflow);
DEFINE_UINT8_SELF_OVERFLOW_ARITHMETIC_FUNC(mul, mul_u64_overflow);
DEFINE_UINT8_SELF_DIV_ARITHMETIC_FUNC(div, /);
DEFINE_UINT8_SELF_DIV_ARITHMETIC_FUNC(mod, %);

DEFINE_UINT8_INT_OVERFLOW_ARITHMETIC_FUNCS(add, add_u64_overflow);
DEFINE_UINT8_INT_OVERFLOW_ARITHMETIC_FUNCS(sub, sub_u64_overflow);
DEFINE_UINT8_INT_OVERFLOW_ARITHMETIC_FUNCS(mul, mul_u64_overflow);
DEFINE_UINT8_INT_DIV_ARITHMETIC_FUNCS(div, /);
DEFINE_UINT8_INT_DIV_ARITHMETIC_FUNCS(mod, %);

// Bitwise ops

DEFINE_UINT8_SELF_BITWISE_FUNC(xor, ^);
DEFINE_UINT8_SELF_BITWISE_FUNC(and, &);
DEFINE_UINT8_SELF_BITWISE_FUNC(or, |);

Datum uint8_not(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);
    uint64 result;

    result = ~(a);  // Bitwise NOT

    PG_RETURN_UINT64(result);
}

DEFINE_UINT8_SELF_BITWISE_SHIFT_FUNC(shl, <<);
DEFINE_UINT8_SELF_BITWISE_SHIFT_FUNC(shr, >>);

DEFINE_UINT8_INT_BITWISE_FUNCS(xor, ^);
DEFINE_UINT8_INT_BITWISE_FUNCS(and, &);
DEFINE_UINT8_INT_BITWISE_FUNCS(or, |);

// Cast ops

DEFINE_UINT8_FROM_INT_FUNC(int2, int16, PG_GETARG_INT16);
DEFINE_UINT8_FROM_INT_FUNC(int4, int32, PG_GETARG_INT32);
DEFINE_UINT8_FROM_INT_FUNC(int8, int64, PG_GETARG_INT64);

DEFINE_UINT8_TO_INT_FUNC(int2, int16, INT16_MAX, PG_RETURN_INT16);
DEFINE_UINT8_TO_INT_FUNC(int4, int32, INT32_MAX, PG_RETURN_INT32);
DEFINE_UINT8_TO_INT_FUNC(int8, int64, INT64_MAX, PG_RETURN_INT64);

Datum uint8_from_uint16(PG_FUNCTION_ARGS) {
    uint128 *a = PG_GETARG_Uint128_P(0);
    uint64 result;

    if (*a > UINT64_MAX) {
        ereport(ERROR,
                (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                 errmsg("uint16 value exceeds uint8 range")));
    }

    result = (uint64)a;  // Safe to cast

    PG_RETURN_UINT64(result);
}

Datum uint8_to_uint16(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);
    uint128* result = (uint128*)palloc(sizeof(uint128));

    *result = (uint128)a;  // Safe to cast

    PG_RETURN_Uint128_P(result);
}
