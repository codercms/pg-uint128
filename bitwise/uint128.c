// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "int_utils.h"
#include "uint_utils.h"

PG_FUNCTION_INFO_V1(uint16_and);
Datum uint16_and(PG_FUNCTION_ARGS) {
    uint128 a = PG_GETARG_UINT128(0);
    uint128 b = PG_GETARG_UINT128(1);
    PG_RETURN_UINT128(a & b);
}


PG_FUNCTION_INFO_V1(uint16_or);
Datum uint16_or(PG_FUNCTION_ARGS) {
    uint128 a = PG_GETARG_UINT128(0);
    uint128 b = PG_GETARG_UINT128(1);
    PG_RETURN_UINT128(a | b);
}


PG_FUNCTION_INFO_V1(uint16_xor);
Datum uint16_xor(PG_FUNCTION_ARGS) {
    uint128 a = PG_GETARG_UINT128(0);
    uint128 b = PG_GETARG_UINT128(1);
    PG_RETURN_UINT128(a ^ b);
}


PG_FUNCTION_INFO_V1(uint16_not);
Datum uint16_not(PG_FUNCTION_ARGS) {
    PG_RETURN_UINT128(~(PG_GETARG_UINT128(0)));
}


PG_FUNCTION_INFO_V1(uint16_shl);
Datum uint16_shl(PG_FUNCTION_ARGS) {
    uint128 a = PG_GETARG_UINT128(0);
    int32 shift = PG_GETARG_INT32(1);
    PG_RETURN_UINT128(a << shift);
}


PG_FUNCTION_INFO_V1(uint16_shr);
Datum uint16_shr(PG_FUNCTION_ARGS) {
    uint128 a = PG_GETARG_UINT128(0);
    int32 shift = PG_GETARG_INT32(1);
    PG_RETURN_UINT128(a >> shift);
}


