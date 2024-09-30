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
#include "uint128.h"

#ifdef PG_MODULE_MAGIC
PG_MODULE_MAGIC;
#endif

PG_FUNCTION_INFO_V1(uint16_in);
PG_FUNCTION_INFO_V1(uint16_out);
PG_FUNCTION_INFO_V1(uint16_send);
PG_FUNCTION_INFO_V1(uint16_recv);

PG_FUNCTION_INFO_V1(uint16_eq);
PG_FUNCTION_INFO_V1(uint16_ne);
PG_FUNCTION_INFO_V1(uint16_lt);
PG_FUNCTION_INFO_V1(uint16_gt);
PG_FUNCTION_INFO_V1(uint16_le);
PG_FUNCTION_INFO_V1(uint16_ge);

PG_FUNCTION_INFO_V1(uint16_cmp);
PG_FUNCTION_INFO_V1(uint16_hash);

PG_FUNCTION_INFO_V1(uint16_add);
PG_FUNCTION_INFO_V1(uint16_sub);
PG_FUNCTION_INFO_V1(uint16_mul);
PG_FUNCTION_INFO_V1(uint16_div);
PG_FUNCTION_INFO_V1(uint16_mod);

PG_FUNCTION_INFO_V1(uint16_xor);
PG_FUNCTION_INFO_V1(uint16_and);
PG_FUNCTION_INFO_V1(uint16_or);
PG_FUNCTION_INFO_V1(uint16_not);
PG_FUNCTION_INFO_V1(uint16_shl);
PG_FUNCTION_INFO_V1(uint16_shr);

PG_FUNCTION_INFO_V1(uint16_from_int2);
PG_FUNCTION_INFO_V1(uint16_from_int4);
PG_FUNCTION_INFO_V1(uint16_from_int8);

PG_FUNCTION_INFO_V1(uint16_to_int2);
PG_FUNCTION_INFO_V1(uint16_to_int4);
PG_FUNCTION_INFO_V1(uint16_to_int8);

PG_FUNCTION_INFO_V1(uint16_from_uuid);
PG_FUNCTION_INFO_V1(uint16_to_uuid);

// Serialization ops

Datum uint16_in(PG_FUNCTION_ARGS)
{
	char	   *num_str = PG_GETARG_CSTRING(0);
	uint128    *num;

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

	num = (uint128*)palloc(sizeof(uint128));
    *num = 0;

    if (parse_uint128(num_str, num) != 0) {
        pfree(num);

        ereport(
            ERROR,
            (
                errcode(ERRCODE_INVALID_TEXT_REPRESENTATION),
                errmsg("invalid input syntax for type %s: \"%s\"", "uint16", num_str)
            )
        );
    }

    // elog(INFO, "uint16in high %llu low %llu", (uint64)((*num) >> 64), (uint64)low_part);

	PG_RETURN_Uint128_P(num);
}

Datum uint16_out(PG_FUNCTION_ARGS)
{
	uint128  *num = PG_GETARG_Uint128_P(0);
    char     *buf;
    char     *bufPtr;
    char     *str;

    if (num == NULL)
		elog(ERROR, "NULL pointer");

    // elog(INFO, "uint16out high %llu low %llu", (uint64)((*num) >> 64), (uint64)(*num));

    buf = (char*)palloc(41);

    bufPtr = uint128_to_string_v2(*num, buf, 41);

    // elog(INFO, "uint16out buf (%p) bufPtr (%p): %s", buf, bufPtr, bufPtr);

    str = (char*)palloc(strlen(bufPtr));
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
    uint128* result;
    uint64 high_part, low_part;

	StringInfo	buf = (StringInfo)PG_GETARG_POINTER(0);

    // Read the high 64 bits from the buffer
    high_part = pq_getmsgint64(buf);
    // Read the low 64 bits from the buffer
    low_part = pq_getmsgint64(buf);

    result = (uint128*)palloc(sizeof(uint128));

    // Combine the two 64-bit parts into a 128-bit value
    *result = ((uint128)high_part << 64) | (uint128)low_part;

	PG_RETURN_Uint128_P(result);
}

/*
 *		uint16send			- converts uint16 to binary format
 */
Datum uint16_send(PG_FUNCTION_ARGS)
{
    StringInfoData buf;
	uint128* arg1 = PG_GETARG_Uint128_P(0);

	pq_begintypsend(&buf);
	pq_sendint64(&buf, (uint64)((*arg1) >> 64)); // Extract the high 64 bits
	pq_sendint64(&buf, (uint64)(*arg1));         // Extract the low 64 bits
	PG_RETURN_BYTEA_P(pq_endtypsend(&buf));
}

// Comparision ops

Datum uint16_eq(PG_FUNCTION_ARGS)
{
	uint128		*val1 = PG_GETARG_Uint128_P(0);
    uint128		*val2 = PG_GETARG_Uint128_P(1);

	PG_RETURN_BOOL(*val1 == *val2);
}

Datum uint16_ne(PG_FUNCTION_ARGS)
{
	uint128		*val1 = PG_GETARG_Uint128_P(0);
	uint128		*val2 = PG_GETARG_Uint128_P(1);

	PG_RETURN_BOOL(*val1 != *val2);
}

Datum uint16_lt(PG_FUNCTION_ARGS)
{
	uint128		*val1 = PG_GETARG_Uint128_P(0);
	uint128		*val2 = PG_GETARG_Uint128_P(1);

	PG_RETURN_BOOL(*val1 < *val2);
}

Datum uint16_gt(PG_FUNCTION_ARGS)
{
	uint128		*val1 = PG_GETARG_Uint128_P(0);
	uint128		*val2 = PG_GETARG_Uint128_P(1);

	PG_RETURN_BOOL(*val1 > *val2);
}

Datum uint16_le(PG_FUNCTION_ARGS)
{
	uint128		*val1 = PG_GETARG_Uint128_P(0);
	uint128		*val2 = PG_GETARG_Uint128_P(1);

	PG_RETURN_BOOL(*val1 <= *val2);
}

Datum uint16_ge(PG_FUNCTION_ARGS)
{
	uint128		*val1 = PG_GETARG_Uint128_P(0);
	uint128		*val2 = PG_GETARG_Uint128_P(1);

	PG_RETURN_BOOL(*val1 >= *val2);
}

DEFINE_UINT128_CMP_FUNCTIONS(eq, uint16_eq);
DEFINE_UINT128_CMP_FUNCTIONS(ne, uint16_ne);
DEFINE_UINT128_CMP_FUNCTIONS(gt, uint16_gt);
DEFINE_UINT128_CMP_FUNCTIONS(ge, uint16_ge);
DEFINE_UINT128_CMP_FUNCTIONS(lt, uint16_lt);
DEFINE_UINT128_CMP_FUNCTIONS(le, uint16_le);

/* handler for btree index operator */
Datum uint16_cmp(PG_FUNCTION_ARGS)
{
	uint128  *arg1 = PG_GETARG_Uint128_P(0);
	uint128  *arg2 = PG_GETARG_Uint128_P(1);

	PG_RETURN_INT32(uint128_internal_cmp(arg1, arg2));
}

// Hashing ops

Datum uint16_hash(PG_FUNCTION_ARGS)
{
    uint128* val = PG_GETARG_Uint128_P(0);
    uint64 high = (uint64)(*val >> 64);
    uint64 low = (uint64)(*val);

    PG_RETURN_UINT64(
        hash_combine(
            DatumGetUInt32(hashuint8(high)),
            DatumGetUInt32(hashuint8(low))
        )
    );
}

// Arithmetic ops

Datum uint16_add(PG_FUNCTION_ARGS)
{
	uint128		*a = PG_GETARG_Uint128_P(0);
	uint128		*b = PG_GETARG_Uint128_P(1);
	uint128		*result;

    if (b == 0) {
        PG_RETURN_Uint128_P(a);
    }

    // Check for overflow
    if (*a > UINT128_MAX - *b) {
        ereport(ERROR,
            (
                errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                errmsg("uint16 out of range")
            )
        );
    }

    result = (uint128*)palloc(sizeof(uint128));
    *result = *a + *b;

    PG_RETURN_Uint128_P(result);
}

Datum uint16_sub(PG_FUNCTION_ARGS)
{
	uint128		*a = PG_GETARG_Uint128_P(0);
	uint128		*b = PG_GETARG_Uint128_P(1);
	uint128		*result;

    if (*b == 0) {
        PG_RETURN_Uint128_P(a);
    }

    // Check for overflow
    if (*b > *a) {
        ereport(ERROR,
            (
                errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                errmsg("uint16 out of range")
            )
        );
    }

    result = (uint128*)palloc(sizeof(uint128));
    *result = *a - *b;

    PG_RETURN_Uint128_P(result);
}

Datum uint16_mul(PG_FUNCTION_ARGS)
{
	uint128		*a = PG_GETARG_Uint128_P(0);
	uint128		*b = PG_GETARG_Uint128_P(1);
	uint128		*result;

    if (*a == 0 || *b == 0) {
        result = (uint128*)palloc(sizeof(uint128));
        *result = 0;

        PG_RETURN_Uint128_P(result);
    }

    // Check for overflow
    if (*a > UINT128_MAX / *b) {
        ereport(ERROR,
            (
                errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                errmsg("uint16 out of range")
            )
        );
    }

    result = (uint128*)palloc(sizeof(uint128));
    *result = *a * *b;

    PG_RETURN_Uint128_P(result);
}

Datum uint16_div(PG_FUNCTION_ARGS)
{
	uint128		*a = PG_GETARG_Uint128_P(0);
	uint128		*b = PG_GETARG_Uint128_P(1);
	uint128		*result;

    // Check for division by zero
    if (*b == 0) {
        ereport(ERROR,
            (
                errcode(ERRCODE_DIVISION_BY_ZERO),
                errmsg("division by zero")
            )
        );
    }

    result = (uint128*)palloc(sizeof(uint128));
    *result = *a / *b;

    PG_RETURN_Uint128_P(result);
}

Datum uint16_mod(PG_FUNCTION_ARGS)
{
	uint128		*a = PG_GETARG_Uint128_P(0);
	uint128		*b = PG_GETARG_Uint128_P(1);
	uint128		*result;

    // Check for division by zero
    if (*b == 0) {
        ereport(ERROR,
            (
                errcode(ERRCODE_DIVISION_BY_ZERO),
                errmsg("division by zero")
            )
        );
    }

    result = (uint128*)palloc(sizeof(uint128));
    *result = *a % *b;

    PG_RETURN_Uint128_P(result);
}

DEFINE_UINT128_ARITHMETIC_FUNCTIONS(add, uint16_add);
DEFINE_UINT128_ARITHMETIC_FUNCTIONS(sub, uint16_sub);
DEFINE_UINT128_ARITHMETIC_FUNCTIONS(mul, uint16_mul);
DEFINE_UINT128_ARITHMETIC_FUNCTIONS(div, uint16_div);
DEFINE_UINT128_ARITHMETIC_FUNCTIONS(mod, uint16_mod);

// Bitwise ops

Datum uint16_xor(PG_FUNCTION_ARGS) {
    uint128 *a = PG_GETARG_Uint128_P(0);
    uint128 *b = PG_GETARG_Uint128_P(1);
    uint128 *result;

    result = (uint128 *) palloc(sizeof(uint128));
    *result = *a ^ *b;  // Bitwise XOR

    PG_RETURN_Uint128_P(result);
}

Datum uint16_and(PG_FUNCTION_ARGS) {
    uint128 *a = PG_GETARG_Uint128_P(0);
    uint128 *b = PG_GETARG_Uint128_P(1);
    uint128 *result;

    result = (uint128 *) palloc(sizeof(uint128));
    *result = *a & *b;  // Bitwise AND

    PG_RETURN_Uint128_P(result);
}

Datum uint16_or(PG_FUNCTION_ARGS) {
    uint128 *a = PG_GETARG_Uint128_P(0);
    uint128 *b = PG_GETARG_Uint128_P(1);
    uint128 *result;

    result = (uint128 *) palloc(sizeof(uint128));
    *result = *a | *b;  // Bitwise OR

    PG_RETURN_Uint128_P(result);
}

Datum uint16_not(PG_FUNCTION_ARGS) {
    uint128 *a = PG_GETARG_Uint128_P(0);
    uint128 *result;

    result = (uint128 *) palloc(sizeof(uint128));
    *result = ~(*a);  // Bitwise NOT

    PG_RETURN_Uint128_P(result);
}

Datum uint16_shl(PG_FUNCTION_ARGS) {
    uint128 *a = PG_GETARG_Uint128_P(0);
    int32 shift = PG_GETARG_INT32(1);  // Number of bits to shift
    uint128 *result;

    result = (uint128 *) palloc(sizeof(uint128));
    *result = *a << shift;  // Bitwise shift left

    PG_RETURN_Uint128_P(result);
}

Datum uint16_shr(PG_FUNCTION_ARGS) {
    uint128 *a = PG_GETARG_Uint128_P(0);
    int32 shift = PG_GETARG_INT32(1);  // Number of bits to shift
    uint128 *result;

    result = (uint128 *) palloc(sizeof(uint128));
    *result = *a >> shift;  // Bitwise shift right

    PG_RETURN_Uint128_P(result);
}

DEFINE_UINT128_BITWISE_FUNCTIONS(xor, uint16_xor);
DEFINE_UINT128_BITWISE_FUNCTIONS(and, uint16_and);
DEFINE_UINT128_BITWISE_FUNCTIONS(or, uint16_or);
DEFINE_UINT128_BITWISE_FUNCTIONS(shl, uint16_shl);
DEFINE_UINT128_BITWISE_FUNCTIONS(shr, uint16_shr);

// Cast ops

Datum uint16_from_int2(PG_FUNCTION_ARGS) {
    int16 a = PG_GETARG_INT16(0);
    uint128 *result;

    result = (uint128 *) palloc(sizeof(uint128));
    *result = (uint128)a;  // Convert int2 to uint128

    PG_RETURN_Uint128_P(result);
}

Datum uint16_from_int4(PG_FUNCTION_ARGS) {
    int32 a = PG_GETARG_INT32(0);
    uint128 *result;

    result = (uint128 *) palloc(sizeof(uint128));
    *result = (uint128)a;  // Convert int4 to uint128

    PG_RETURN_Uint128_P(result);
}

Datum uint16_from_int8(PG_FUNCTION_ARGS) {
    int64 a = PG_GETARG_INT64(0);
    uint128 *result;

    result = (uint128 *) palloc(sizeof(uint128));
    *result = (uint128)a;  // Convert int8 to uint128

    PG_RETURN_Uint128_P(result);
}

Datum uint16_to_int2(PG_FUNCTION_ARGS) {
    uint128 *a = PG_GETARG_Uint128_P(0);
    int16 result;

    // Check for overflow
    if (*a > INT16_MAX) {
        ereport(ERROR,
                (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                 errmsg("uint128 value exceeds int2 range")));
    }

    result = (int16)*a;  // Safe to cast
    PG_RETURN_INT16(result);
}

Datum uint16_to_int4(PG_FUNCTION_ARGS) {
    uint128 *a = PG_GETARG_Uint128_P(0);
    int32 result;

    // Check for overflow
    if (*a > INT32_MAX) {
        ereport(ERROR,
                (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                 errmsg("uint128 value exceeds int4 range")));
    }

    result = (int32)*a;  // Safe to cast
    PG_RETURN_INT32(result);
}

Datum uint16_to_int8(PG_FUNCTION_ARGS) {
    uint128 *a = PG_GETARG_Uint128_P(0);
    int64 result;

    // Check for overflow
    if (*a > INT64_MAX) {
        ereport(ERROR,
                (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                 errmsg("uint128 value exceeds int8 range")));
    }

    result = (int64)*a;  // Safe to cast
    PG_RETURN_INT64(result);
}

// Special cast to UUID and back

Datum uint16_from_uuid(PG_FUNCTION_ARGS)
{
    pg_uuid_t *uuid = PG_GETARG_UUID_P(0);
    uint128 *result = (uint128 *)palloc(sizeof(uint128));

    *result = be128toh(*(uint128*)(uuid->data));

    PG_RETURN_Uint128_P(result);
}

Datum uint16_to_uuid(PG_FUNCTION_ARGS)
{
    uint128 *uint_value = PG_GETARG_Uint128_P(0);
    pg_uuid_t *uuid = (pg_uuid_t *)palloc(sizeof(pg_uuid_t));

    *(uint128*)(uuid->data) = htobe128(*uint_value);
    
    PG_RETURN_UUID_P(uuid);
}
