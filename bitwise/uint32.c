// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "int_utils.h"
#include "uint_utils.h"

PG_FUNCTION_INFO_V1(uint4_and);
Datum uint4_and(PG_FUNCTION_ARGS) {
    uint32 a = PG_GETARG_UINT32(0);
    uint32 b = PG_GETARG_UINT32(1);
    PG_RETURN_UINT32(a & b);
}


PG_FUNCTION_INFO_V1(uint4_or);
Datum uint4_or(PG_FUNCTION_ARGS) {
    uint32 a = PG_GETARG_UINT32(0);
    uint32 b = PG_GETARG_UINT32(1);
    PG_RETURN_UINT32(a | b);
}


PG_FUNCTION_INFO_V1(uint4_xor);
Datum uint4_xor(PG_FUNCTION_ARGS) {
    uint32 a = PG_GETARG_UINT32(0);
    uint32 b = PG_GETARG_UINT32(1);
    PG_RETURN_UINT32(a ^ b);
}


PG_FUNCTION_INFO_V1(uint4_not);
Datum uint4_not(PG_FUNCTION_ARGS) {
    PG_RETURN_UINT32(~(PG_GETARG_UINT32(0)));
}


PG_FUNCTION_INFO_V1(uint4_shl);
Datum uint4_shl(PG_FUNCTION_ARGS) {
    uint32 a = PG_GETARG_UINT32(0);
    int32 shift = PG_GETARG_INT32(1);
    PG_RETURN_UINT32(a << shift);
}


PG_FUNCTION_INFO_V1(uint4_shr);
Datum uint4_shr(PG_FUNCTION_ARGS) {
    uint32 a = PG_GETARG_UINT32(0);
    int32 shift = PG_GETARG_INT32(1);
    PG_RETURN_UINT32(a >> shift);
}


