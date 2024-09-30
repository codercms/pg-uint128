#include "postgres.h"
//#include "uint_utils.h"

#define DEFINE_UINT64_CMP_FUNCTION(op, funcname, inttype, casttype) \
PG_FUNCTION_INFO_V1(funcname); \
Datum funcname(PG_FUNCTION_ARGS) \
{ \
    inttype b = PG_GETARG_##casttype(1); \
    return uint8_##op##_int(fcinfo, (int64)b); \
}

#define DEFINE_UINT64_UINT128_CMP_FUNCTION(op, funcname, inttype, casttype) \
PG_FUNCTION_INFO_V1(funcname); \
Datum funcname(PG_FUNCTION_ARGS) \
{ \
    inttype *b = PG_GETARG_##casttype(1); \
    if (*b > UINT64_MAX) { \
         ereport(ERROR, \
                (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), \
                 errmsg("uint16 value exceeds uint8 range"))); \
    } \
    return uint8_##op##_int(fcinfo, (int64)*b); \
}

// TODO: Need to fix comparsion with uint128, because it will overflow

#define DEFINE_UINT64_CMP_FUNCTIONS(op, funcname_prefix) \
    DEFINE_UINT64_CMP_FUNCTION(op, CppConcat(funcname_prefix, _int2), int16, INT16); \
    DEFINE_UINT64_CMP_FUNCTION(op, CppConcat(funcname_prefix, _int4), int32, INT32); \
    DEFINE_UINT64_CMP_FUNCTION(op, CppConcat(funcname_prefix, _int8), int64, INT64); \
    DEFINE_UINT64_UINT128_CMP_FUNCTION(op, CppConcat(funcname_prefix, _uint16), uint128, Uint128_P);

#define DEFINE_UINT64_ARITHMETIC_FUNCTION(op, funcname, inttype, casttype) \
PG_FUNCTION_INFO_V1(funcname); \
Datum funcname(PG_FUNCTION_ARGS) \
{ \
    inttype b = PG_GETARG_##casttype(1); \
    return uint8_##op##_int(fcinfo, (int64)b); \
}

#define DEFINE_UINT64_UINT128_ARITHMETIC_FUNCTION(op, funcname, inttype, casttype) \
PG_FUNCTION_INFO_V1(funcname); \
Datum funcname(PG_FUNCTION_ARGS) \
{ \
    inttype *b = PG_GETARG_##casttype(1); \
    if (*b > UINT64_MAX) { \
         ereport(ERROR, \
                (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), \
                 errmsg("uint16 value exceeds uint8 range"))); \
    } \
    return uint8_##op##_int(fcinfo, (int64)*b); \
}

#define DEFINE_UINT64_ARITHMETIC_FUNCTIONS(op, funcname_prefix) \
    DEFINE_UINT64_ARITHMETIC_FUNCTION(op, CppConcat(funcname_prefix, _int2), int16, INT16); \
    DEFINE_UINT64_ARITHMETIC_FUNCTION(op, CppConcat(funcname_prefix, _int4), int32, INT32); \
    DEFINE_UINT64_ARITHMETIC_FUNCTION(op, CppConcat(funcname_prefix, _int8), int64, INT64); \
    DEFINE_UINT64_UINT128_ARITHMETIC_FUNCTION(op, CppConcat(funcname_prefix, _uint16), uint128, Uint128_P);


#define DEFINE_UINT64_BITWISE_FUNCTION(op, funcname, inttype, casttype) \
PG_FUNCTION_INFO_V1(funcname); \
Datum funcname(PG_FUNCTION_ARGS) \
{ \
    inttype b = PG_GETARG_##casttype(1); \
    return uint8_##op##_int(fcinfo, (int64)b); \
}

#define DEFINE_UINT64_UINT128_BITWISE_FUNCTION(op, funcname, inttype, casttype) \
PG_FUNCTION_INFO_V1(funcname); \
Datum funcname(PG_FUNCTION_ARGS) \
{ \
    inttype *b = PG_GETARG_##casttype(1); \
    if (*b > UINT64_MAX) { \
         ereport(ERROR, \
                (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), \
                 errmsg("uint16 value exceeds uint8 range"))); \
    } \
    return uint8_##op##_int(fcinfo, (int64)*b); \
}


#define DEFINE_UINT64_BITWISE_FUNCTIONS(op, funcname_prefix) \
    DEFINE_UINT64_BITWISE_FUNCTION(op, CppConcat(funcname_prefix, _int2), int16, INT16); \
    DEFINE_UINT64_BITWISE_FUNCTION(op, CppConcat(funcname_prefix, _int4), int32, INT32); \
    DEFINE_UINT64_BITWISE_FUNCTION(op, CppConcat(funcname_prefix, _int8), int64, INT64); \
    DEFINE_UINT64_UINT128_BITWISE_FUNCTION(op, CppConcat(funcname_prefix, _uint16), uint128, Uint128_P);


static inline Datum uint8_eq_int(PG_FUNCTION_ARGS, int64 val2)
{
	uint64		val1 = PG_GETARG_UINT64(0);

    if (val2 < 0) {
        PG_RETURN_BOOL(false);
    }
    
	PG_RETURN_BOOL(val1 == val2);
}

static inline Datum uint8_ne_int(PG_FUNCTION_ARGS, int64 val2)
{
	uint64		val1 = PG_GETARG_UINT64(0);

    if (val2 < 0) {
        PG_RETURN_BOOL(true);
    }
    
	PG_RETURN_BOOL(val1 != val2);
}

static inline Datum uint8_lt_int(PG_FUNCTION_ARGS, int64 val2)
{
	uint64		val1 = PG_GETARG_UINT64(0);

    if (val2 < 0) {
        PG_RETURN_BOOL(false);
    }
    
	PG_RETURN_BOOL(val1 < val2);
}

static inline Datum uint8_gt_int(PG_FUNCTION_ARGS, int64 val2)
{
	uint64		val1 = PG_GETARG_UINT64(0);

    if (val2 < 0) {
        PG_RETURN_BOOL(true);
    }
    
	PG_RETURN_BOOL(val1 > val2);
}

static inline Datum uint8_le_int(PG_FUNCTION_ARGS, int64 val2)
{
	uint64		val1 = PG_GETARG_UINT64(0);

    if (val2 < 0) {
        PG_RETURN_BOOL(false);
    }
    
	PG_RETURN_BOOL(val1 <= val2);
}

static inline Datum uint8_ge_int(PG_FUNCTION_ARGS, int64 val2)
{
	uint64		val1 = PG_GETARG_UINT64(0);

    if (val2 < 0) {
        PG_RETURN_BOOL(true);
    }
    
	PG_RETURN_BOOL(val1 >= val2);
}


static inline Datum uint8_add_int(PG_FUNCTION_ARGS, int64 b)
{
	uint64		a = PG_GETARG_UINT64(0);
	uint64		result;

    if (b == 0) {
        PG_RETURN_UINT64(a);
    }

    // Negation case
    if (b < 0) {
        b = -b;
    
        if (a < (uint64)b) {
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

    // Check for overflow
    if (a > UINT64_MAX - (uint64)b) {
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

static inline Datum uint8_sub_int(PG_FUNCTION_ARGS, int64 b)
{
	uint64		a = PG_GETARG_UINT64(0);
	uint64		result;

    if (b == 0) {
        PG_RETURN_UINT64(a);
    }

    // Addition case
    if (b < 0) {
        b = -b;

         // Check for overflow
        if (a > UINT64_MAX - (uint64)b) {
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

    // Check for overflow
    if ((uint64)b > a) {
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

static inline Datum uint8_mul_int(PG_FUNCTION_ARGS, int64 b)
{
    uint64		a = PG_GETARG_UINT64(0);
	uint64		result;

    if (b < 0) {
        ereport(ERROR,
            (
                errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                errmsg("uint8 cannot be multiplied by negative int")
            )
        );
    }

    if (a == 0 || b == 0) {
        PG_RETURN_UINT64(a);
    }

    // Check for overflow
    if (a > UINT64_MAX / (uint64)b) {
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

static inline Datum uint8_div_int(PG_FUNCTION_ARGS, int64 b)
{
    uint64		a = PG_GETARG_UINT64(0);
	uint64		result;

    if (b == 0) {
        ereport(ERROR,
            (
                errcode(ERRCODE_DIVISION_BY_ZERO),
                errmsg("division by zero")
            )
        );
    }

    if (b < 0) {
        ereport(ERROR,
            (
                errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                errmsg("uint8 cannot be multiplied by negative int")
            )
        );
    }

    if (a == 0) {
        PG_RETURN_UINT64(a);
    }

    result = a / b;

    PG_RETURN_UINT64(result);
}

static inline Datum uint8_mod_int(PG_FUNCTION_ARGS, int64 b)
{
    uint64		a = PG_GETARG_UINT64(0);
	uint64		result;

    if (b == 0) {
        ereport(ERROR,
            (
                errcode(ERRCODE_DIVISION_BY_ZERO),
                errmsg("division by zero")
            )
        );
    }

    if (b < 0) {
        ereport(ERROR,
            (
                errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                errmsg("uint8 cannot be multiplied by negative int")
            )
        );
    }

    result = a % b;

    PG_RETURN_UINT64(result);
}


static inline Datum uint8_xor_int(PG_FUNCTION_ARGS, int64 b)
{
	uint64		a = PG_GETARG_UINT64(0);
	uint64		result;

    result = a ^ (uint64)b;

    PG_RETURN_UINT64(result);
}

static inline Datum uint8_and_int(PG_FUNCTION_ARGS, int64 b)
{
	uint64		a = PG_GETARG_UINT64(0);
	uint64		result;

    result = a & (uint64)b;

    PG_RETURN_UINT64(result);
}

static inline Datum uint8_or_int(PG_FUNCTION_ARGS, int64 b)
{
	uint64		a = PG_GETARG_UINT64(0);
	uint64		result;

    result = a | (uint64)b;

    PG_RETURN_UINT64(result);
}

static inline Datum uint8_shl_int(PG_FUNCTION_ARGS, int64 b)
{
	uint64		a = PG_GETARG_UINT64(0);
	uint64		result;

    result = a << b;

    PG_RETURN_UINT64(result);
}

static inline Datum uint8_shr_int(PG_FUNCTION_ARGS, int64 b)
{
	uint64		a = PG_GETARG_UINT64(0);
	uint64		result;

    result = a >> b;

    PG_RETURN_UINT64(result);
}
