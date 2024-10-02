#ifndef UINT64_H
#define UINT64_H

#include "postgres.h"
#include "fmgr.h"
#include "misc.h"

#define DEFINE_UINT8_FROM_INT_FUNC(pgtype, ctype, pg_getarg_macro) \
    PG_FUNCTION_INFO_V1(uint8_from_##pgtype); \
    Datum uint8_from_##pgtype(PG_FUNCTION_ARGS) { \
        ctype a = pg_getarg_macro(0); \
        if (a > UINT64_MAX) { \
            OUT_OF_RANGE_ERR(uint8); \
        } \
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


// Comparison funcs

// Defines function that compares uint with uint
#define DEFINE_UINT8_CMP_UNSIGNED_INT_FUNC(pgtype, ctype, pg_getarg_macro, opname, operator, cmp_enum) \
    PG_FUNCTION_INFO_V1(uint8_##opname##_##pgtype); \
    Datum uint8_##opname##_##pgtype(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        ctype  b = pg_getarg_macro(1); \
        /* Special cases for handling negative signed integers */ \
        \
        if ((cmp_enum == CMP_LE || cmp_enum == CMP_LT || cmp_enum == CMP_EQ) && b > UINT64_MAX) { \
            return false; \
        } \
        \
        if ((cmp_enum == CMP_GE || cmp_enum == CMP_GT || cmp_enum == CMP_NE) && b > UINT64_MAX) { \
            return true; \
        } \
        \
        PG_RETURN_BOOL(a operator (uint64)b); \
    }

// Defines function that compares uint with signed int
#define DEFINE_UINT8_CMP_SIGNED_INT_FUNC(pgtype, ctype, pg_getarg_macro, opname, operator, cmp_enum) \
    PG_FUNCTION_INFO_V1(uint8_##opname##_##pgtype); \
    Datum uint8_##opname##_##pgtype(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        ctype  b = pg_getarg_macro(1); \
        /* Special cases for handling negative signed integers */ \
        \
        if ((cmp_enum == CMP_LE || cmp_enum == CMP_LT || cmp_enum == CMP_EQ) && b < 0) { \
            return false; \
        } \
        \
        if ((cmp_enum == CMP_GE || cmp_enum == CMP_GT || cmp_enum == CMP_NE) && b < 0) { \
            return true; \
        } \
        \
        PG_RETURN_BOOL(a operator (uint64)b); \
    }

// Defines function that compares signed int with uint
#define DEFINE_SIGNED_INT_CMP_UINT8_FUNC(pgtype, ctype, pg_getarg_macro, opname, operator, cmp_enum) \
    PG_FUNCTION_INFO_V1(pgtype##_##opname##_uint8); \
    Datum pgtype##_##opname##_uint8(PG_FUNCTION_ARGS) { \
        ctype  a = pg_getarg_macro(0); \
        uint64 b = PG_GETARG_UINT64(1); \
        /* Special cases for handling negative signed integers */ \
        \
        if ((cmp_enum == CMP_LE || cmp_enum == CMP_LT || cmp_enum == CMP_EQ) && a < 0) { \
            return true; \
        } \
        \
        if ((cmp_enum == CMP_GE || cmp_enum == CMP_GT || cmp_enum == CMP_NE) && a < 0) { \
            return false; \
        } \
        \
        PG_RETURN_BOOL((uint64)a operator b); \
    }

#define DEFINE_UINT8_CMP_SIGNED_AND_UNSIGNED_INT_FUNCS(opname, operator, cmp_enum) \
    DEFINE_UINT8_CMP_SIGNED_INT_FUNC(int2, int16, PG_GETARG_INT16, opname, operator, cmp_enum); \
    DEFINE_UINT8_CMP_SIGNED_INT_FUNC(int4, int32, PG_GETARG_INT32, opname, operator, cmp_enum); \
    DEFINE_UINT8_CMP_SIGNED_INT_FUNC(int8, int64, PG_GETARG_INT64, opname, operator, cmp_enum); \
    \
    DEFINE_SIGNED_INT_CMP_UINT8_FUNC(int2, int16, PG_GETARG_INT16, opname, operator, cmp_enum); \
    DEFINE_SIGNED_INT_CMP_UINT8_FUNC(int4, int32, PG_GETARG_INT32, opname, operator, cmp_enum); \
    DEFINE_SIGNED_INT_CMP_UINT8_FUNC(int8, int64, PG_GETARG_INT64, opname, operator, cmp_enum); \
    \
    DEFINE_UINT8_CMP_UNSIGNED_INT_FUNC(uint8, uint64,    PG_GETARG_UINT64,    opname, operator, cmp_enum) \
    DEFINE_UINT8_CMP_UNSIGNED_INT_FUNC(uint16, uint128, *PG_GETARG_UINT128_P, opname, operator, cmp_enum)


// Arithmetic funcs

// Defines function that performs add/sub/mul ops on uint with uint witch check of overflow
#define DEFINE_UINT8_UNSIGNED_INT_OVERFLOW_ARITHMETIC_FUNC(pgtype, ctype, pg_getarg_macro, opname, overflow_fn) \
    PG_FUNCTION_INFO_V1(uint8_##opname##_##pgtype); \
    Datum uint8_##opname##_##pgtype(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        ctype  b = pg_getarg_macro(1); \
        uint64 result; \
        \
        if (b > UINT64_MAX) { \
            OUT_OF_RANGE_ERR(uint8); \
        } \
        \
        if (overflow_fn(a, (uint64)b, &result)) { \
            OUT_OF_RANGE_ERR(uint8); \
        } \
        \
        PG_RETURN_UINT64(result); \
    }

#define DEFINE_UINT8_UNSIGNED_INT_OVERFLOW_ARITHMETIC_FUNCS(opname, overflow_fn) \
    DEFINE_UINT8_UNSIGNED_INT_OVERFLOW_ARITHMETIC_FUNC(uint8,  uint64,   PG_GETARG_UINT64,    opname, overflow_fn); \
    DEFINE_UINT8_UNSIGNED_INT_OVERFLOW_ARITHMETIC_FUNC(uint16, uint128, *PG_GETARG_UINT128_P, opname, overflow_fn);


#define DEFINE_UINT8_SIGNED_INT_OVERFLOW_ARITHMETIC_FUNC(pgtype, ctype, pg_getarg_macro, opname, overflow_fn, overflow_op) \
    PG_FUNCTION_INFO_V1(uint8_##opname##_##pgtype); \
    Datum uint8_##opname##_##pgtype(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        ctype  b = pg_getarg_macro(1); \
        uint64 result; \
        \
        if (overflow_op == OVERFLOW_OP_MUL && b < 0) { \
            UINT_MULTIPLY_BY_NEGATIVE_SIGNED_INT_ERR; \
        } \
        \
        if (overflow_fn(a, b, &result)) { \
            OUT_OF_RANGE_ERR(uint8); \
        } \
        \
        PG_RETURN_UINT64(result); \
    }

#define DEFINE_UINT8_SIGNED_INT_OVERFLOW_ARITHMETIC_FUNCS(opname, overflow_fn_prefix, overflow_op) \
    DEFINE_UINT8_SIGNED_INT_OVERFLOW_ARITHMETIC_FUNC(int2, int16, PG_GETARG_INT16, opname, overflow_fn_prefix##_s16_overflow, overflow_op); \
    DEFINE_UINT8_SIGNED_INT_OVERFLOW_ARITHMETIC_FUNC(int4, int32, PG_GETARG_INT32, opname, overflow_fn_prefix##_s32_overflow, overflow_op); \
    DEFINE_UINT8_SIGNED_INT_OVERFLOW_ARITHMETIC_FUNC(int8, int64, PG_GETARG_INT64, opname, overflow_fn_prefix##_s64_overflow, overflow_op);

#define DEFINE_SIGNED_INT_UINT8_OVERFLOW_ARITHMETIC_FUNC(pgtype, ctype, opname, pg_getarg_macro, pg_return_macro, max_value, overflow_fn) \
    PG_FUNCTION_INFO_V1(pgtype##_##opname##_uint8); \
    Datum pgtype##_##opname##_uint8(PG_FUNCTION_ARGS) { \
        ctype  a = pg_getarg_macro(0); \
        uint64 b = PG_GETARG_UINT64(1); \
        ctype  result; \
        \
        if (b > max_value) { \
            OUT_OF_RANGE_ERR(pgtype); \
        } \
        \
        if (overflow_fn(a, b, &result)) { \
            OUT_OF_RANGE_ERR(pgtype); \
        } \
        pg_return_macro(result); \
    }

#define DEFINE_SIGNED_INT_UINT8_OVERFLOW_ARITHMETIC_FUNCS(opname) \
    DEFINE_SIGNED_INT_UINT8_OVERFLOW_ARITHMETIC_FUNC(int2, int16, opname, PG_GETARG_INT16, PG_RETURN_INT16, INT16_MAX, opname##_s16_overflow); \
    DEFINE_SIGNED_INT_UINT8_OVERFLOW_ARITHMETIC_FUNC(int4, int32, opname, PG_GETARG_INT32, PG_RETURN_INT32, INT32_MAX, opname##_s32_overflow); \
    DEFINE_SIGNED_INT_UINT8_OVERFLOW_ARITHMETIC_FUNC(int8, int64, opname, PG_GETARG_INT64, PG_RETURN_INT64, INT64_MAX, opname##_s64_overflow);

// Division/Modulo

#define DEFINE_UINT8_UNSIGNED_INT_DIV_ARITHMETIC_FUNC(pgtype, ctype, pg_getarg_macro, opname, operator, is_mod) \
    PG_FUNCTION_INFO_V1(uint8_##opname##_##pgtype); \
    Datum uint8_##opname##_##pgtype(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        ctype  b = pg_getarg_macro(1); \
        \
        if (b == 0) { \
            DIVISION_BY_ZERO_ERR; \
        } \
        /* In integer division, any division where the absolute value of the numerator is less than the denominator results in 0. */ \
        /* In integer modulo, any division where the absolute value of the numerator is less than the denominator results in original value of numerator. */ \
        if (a < b) { \
            PG_RETURN_UINT64(is_mod ? a : 0); \
        } \
        \
        PG_RETURN_UINT64(a operator ((uint64)b)); \
    }

#define DEFINE_UINT8_UNSIGNED_INT_DIV_ARITHMETIC_FUNCS(opname, operator) \
    DEFINE_UINT8_UNSIGNED_INT_DIV_ARITHMETIC_FUNC(uint8, uint64,   PG_GETARG_UINT64, opname, operator, false); \
    DEFINE_UINT8_UNSIGNED_INT_DIV_ARITHMETIC_FUNC(uint16, uint128, *PG_GETARG_UINT128_P, opname, operator, false);

#define DEFINE_UINT8_UNSIGNED_INT_MOD_ARITHMETIC_FUNCS(opname, operator) \
    DEFINE_UINT8_UNSIGNED_INT_DIV_ARITHMETIC_FUNC(uint8, uint64,   PG_GETARG_UINT64, opname, operator, true); \
    DEFINE_UINT8_UNSIGNED_INT_DIV_ARITHMETIC_FUNC(uint16, uint128, *PG_GETARG_UINT128_P, opname, operator, true);


#define DEFINE_UINT8_SIGNED_INT_DIV_ARITHMETIC_FUNC(pgtype, ctype, pg_getarg_macro, opname, operator) \
    PG_FUNCTION_INFO_V1(uint8_##opname##_##pgtype); \
    Datum uint8_##opname##_##pgtype(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        ctype  b = pg_getarg_macro(1); \
        \
        if (b == 0) { \
            DIVISION_BY_ZERO_ERR; \
        } \
        if (b < 0) { \
            UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR; \
        } \
        \
        PG_RETURN_UINT64(a operator ((uint64)b)); \
    }

#define DEFINE_UINT8_SIGNED_INT_DIV_ARITHMETIC_FUNCS(opname, operator) \
    DEFINE_UINT8_SIGNED_INT_DIV_ARITHMETIC_FUNC(int2, int16, PG_GETARG_INT16, opname, operator); \
    DEFINE_UINT8_SIGNED_INT_DIV_ARITHMETIC_FUNC(int4, int32, PG_GETARG_INT32, opname, operator); \
    DEFINE_UINT8_SIGNED_INT_DIV_ARITHMETIC_FUNC(int8, int64, PG_GETARG_INT64, opname, operator);

#define DEFINE_SIGNED_INT_UINT8_DIV_ARITHMETIC_FUNC(pgtype, ctype, opname, pg_getarg_macro, pg_return_macro, is_mod) \
    PG_FUNCTION_INFO_V1(pgtype##_##opname##_uint8); \
    Datum pgtype##_##opname##_uint8(PG_FUNCTION_ARGS) { \
        ctype  a = pg_getarg_macro(0); \
        uint64 b = PG_GETARG_UINT64(1); \
        \
        if (b == 0) { \
            DIVISION_BY_ZERO_ERR; \
        } \
        /* In integer division, any division where the absolute value of the numerator is less than the denominator results in 0. */ \
        /* In integer modulo, any division where the absolute value of the numerator is less than the denominator results in original value of numerator. */ \
        if (Abs(a) < b) { \
            pg_return_macro(is_mod ? a : 0); \
        } \
        /* Negate result */ \
        if (a < 0) {\
            pg_return_macro(is_mod ? -(a % (ctype)b) : -(a / (ctype)b)); \
        } \
        \
        pg_return_macro(is_mod ? a % (ctype)b : a / (ctype)b); \
    }

#define DEFINE_SIGNED_INT_UINT8_DIV_ARITHMETIC_FUNCS() \
    DEFINE_SIGNED_INT_UINT8_DIV_ARITHMETIC_FUNC(int2, int16, div, PG_GETARG_INT16, PG_RETURN_INT16, false); \
    DEFINE_SIGNED_INT_UINT8_DIV_ARITHMETIC_FUNC(int4, int32, div, PG_GETARG_INT32, PG_RETURN_INT32, false); \
    DEFINE_SIGNED_INT_UINT8_DIV_ARITHMETIC_FUNC(int8, int64, div, PG_GETARG_INT64, PG_RETURN_INT64, false);

#define DEFINE_SIGNED_INT_UINT8_MOD_ARITHMETIC_FUNCS() \
    DEFINE_SIGNED_INT_UINT8_DIV_ARITHMETIC_FUNC(int2, int16, mod, PG_GETARG_INT16, PG_RETURN_INT16, true); \
    DEFINE_SIGNED_INT_UINT8_DIV_ARITHMETIC_FUNC(int4, int32, mod, PG_GETARG_INT32, PG_RETURN_INT32, true); \
    DEFINE_SIGNED_INT_UINT8_DIV_ARITHMETIC_FUNC(int8, int64, mod, PG_GETARG_INT64, PG_RETURN_INT64, true);


// Bitwise funcs

#define DEFINE_UINT8_BITWISE_SHIFT_FUNC(opname, operator) \
    PG_FUNCTION_INFO_V1(uint8_##opname); \
    Datum uint8_##opname(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        int32 shift = PG_GETARG_INT32(1); \
        PG_RETURN_UINT64(a operator shift); \
    }

#define DEFINE_UINT8_INT_BITWISE_FUNC(pgtype, ctype, pg_getarg_macro, opname, operator) \
    PG_FUNCTION_INFO_V1(uint8_##opname##_##pgtype); \
    Datum uint8_##opname##_##pgtype(PG_FUNCTION_ARGS) { \
        uint64 a = PG_GETARG_UINT64(0); \
        ctype  b = pg_getarg_macro(1); \
        PG_RETURN_UINT64(a operator ((uint64)b)); \
    }

#define DEFINE_UINT8_SIGNED_AND_UNSIGNED_INT_BITWISE_FUNCS(opname, operator) \
    DEFINE_UINT8_INT_BITWISE_FUNC(int2, int16, PG_GETARG_INT16, opname, operator); \
    DEFINE_UINT8_INT_BITWISE_FUNC(int4, int32, PG_GETARG_INT32, opname, operator); \
    DEFINE_UINT8_INT_BITWISE_FUNC(int8, int64, PG_GETARG_INT64, opname, operator); \
    DEFINE_UINT8_INT_BITWISE_FUNC(uint8, uint64, PG_GETARG_UINT64, opname, operator); \
    DEFINE_UINT8_INT_BITWISE_FUNC(uint16, uint128, *PG_GETARG_UINT128_P, opname, operator);

#define DEFINE_SIGNED_INT_UINT8_BITWISE_FUNC(pgtype, ctype, opname, operator, pg_getarg_macro, pg_return_macro, max_value) \
    PG_FUNCTION_INFO_V1(pgtype##_##opname##_uint8); \
    Datum pgtype##_##opname##_uint8(PG_FUNCTION_ARGS) { \
        ctype  a = pg_getarg_macro(0); \
        uint64 b = PG_GETARG_UINT64(1); \
        \
        pg_return_macro((ctype)((uint64)a operator b)); \
    }

#define DEFINE_SIGNED_INT_UINT8_BITWISE_FUNCS(opname, operator) \
    DEFINE_SIGNED_INT_UINT8_BITWISE_FUNC(int2, int16, opname, operator, PG_GETARG_INT16, PG_RETURN_INT16, INT16_MAX); \
    DEFINE_SIGNED_INT_UINT8_BITWISE_FUNC(int4, int32, opname, operator, PG_GETARG_INT32, PG_RETURN_INT32, INT32_MAX); \
    DEFINE_SIGNED_INT_UINT8_BITWISE_FUNC(int8, int64, opname, operator, PG_GETARG_INT64, PG_RETURN_INT64, INT64_MAX);


static int uint64_internal_cmp(const uint64 arg1, const uint64 arg2)
{
    if (arg1 < arg2) return -1; // arg1 is less than arg2
    if (arg1 > arg2) return 1; // arg1 is greater than arg2

    return 0; // arg1 is equal to arg2
}

#endif
