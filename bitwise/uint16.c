// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "int_utils.h"
#include "uint_utils.h"

PG_FUNCTION_INFO_V1(uint2_and);
Datum uint2_and(PG_FUNCTION_ARGS) {
    uint16 a = PG_GETARG_UINT16(0);
    uint16 b = PG_GETARG_UINT16(1);
    PG_RETURN_UINT16(a & b);
}


PG_FUNCTION_INFO_V1(uint2_or);
Datum uint2_or(PG_FUNCTION_ARGS) {
    uint16 a = PG_GETARG_UINT16(0);
    uint16 b = PG_GETARG_UINT16(1);
    PG_RETURN_UINT16(a | b);
}


PG_FUNCTION_INFO_V1(uint2_xor);
Datum uint2_xor(PG_FUNCTION_ARGS) {
    uint16 a = PG_GETARG_UINT16(0);
    uint16 b = PG_GETARG_UINT16(1);
    PG_RETURN_UINT16(a ^ b);
}


PG_FUNCTION_INFO_V1(uint2_not);
Datum uint2_not(PG_FUNCTION_ARGS) {
    PG_RETURN_UINT16(~(PG_GETARG_UINT16(0)));
}


PG_FUNCTION_INFO_V1(uint2_shl);
Datum uint2_shl(PG_FUNCTION_ARGS) {
    uint16 a = PG_GETARG_UINT16(0);
    int32 shift = PG_GETARG_INT32(1);
    PG_RETURN_UINT16(a << shift);
}


PG_FUNCTION_INFO_V1(uint2_shr);
Datum uint2_shr(PG_FUNCTION_ARGS) {
    uint16 a = PG_GETARG_UINT16(0);
    int32 shift = PG_GETARG_INT32(1);
    PG_RETURN_UINT16(a >> shift);
}


