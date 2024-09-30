#include "postgres.h"
#include "fmgr.h"
#include "utils/builtins.h"
#include "utils/uuid.h"
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

PG_FUNCTION_INFO_V1(uint8_eq);
PG_FUNCTION_INFO_V1(uint8_ne);
PG_FUNCTION_INFO_V1(uint8_lt);
PG_FUNCTION_INFO_V1(uint8_gt);
PG_FUNCTION_INFO_V1(uint8_le);
PG_FUNCTION_INFO_V1(uint8_ge);

PG_FUNCTION_INFO_V1(uint8_cmp);
PG_FUNCTION_INFO_V1(uint8_hash);

PG_FUNCTION_INFO_V1(uint8_add);
PG_FUNCTION_INFO_V1(uint8_sub);
PG_FUNCTION_INFO_V1(uint8_mul);
PG_FUNCTION_INFO_V1(uint8_div);
PG_FUNCTION_INFO_V1(uint8_mod);

PG_FUNCTION_INFO_V1(uint8_xor);
PG_FUNCTION_INFO_V1(uint8_and);
PG_FUNCTION_INFO_V1(uint8_or);
PG_FUNCTION_INFO_V1(uint8_not);
PG_FUNCTION_INFO_V1(uint8_shl);
PG_FUNCTION_INFO_V1(uint8_shr);

PG_FUNCTION_INFO_V1(uint8_from_int2);
PG_FUNCTION_INFO_V1(uint8_from_int4);
PG_FUNCTION_INFO_V1(uint8_from_int8);
PG_FUNCTION_INFO_V1(uint8_from_uint16);

PG_FUNCTION_INFO_V1(uint8_to_int2);
PG_FUNCTION_INFO_V1(uint8_to_int4);
PG_FUNCTION_INFO_V1(uint8_to_int8);
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

Datum uint8_eq(PG_FUNCTION_ARGS)
{
	uint64		val1 = PG_GETARG_UINT64(0);
    uint64		val2 = PG_GETARG_UINT64(1);

	PG_RETURN_BOOL(val1 == val2);
}

Datum uint8_ne(PG_FUNCTION_ARGS)
{
	uint64		val1 = PG_GETARG_UINT64(0);
	uint64		val2 = PG_GETARG_UINT64(1);

	PG_RETURN_BOOL(val1 != val2);
}

Datum uint8_lt(PG_FUNCTION_ARGS)
{
	uint64		val1 = PG_GETARG_UINT64(0);
	uint64		val2 = PG_GETARG_UINT64(1);

	PG_RETURN_BOOL(val1 < val2);
}

Datum uint8_gt(PG_FUNCTION_ARGS)
{
	uint64		val1 = PG_GETARG_UINT64(0);
	uint64		val2 = PG_GETARG_UINT64(1);

	PG_RETURN_BOOL(val1 > val2);
}

Datum uint8_le(PG_FUNCTION_ARGS)
{
	uint64		val1 = PG_GETARG_UINT64(0);
	uint64		val2 = PG_GETARG_UINT64(1);

	PG_RETURN_BOOL(val1 <= val2);
}

Datum uint8_ge(PG_FUNCTION_ARGS)
{
	uint64		val1 = PG_GETARG_UINT64(0);
	uint64		val2 = PG_GETARG_UINT64(1);

	PG_RETURN_BOOL(val1 >= val2);
}

DEFINE_UINT64_CMP_FUNCTIONS(eq, uint8_eq);
DEFINE_UINT64_CMP_FUNCTIONS(ne, uint8_ne);
DEFINE_UINT64_CMP_FUNCTIONS(gt, uint8_gt);
DEFINE_UINT64_CMP_FUNCTIONS(ge, uint8_ge);
DEFINE_UINT64_CMP_FUNCTIONS(lt, uint8_lt);
DEFINE_UINT64_CMP_FUNCTIONS(le, uint8_le);

/* handler for btree index operator */
Datum uint8_cmp(PG_FUNCTION_ARGS)
{
	uint64  arg1 = PG_GETARG_UINT64(0);
	uint64  arg2 = PG_GETARG_UINT64(1);
    int32   res  = 0; 

    if (arg1 < arg2) res = -1; // arg1 is less than arg2
    if (arg1 > arg2) res = 1;  // arg1 is greater than arg2

	PG_RETURN_INT32(res);
}

// Hashing ops

Datum uint8_hash(PG_FUNCTION_ARGS)
{
    uint64 val = PG_GETARG_UINT64(0);

    PG_RETURN_UINT64(hashuint8(val));
}

// Arithmetic ops

Datum uint8_add(PG_FUNCTION_ARGS)
{
	uint64		a = PG_GETARG_UINT64(0);
	uint64		b = PG_GETARG_UINT64(1);
	uint64		result;

    if (b == 0) {
        PG_RETURN_UINT64(a);
    }

    // Check for overflow
    if (a > UINT64_MAX - b) {
        ereport(ERROR,
            (
                errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                errmsg("uint8 out of range")
            )
        );
    }

    result = a + b;

    PG_RETURN_UINT64(result);
}

Datum uint8_sub(PG_FUNCTION_ARGS)
{
	uint64		a = PG_GETARG_UINT64(0);
	uint64		b = PG_GETARG_UINT64(1);
	uint64		result;

    if (b == 0) {
        PG_RETURN_UINT64(a);
    }

    // Check for overflow
    if (b > a) {
        ereport(ERROR,
            (
                errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                errmsg("uint8 out of range")
            )
        );
    }

    result = a - b;

    PG_RETURN_UINT64(result);
}

Datum uint8_mul(PG_FUNCTION_ARGS)
{
	uint64		a = PG_GETARG_UINT64(0);
	uint64		b = PG_GETARG_UINT64(1);
	uint64		result = 0;

    if (a == 0 || b == 0) {
        PG_RETURN_UINT64(result);
    }

    // Check for overflow
    if (a > UINT64_MAX / b) {
        ereport(ERROR,
            (
                errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                errmsg("uint8 out of range")
            )
        );
    }

    result = a * b;

    PG_RETURN_UINT64(result);
}

Datum uint8_div(PG_FUNCTION_ARGS)
{
	uint64		a = PG_GETARG_UINT64(0);
	uint64		b = PG_GETARG_UINT64(1);
	uint64		result;

    // Check for division by zero
    if (b == 0) {
        ereport(ERROR,
            (
                errcode(ERRCODE_DIVISION_BY_ZERO),
                errmsg("division by zero")
            )
        );
    }

    result = a / b;

    PG_RETURN_UINT64(result);
}

Datum uint8_mod(PG_FUNCTION_ARGS)
{
	uint64		a = PG_GETARG_UINT64(0);
	uint64		b = PG_GETARG_UINT64(1);
	uint64		result;

    // Check for division by zero
    if (b == 0) {
        ereport(ERROR,
            (
                errcode(ERRCODE_DIVISION_BY_ZERO),
                errmsg("division by zero")
            )
        );
    }

    result = a % b;

    PG_RETURN_UINT64(result);
}

DEFINE_UINT64_ARITHMETIC_FUNCTIONS(add, uint8_add);
DEFINE_UINT64_ARITHMETIC_FUNCTIONS(sub, uint8_sub);
DEFINE_UINT64_ARITHMETIC_FUNCTIONS(mul, uint8_mul);
DEFINE_UINT64_ARITHMETIC_FUNCTIONS(div, uint8_div);
DEFINE_UINT64_ARITHMETIC_FUNCTIONS(mod, uint8_mod);

// Bitwise ops

Datum uint8_xor(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);
    uint64 b = PG_GETARG_UINT64(1);
    uint64 result;

    result = a ^ b;  // Bitwise XOR

    PG_RETURN_UINT64(result);
}

Datum uint8_and(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);
    uint64 b = PG_GETARG_UINT64(1);
    uint64 result;

    result = a & b;  // Bitwise AND

    PG_RETURN_UINT64(result);
}

Datum uint8_or(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);
    uint64 b = PG_GETARG_UINT64(1);
    uint64 result;

    result = a | b;  // Bitwise OR

    PG_RETURN_UINT64(result);
}

Datum uint8_not(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);
    uint64 result;

    result = ~(a);  // Bitwise NOT

    PG_RETURN_UINT64(result);
}

Datum uint8_shl(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);
    int32 shift = PG_GETARG_INT32(1);  // Number of bits to shift
    uint64 result;

    result = a << shift;  // Bitwise shift left

    PG_RETURN_UINT64(result);
}

Datum uint8_shr(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);
    int32 shift = PG_GETARG_INT32(1);  // Number of bits to shift
    uint64 result;

    result = a >> shift;  // Bitwise shift right

    PG_RETURN_UINT64(result);
}

DEFINE_UINT64_BITWISE_FUNCTIONS(xor, uint8_xor);
DEFINE_UINT64_BITWISE_FUNCTIONS(and, uint8_and);
DEFINE_UINT64_BITWISE_FUNCTIONS(or, uint8_or);
DEFINE_UINT64_BITWISE_FUNCTIONS(shl, uint8_shl);
DEFINE_UINT64_BITWISE_FUNCTIONS(shr, uint8_shr);

// Cast ops

Datum uint8_from_int2(PG_FUNCTION_ARGS) {
    int16 a = PG_GETARG_INT16(0);
    uint64 result;

    result = (uint64)a;  // Convert int2 to uint128

    PG_RETURN_UINT64(result);
}

Datum uint8_from_int4(PG_FUNCTION_ARGS) {
    int32 a = PG_GETARG_INT32(0);
    uint64 result;

    result = (uint64)a;  // Convert int4 to uint128

    PG_RETURN_UINT64(result);
}

Datum uint8_from_int8(PG_FUNCTION_ARGS) {
    int64 a = PG_GETARG_INT64(0);
    uint64 result;

    result = (uint64)a;  // Convert int8 to uint128

    PG_RETURN_UINT64(result);
}

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


Datum uint8_to_int2(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);
    int16 result;

    // Check for overflow
    if (a > INT16_MAX) {
        ereport(ERROR,
                (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                 errmsg("uint8 value exceeds int2 range")));
    }

    result = (int16)a;  // Safe to cast
    PG_RETURN_INT16(result);
}

Datum uint8_to_int4(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);
    int32 result;

    // Check for overflow
    if (a > INT32_MAX) {
        ereport(ERROR,
                (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                 errmsg("uint8 value exceeds int4 range")));
    }

    result = (int32)a;  // Safe to cast
    PG_RETURN_INT32(result);
}

Datum uint8_to_int8(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);
    int64 result;

    // Check for overflow
    if (a > INT64_MAX) {
        ereport(ERROR,
                (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                 errmsg("uint128 value exceeds int8 range")));
    }

    result = (int64)a;  // Safe to cast
    PG_RETURN_INT64(result);
}

Datum uint8_to_uint16(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);
    uint128* result = (uint128*)palloc(sizeof(uint128));

    *result = (uint128)a;  // Safe to cast

    PG_RETURN_Uint128_P(result);
}
