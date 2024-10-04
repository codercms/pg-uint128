#ifndef _INT128_H
#define _INT128_H

#include "postgres.h"
#include "fmgr.h"

#define DEFINE_INT16_FROM_INT_FUNC(pgtype, ctype, pg_getarg_macro) \
    PG_FUNCTION_INFO_V1(int16_from_##pgtype); \
    Datum int16_from_##pgtype(PG_FUNCTION_ARGS) { \
        ctype a = pg_getarg_macro(0); \
        if (a > INT128_MAX || a < INT128_MIN) { \
            OUT_OF_RANGE_ERR(int16); \
        } \
        PG_RETURN_INT128((int128)a); \
    }

#define DEFINE_INT16_TO_INT_FUNC(pgtype, ctype, min_value, max_value, pg_return_macro) \
    PG_FUNCTION_INFO_V1(int16_to_##pgtype); \
    Datum int16_to_##pgtype(PG_FUNCTION_ARGS) { \
        int128 a = PG_GETARG_INT128(0); \
        ctype result; \
        \
        /* Check for overflow */ \
        if (a > max_value || a < min_value) { \
            ereport(ERROR, \
                    (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), \
                     errmsg("int16 value exceeds " #pgtype " range"))); \
        } \
        \
        result = (ctype)a;  /* Safe to cast */ \
        pg_return_macro(result); \
    }


static int int128_internal_cmp(const int128 *arg1, const int128 *arg2)
{
    if (*arg1 < *arg2) return -1; // arg1 is less than arg2
    if (*arg1 > *arg2) return 1; // arg1 is greater than arg2

    return 0; // arg1 is equal to arg2
}

#endif
