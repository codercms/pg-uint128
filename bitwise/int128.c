// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "int_utils.h"
#include "uint_utils.h"

PG_FUNCTION_INFO_V1(int16_and);
Datum int16_and(PG_FUNCTION_ARGS) {
    int128 a = PG_GETARG_INT128(0);
    int128 b = PG_GETARG_INT128(1);
    PG_RETURN_INT128(a & b);
}


PG_FUNCTION_INFO_V1(int16_or);
Datum int16_or(PG_FUNCTION_ARGS) {
    int128 a = PG_GETARG_INT128(0);
    int128 b = PG_GETARG_INT128(1);
    PG_RETURN_INT128(a | b);
}


PG_FUNCTION_INFO_V1(int16_xor);
Datum int16_xor(PG_FUNCTION_ARGS) {
    int128 a = PG_GETARG_INT128(0);
    int128 b = PG_GETARG_INT128(1);
    PG_RETURN_INT128(a ^ b);
}


PG_FUNCTION_INFO_V1(int16_not);
Datum int16_not(PG_FUNCTION_ARGS) {
    PG_RETURN_INT128(~(PG_GETARG_INT128(0)));
}


PG_FUNCTION_INFO_V1(int16_shl);
Datum int16_shl(PG_FUNCTION_ARGS) {
    int128 a = PG_GETARG_INT128(0);
    int32 shift = PG_GETARG_INT32(1);
    PG_RETURN_INT128(a << shift);
}


PG_FUNCTION_INFO_V1(int16_shr);
Datum int16_shr(PG_FUNCTION_ARGS) {
    int128 a = PG_GETARG_INT128(0);
    int32 shift = PG_GETARG_INT32(1);
    PG_RETURN_INT128(a >> shift);
}


