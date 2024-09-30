#include "postgres.h"
#include "fmgr.h"

#define DEFINE_UINT8_SELF_OVERFLOW_ARITHMETIC_FUNC(opname, overflow_fn) \
    PG_FUNCTION_INFO_V1(uint8_##opname); \
    Datum uint8_##opname(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        uint64 b = PG_GETARG_UINT64(1); \
        uint64 result; \
        \
        if (overflow_fn(a, b, &result)) { \
            OUT_OF_RANGE_ERR(uint8); \
        } \
        PG_RETURN_UINT64(result); \
    }

#define DEFINE_UINT8_SELF_DIV_ARITHMETIC_FUNC(opname, operator) \
    PG_FUNCTION_INFO_V1(uint8_##opname); \
    Datum uint8_##opname(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        uint64 b = PG_GETARG_UINT64(1); \
        \
        if (b == 0) { \
            DIVISION_BY_ZERO_ERR; \
        } \
        \
        PG_RETURN_UINT64(a operator b); \
    }

#define DEFINE_UINT8_SELF_COMPARISON_FUNC(opname, operator) \
    PG_FUNCTION_INFO_V1(uint8_##opname); \
    Datum uint8_##opname(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        uint64 b = PG_GETARG_UINT64(1); \
        PG_RETURN_BOOL(a operator b); \
    }

#define DEFINE_UINT8_SELF_BITWISE_FUNC(opname, operator) \
    PG_FUNCTION_INFO_V1(uint8_##opname); \
    Datum uint8_##opname(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        uint64 b = PG_GETARG_UINT64(1); \
        PG_RETURN_UINT64(a operator b); \
    }

#define DEFINE_UINT8_SELF_BITWISE_SHIFT_FUNC(opname, operator) \
    PG_FUNCTION_INFO_V1(uint8_##opname); \
    Datum uint8_##opname(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        int32 shift = PG_GETARG_INT32(1); \
        PG_RETURN_UINT64(a operator shift); \
    }

#define DEFINE_UINT8_FROM_INT_FUNC(pgtype, ctype, pg_getarg_macro) \
    PG_FUNCTION_INFO_V1(uint8_from_##pgtype); \
    Datum uint8_from_##pgtype(PG_FUNCTION_ARGS) { \
        ctype a = pg_getarg_macro(0); \
        PG_RETURN_UINT64((uint64)a); \
    }

#define DEFINE_UINT8_TO_INT_FUNC(pgtype, ctype, max_value, pg_return_macro) \
    PG_FUNCTION_INFO_V1(uint8_to_##pgtype); \
    Datum uint8_to_##pgtype(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        ctype result; \
        \
        /* Check for overflow */ \
        if (a > max_value) { \
            ereport(ERROR, \
                    (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), \
                     errmsg("uint8 value exceeds " #pgtype " range"))); \
        } \
        \
        result = (ctype)a;  /* Safe to cast */ \
        pg_return_macro(result); \
    }

#define DEFINE_UINT8_CMP_INT_FUNC(pgtype, ctype, pg_getarg_macro, opname, operator) \
    PG_FUNCTION_INFO_V1(uint8_##opname##_##pgtype); \
    Datum uint8_##opname##_##pgtype(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        ctype  b = pg_getarg_macro(1); \
        \
        PG_RETURN_BOOL(a operator b); \
    }

#define DEFINE_UINT8_CMP_INT_FUNCS(opname, operator) \
    DEFINE_UINT8_CMP_INT_FUNC(int2, int16, PG_GETARG_INT16, opname, operator); \
    DEFINE_UINT8_CMP_INT_FUNC(int4, int32, PG_GETARG_INT32, opname, operator); \
    DEFINE_UINT8_CMP_INT_FUNC(int8, int64, PG_GETARG_INT64, opname, operator); \
    DEFINE_UINT8_CMP_INT_FUNC(uint16, uint128, *PG_GETARG_Uint128_P, opname, operator);

#define DEFINE_UINT8_INT_OVERFLOW_ARITHMETIC_FUNC(pgtype, ctype, pg_getarg_macro, opname, overflow_fn) \
    PG_FUNCTION_INFO_V1(uint8_##opname##_##pgtype); \
    Datum uint8_##opname##_##pgtype(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        ctype bRaw = pg_getarg_macro(1); \
        uint128 b = (uint8)bRaw; \
        uint64 result; \
        \
        if (overflow_fn(a, b, &result)) { \
            OUT_OF_RANGE_ERR(uint8); \
        } \
        PG_RETURN_UINT64(result); \
    }

#define DEFINE_UINT8_INT_OVERFLOW_ARITHMETIC_FUNCS(opname, overflow_fn) \
    DEFINE_UINT8_INT_OVERFLOW_ARITHMETIC_FUNC(int2, int16, PG_GETARG_INT16, opname, overflow_fn); \
    DEFINE_UINT8_INT_OVERFLOW_ARITHMETIC_FUNC(int4, int32, PG_GETARG_INT32, opname, overflow_fn); \
    DEFINE_UINT8_INT_OVERFLOW_ARITHMETIC_FUNC(int8, int64, PG_GETARG_INT64, opname, overflow_fn); \
    DEFINE_UINT8_INT_OVERFLOW_ARITHMETIC_FUNC(uint16, uint128, *PG_GETARG_Uint128_P, opname, overflow_fn);

#define DEFINE_UINT8_INT_DIV_ARITHMETIC_FUNC(pgtype, ctype, pg_getarg_macro, opname, operator) \
    PG_FUNCTION_INFO_V1(uint8_##opname##_##pgtype); \
    Datum uint8_##opname##_##pgtype(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        ctype  b = pg_getarg_macro(1); \
        \
        if (b == 0) { \
            DIVISION_BY_ZERO_ERR; \
        } \
        \
        PG_RETURN_UINT64(a operator ((uint64)b)); \
    }

#define DEFINE_UINT8_INT_DIV_ARITHMETIC_FUNCS(opname, operator) \
    DEFINE_UINT8_INT_DIV_ARITHMETIC_FUNC(int2, int16, PG_GETARG_INT16, opname, operator); \
    DEFINE_UINT8_INT_DIV_ARITHMETIC_FUNC(int4, int32, PG_GETARG_INT32, opname, operator); \
    DEFINE_UINT8_INT_DIV_ARITHMETIC_FUNC(int8, int64, PG_GETARG_INT64, opname, operator); \
    DEFINE_UINT8_INT_DIV_ARITHMETIC_FUNC(uint16, uint128, *PG_GETARG_Uint128_P, opname, operator);

#define DEFINE_UINT8_INT_BITWISE_FUNC(pgtype, ctype, pg_getarg_macro, opname, operator) \
    PG_FUNCTION_INFO_V1(uint8_##opname##_##pgtype); \
    Datum uint8_##opname##_##pgtype(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        ctype  b = pg_getarg_macro(1); \
        PG_RETURN_UINT64(a operator ((uint64)b)); \
    }

#define DEFINE_UINT8_INT_BITWISE_FUNCS(opname, operator) \
    DEFINE_UINT8_INT_BITWISE_FUNC(int2, int16, PG_GETARG_INT16, opname, operator); \
    DEFINE_UINT8_INT_BITWISE_FUNC(int4, int32, PG_GETARG_INT32, opname, operator); \
    DEFINE_UINT8_INT_BITWISE_FUNC(int8, int64, PG_GETARG_INT64, opname, operator); \
    DEFINE_UINT8_INT_BITWISE_FUNC(uint16, uint128, *PG_GETARG_Uint128_P, opname, operator);

static int uint64_internal_cmp(const uint64 arg1, const uint64 arg2)
{
    if (arg1 < arg2) return -1; // arg1 is less than arg2
    if (arg1 > arg2) return 1;  // arg1 is greater than arg2

    return 0;                     // arg1 is equal to arg2
}
