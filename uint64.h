#ifndef UINT64_H
#define UINT64_H

#include "postgres.h"
#include "fmgr.h"

#define DEFINE_UINT8_FROM_INT_FUNC(pgtype, ctype, pg_getarg_macro) \
    PG_FUNCTION_INFO_V1(uint8_from_##pgtype); \
    Datum uint8_from_##pgtype(PG_FUNCTION_ARGS) { \
        ctype a = pg_getarg_macro(0); \
        if (a < 0 || a > UINT64_MAX) { \
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



static int uint64_internal_cmp(const uint64 arg1, const uint64 arg2)
{
    if (arg1 < arg2) return -1; // arg1 is less than arg2
    if (arg1 > arg2) return 1; // arg1 is greater than arg2

    return 0; // arg1 is equal to arg2
}

#endif
