#include "postgres.h"
#include "fmgr.h"

#define DEFINE_UINT128_CMP_FUNCTION(op, funcname, inttype, casttype) \
PG_FUNCTION_INFO_V1(funcname); \
Datum funcname(PG_FUNCTION_ARGS) \
{ \
    inttype b = PG_GETARG_##casttype(1); \
    return uint16_##op##_int(fcinfo, (int64)b); \
}

#define DEFINE_UINT128_CMP_FUNCTIONS(op, funcname_prefix) \
    DEFINE_UINT128_CMP_FUNCTION(op, CppConcat(funcname_prefix, _int2), int16, INT16); \
    DEFINE_UINT128_CMP_FUNCTION(op, CppConcat(funcname_prefix, _int4), int32, INT32); \
    DEFINE_UINT128_CMP_FUNCTION(op, CppConcat(funcname_prefix, _int8), int64, INT64);

#define DEFINE_UINT128_ARITHMETIC_FUNCTION(op, funcname, inttype, casttype) \
PG_FUNCTION_INFO_V1(funcname); \
Datum funcname(PG_FUNCTION_ARGS) \
{ \
    inttype b = PG_GETARG_##casttype(1); \
    return uint16_##op##_int(fcinfo, (int64)b); \
}

#define DEFINE_UINT128_ARITHMETIC_FUNCTIONS(op, funcname_prefix) \
    DEFINE_UINT128_ARITHMETIC_FUNCTION(op, CppConcat(funcname_prefix, _int2), int16, INT16); \
    DEFINE_UINT128_ARITHMETIC_FUNCTION(op, CppConcat(funcname_prefix, _int4), int32, INT32); \
    DEFINE_UINT128_ARITHMETIC_FUNCTION(op, CppConcat(funcname_prefix, _int8), int64, INT64);


#define DEFINE_UINT128_BITWISE_FUNCTION(op, funcname, inttype, casttype) \
PG_FUNCTION_INFO_V1(funcname); \
Datum funcname(PG_FUNCTION_ARGS) \
{ \
    inttype b = PG_GETARG_##casttype(1); \
    return uint16_##op##_int(fcinfo, (int64)b); \
}

#define DEFINE_UINT128_BITWISE_FUNCTIONS(op, funcname_prefix) \
    DEFINE_UINT128_BITWISE_FUNCTION(op, CppConcat(funcname_prefix, _int2), int16, INT16); \
    DEFINE_UINT128_BITWISE_FUNCTION(op, CppConcat(funcname_prefix, _int4), int32, INT32); \
    DEFINE_UINT128_BITWISE_FUNCTION(op, CppConcat(funcname_prefix, _int8), int64, INT64);



static int uint128_internal_cmp(const uint128 *arg1, const uint128 *arg2)
{
    if (*arg1 < *arg2) return -1; // arg1 is less than arg2
    if (*arg1 > *arg2) return 1;  // arg1 is greater than arg2

    return 0;                     // arg1 is equal to arg2
}

static inline Datum uint16_eq_int(PG_FUNCTION_ARGS, int64 val2)
{
	uint128		*val1 = PG_GETARG_Uint128_P(0);

    if (val2 < 0) {
        PG_RETURN_BOOL(false);
    }
    
	PG_RETURN_BOOL(*val1 == val2);
}

static inline Datum uint16_ne_int(PG_FUNCTION_ARGS, int64 val2)
{
	uint128		*val1 = PG_GETARG_Uint128_P(0);

    if (val2 < 0) {
        PG_RETURN_BOOL(true);
    }
    
	PG_RETURN_BOOL(*val1 != val2);
}

static inline Datum uint16_lt_int(PG_FUNCTION_ARGS, int64 val2)
{
	uint128		*val1 = PG_GETARG_Uint128_P(0);

    if (val2 < 0) {
        PG_RETURN_BOOL(false);
    }
    
	PG_RETURN_BOOL(*val1 < val2);
}

static inline Datum uint16_gt_int(PG_FUNCTION_ARGS, int64 val2)
{
	uint128		*val1 = PG_GETARG_Uint128_P(0);

    if (val2 < 0) {
        PG_RETURN_BOOL(true);
    }
    
	PG_RETURN_BOOL(*val1 > val2);
}

static inline Datum uint16_le_int(PG_FUNCTION_ARGS, int64 val2)
{
	uint128		*val1 = PG_GETARG_Uint128_P(0);

    if (val2 < 0) {
        PG_RETURN_BOOL(false);
    }
    
	PG_RETURN_BOOL(*val1 <= val2);
}

static inline Datum uint16_ge_int(PG_FUNCTION_ARGS, int64 val2)
{
	uint128		*val1 = PG_GETARG_Uint128_P(0);

    if (val2 < 0) {
        PG_RETURN_BOOL(true);
    }
    
	PG_RETURN_BOOL(*val1 >= val2);
}


static inline Datum uint16_add_int(PG_FUNCTION_ARGS, int64 b)
{
	uint128		*a = PG_GETARG_Uint128_P(0);
	uint128		*result;

    if (b == 0) {
        PG_RETURN_Uint128_P(a);
    }

    // Negation case
    if (b < 0) {
        b = -b;
    
        if (*a < (uint128)b) {
            ereport(ERROR,
                (
                    errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                    errmsg("uint16 out of range")
                )
            );
        }

        result = (uint128 *)palloc(sizeof(uint128));

        *result = *a - b;

        PG_RETURN_Uint128_P(result);
    }

    // Check for overflow
    if (*a > UINT128_MAX - (uint128)b) {
        ereport(ERROR,
            (
                errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                errmsg("uint16 out of range")
            )
        );
    }

    result = (uint128*)palloc(sizeof(uint128));
    *result = *a + b;

    PG_RETURN_Uint128_P(result);
}

static inline Datum uint16_sub_int(PG_FUNCTION_ARGS, int64 b)
{
	uint128		*a = PG_GETARG_Uint128_P(0);
	uint128		*result;

    if (b == 0) {
        PG_RETURN_Uint128_P(a);
    }

    // Addition case
    if (b < 0) {
        b = -b;

         // Check for overflow
        if (*a > UINT128_MAX - (uint128)b) {
            ereport(ERROR,
                (
                    errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                    errmsg("uint16 out of range")
                )
            );
        }

        result = (uint128*)palloc(sizeof(uint128));
        *result = *a + b;

        PG_RETURN_Uint128_P(result);
    }

    // Check for overflow
    if ((uint128)b > *a) {
        ereport(ERROR,
            (
                errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                errmsg("uint16 out of range")
            )
        );
    }

    result = (uint128*)palloc(sizeof(uint128));
    *result = *a - b;

    PG_RETURN_Uint128_P(result);
}

static inline Datum uint16_mul_int(PG_FUNCTION_ARGS, int64 b)
{
    uint128		*a = PG_GETARG_Uint128_P(0);
	uint128		*result;

    if (b < 0) {
        ereport(ERROR,
            (
                errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                errmsg("uint16 cannot be multiplied by negative int")
            )
        );
    }

    if (*a == 0 || b == 0) {
        PG_RETURN_Uint128_P(a);
    }

    // Check for overflow
    if (*a > UINT128_MAX / (uint128)b) {
        ereport(ERROR,
            (
                errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                errmsg("uint16 out of range")
            )
        );
    }

    result = (uint128*)palloc(sizeof(uint128));
    *result = *a * b;

    PG_RETURN_Uint128_P(result);
}

static inline Datum uint16_div_int(PG_FUNCTION_ARGS, int64 b)
{
    uint128		*a = PG_GETARG_Uint128_P(0);
	uint128		*result;

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
                errmsg("uint16 cannot be multiplied by negative int")
            )
        );
    }

    if (*a == 0) {
        PG_RETURN_Uint128_P(a);
    }

    result = (uint128*)palloc(sizeof(uint128));
    *result = *a / b;

    PG_RETURN_Uint128_P(result);
}

static inline Datum uint16_mod_int(PG_FUNCTION_ARGS, int64 b)
{
    uint128		*a = PG_GETARG_Uint128_P(0);
	uint128		*result;

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
                errmsg("uint16 cannot be multiplied by negative int")
            )
        );
    }

    result = (uint128*)palloc(sizeof(uint128));
    *result = *a % b;

    PG_RETURN_Uint128_P(result);
}


static inline Datum uint16_xor_int(PG_FUNCTION_ARGS, int64 b)
{
	uint128		*a = PG_GETARG_Uint128_P(0);
	uint128		*result;

    result = (uint128 *) palloc(sizeof(uint128));
    *result = *a ^ (uint128)b;

    PG_RETURN_Uint128_P(result);
}

static inline Datum uint16_and_int(PG_FUNCTION_ARGS, int64 b)
{
	uint128		*a = PG_GETARG_Uint128_P(0);
	uint128		*result;

    result = (uint128 *) palloc(sizeof(uint128));
    *result = *a & (uint128)b;

    PG_RETURN_Uint128_P(result);
}

static inline Datum uint16_or_int(PG_FUNCTION_ARGS, int64 b)
{
	uint128		*a = PG_GETARG_Uint128_P(0);
	uint128		*result;

    result = (uint128 *) palloc(sizeof(uint128));
    *result = *a | (uint128)b;

    PG_RETURN_Uint128_P(result);
}

static inline Datum uint16_shl_int(PG_FUNCTION_ARGS, int64 b)
{
	uint128		*a = PG_GETARG_Uint128_P(0);
	uint128		*result;

    result = (uint128 *) palloc(sizeof(uint128));
    *result = *a << b;

    PG_RETURN_Uint128_P(result);
}

static inline Datum uint16_shr_int(PG_FUNCTION_ARGS, int64 b)
{
	uint128		*a = PG_GETARG_Uint128_P(0);
	uint128		*result;

    result = (uint128 *) palloc(sizeof(uint128));
    *result = *a >> b;

    PG_RETURN_Uint128_P(result);
}
