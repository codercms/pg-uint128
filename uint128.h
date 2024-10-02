#ifndef UINT128_H
#define UINT128_H

#include "postgres.h"
#include "fmgr.h"

#define AllocUint128() ((uint128*)palloc(sizeof(uint128)))

#define DEFINE_UINT16_SELF_OVERFLOW_ARITHMETIC_FUNC(opname, overflow_fn) \
    PG_FUNCTION_INFO_V1(uint16_##opname##_uint16); \
    Datum uint16_##opname##_uint16(PG_FUNCTION_ARGS) { \
        uint128 *a = PG_GETARG_UINT128_P(0); \
        uint128 *b = PG_GETARG_UINT128_P(1); \
        uint128 result; \
        uint128 *resultP; \
        \
        if (overflow_fn(*a, *b, &result)) { \
            OUT_OF_RANGE_ERR(uint16); \
        } \
        resultP = AllocUint128(); \
        *resultP = result; \
        PG_RETURN_UINT128_P(resultP); \
    }

#define DEFINE_UINT16_SELF_DIV_ARITHMETIC_FUNC(opname, operator) \
    PG_FUNCTION_INFO_V1(uint16_##opname##_uint16); \
    Datum uint16_##opname##_uint16(PG_FUNCTION_ARGS) { \
        uint128 *a = PG_GETARG_UINT128_P(0); \
        uint128 *b = PG_GETARG_UINT128_P(1); \
        uint128 *result = NULL; \
        \
        if (*b == 0) { \
            DIVISION_BY_ZERO_ERR; \
        } \
        \
        result = AllocUint128(); \
        *result = *a operator *b; \
        PG_RETURN_UINT128_P(result); \
    }

#define DEFINE_UINT16_SELF_COMPARISON_FUNC(opname, operator) \
    PG_FUNCTION_INFO_V1(uint16_##opname##_uint16); \
    Datum uint16_##opname##_uint16(PG_FUNCTION_ARGS) { \
        uint128 *a = PG_GETARG_UINT128_P(0); \
        uint128 *b = PG_GETARG_UINT128_P(1); \
        PG_RETURN_BOOL(*a operator *b); \
    }

#define DEFINE_UINT16_SELF_BITWISE_FUNC(opname, operator) \
    PG_FUNCTION_INFO_V1(uint16_##opname##_uint16); \
    Datum uint16_##opname##_uint16(PG_FUNCTION_ARGS) { \
        uint128 *a = PG_GETARG_UINT128_P(0); \
        uint128 *b = PG_GETARG_UINT128_P(1); \
        uint128 *result = AllocUint128(); \
        *result = *a operator *b; \
        PG_RETURN_UINT128_P(result); \
    }

#define DEFINE_UINT16_SELF_BITWISE_SHIFT_FUNC(opname, operator) \
    PG_FUNCTION_INFO_V1(uint16_##opname); \
    Datum uint16_##opname(PG_FUNCTION_ARGS) { \
        uint128 *a = PG_GETARG_UINT128_P(0); \
        int32 shift = PG_GETARG_INT32(1); \
        uint128 *result = AllocUint128(); \
        *result = *a operator shift; \
        PG_RETURN_UINT128_P(result); \
    }

#define DEFINE_UINT16_FROM_INT_FUNC(pgtype, ctype, pg_getarg_macro) \
    PG_FUNCTION_INFO_V1(uint16_from_##pgtype); \
    Datum uint16_from_##pgtype(PG_FUNCTION_ARGS) { \
        ctype a = pg_getarg_macro(0); \
        uint128 *result = AllocUint128(); \
        *result = (uint128)a;  /* Convert to uint128 */ \
        PG_RETURN_UINT128_P(result); \
    }

#define DEFINE_UINT16_TO_INT_FUNC(pgtype, ctype, max_value, pg_return_macro) \
    PG_FUNCTION_INFO_V1(uint16_to_##pgtype); \
    Datum uint16_to_##pgtype(PG_FUNCTION_ARGS) { \
        uint128 *a = PG_GETARG_UINT128_P(0); \
        ctype result; \
        \
        /* Check for overflow */ \
        if (*a > max_value) { \
            ereport(ERROR, \
                    (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), \
                     errmsg("uint16 value exceeds " #pgtype " range"))); \
        } \
        \
        result = (ctype)*a;  /* Safe to cast */ \
        pg_return_macro(result); \
    }

#define DEFINE_UINT16_CMP_INT_FUNC(pgtype, ctype, pg_getarg_macro, opname, operator) \
    PG_FUNCTION_INFO_V1(uint16_##opname##_##pgtype); \
    Datum uint16_##opname##_##pgtype(PG_FUNCTION_ARGS) { \
        uint128 *a = PG_GETARG_UINT128_P(0); \
        ctype    b = pg_getarg_macro(1); \
        \
        PG_RETURN_BOOL(*a operator b); \
    }

#define DEFINE_UINT16_CMP_INT_FUNCS(opname, operator) \
    DEFINE_UINT16_CMP_INT_FUNC(int2, int16, PG_GETARG_INT16, opname, operator); \
    DEFINE_UINT16_CMP_INT_FUNC(int4, int32, PG_GETARG_INT32, opname, operator); \
    DEFINE_UINT16_CMP_INT_FUNC(int8, int64, PG_GETARG_INT64, opname, operator); \
    DEFINE_UINT16_CMP_INT_FUNC(uint8, uint64, PG_GETARG_UINT64, opname, operator);

#define DEFINE_UINT16_INT_OVERFLOW_ARITHMETIC_FUNC(pgtype, ctype, pg_getarg_macro, opname, overflow_fn) \
    PG_FUNCTION_INFO_V1(uint16_##opname##_##pgtype); \
    Datum uint16_##opname##_##pgtype(PG_FUNCTION_ARGS) { \
        uint128 *a = PG_GETARG_UINT128_P(0); \
        ctype bRaw = pg_getarg_macro(1); \
        uint128 b = (uint128)bRaw; \
        uint128 result; \
        uint128 *resultP; \
        \
        if (overflow_fn(*a, b, &result)) { \
            OUT_OF_RANGE_ERR(uint16); \
        } \
        resultP = AllocUint128(); \
        *resultP = result; \
        PG_RETURN_UINT128_P(resultP); \
    }

#define DEFINE_UINT16_INT_OVERFLOW_ARITHMETIC_FUNCS(opname, overflow_fn) \
    DEFINE_UINT16_INT_OVERFLOW_ARITHMETIC_FUNC(int2, int16, PG_GETARG_INT16, opname, overflow_fn); \
    DEFINE_UINT16_INT_OVERFLOW_ARITHMETIC_FUNC(int4, int32, PG_GETARG_INT32, opname, overflow_fn); \
    DEFINE_UINT16_INT_OVERFLOW_ARITHMETIC_FUNC(int8, int64, PG_GETARG_INT64, opname, overflow_fn); \
    DEFINE_UINT16_INT_OVERFLOW_ARITHMETIC_FUNC(uint8, uint64, PG_GETARG_UINT64, opname, overflow_fn);

#define DEFINE_UINT16_INT_DIV_ARITHMETIC_FUNC(pgtype, ctype, pg_getarg_macro, opname, operator) \
    PG_FUNCTION_INFO_V1(uint16_##opname##_##pgtype); \
    Datum uint16_##opname##_##pgtype(PG_FUNCTION_ARGS) { \
        uint128 *a = PG_GETARG_UINT128_P(0); \
        ctype    b = pg_getarg_macro(1); \
        uint128 *result = NULL; \
        \
        if (b == 0) { \
            DIVISION_BY_ZERO_ERR; \
        } \
        \
        result = AllocUint128(); \
        *result = *a operator ((uint128)b); \
        PG_RETURN_UINT128_P(result); \
    }

#define DEFINE_UINT16_INT_DIV_ARITHMETIC_FUNCS(opname, operator) \
    DEFINE_UINT16_INT_DIV_ARITHMETIC_FUNC(int2, int16, PG_GETARG_INT16, opname, operator); \
    DEFINE_UINT16_INT_DIV_ARITHMETIC_FUNC(int4, int32, PG_GETARG_INT32, opname, operator); \
    DEFINE_UINT16_INT_DIV_ARITHMETIC_FUNC(int8, int64, PG_GETARG_INT64, opname, operator); \
    DEFINE_UINT16_INT_DIV_ARITHMETIC_FUNC(uint8, uint64, PG_GETARG_UINT64, opname, operator);

#define DEFINE_UINT16_INT_BITWISE_FUNC(pgtype, ctype, pg_getarg_macro, opname, operator) \
    PG_FUNCTION_INFO_V1(uint16_##opname##_##pgtype); \
    Datum uint16_##opname##_##pgtype(PG_FUNCTION_ARGS) { \
        uint128 *a = PG_GETARG_UINT128_P(0); \
        ctype    b = pg_getarg_macro(1); \
        uint128 *result = AllocUint128(); \
        *result = *a operator ((uint128)b); \
        PG_RETURN_UINT128_P(result); \
    }

#define DEFINE_UINT16_INT_BITWISE_FUNCS(opname, operator) \
    DEFINE_UINT16_INT_BITWISE_FUNC(int2, int16, PG_GETARG_INT16, opname, operator); \
    DEFINE_UINT16_INT_BITWISE_FUNC(int4, int32, PG_GETARG_INT32, opname, operator); \
    DEFINE_UINT16_INT_BITWISE_FUNC(int8, int64, PG_GETARG_INT64, opname, operator); \
    DEFINE_UINT16_INT_BITWISE_FUNC(uint8, uint64, PG_GETARG_UINT64, opname, operator);

static int uint128_internal_cmp(const uint128 *arg1, const uint128 *arg2)
{
    if (*arg1 < *arg2) return -1; // arg1 is less than arg2
    if (*arg1 > *arg2) return 1; // arg1 is greater than arg2

    return 0; // arg1 is equal to arg2
}

#endif
