// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "int_utils.h"
#include "uint_utils.h"

PG_FUNCTION_INFO_V1(uint8_and);
Datum uint8_and(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);
    uint64 b = PG_GETARG_UINT64(1);
    PG_RETURN_UINT64(a & b);
}


PG_FUNCTION_INFO_V1(uint8_or);
Datum uint8_or(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);
    uint64 b = PG_GETARG_UINT64(1);
    PG_RETURN_UINT64(a | b);
}


PG_FUNCTION_INFO_V1(uint8_xor);
Datum uint8_xor(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);
    uint64 b = PG_GETARG_UINT64(1);
    PG_RETURN_UINT64(a ^ b);
}


PG_FUNCTION_INFO_V1(uint8_not);
Datum uint8_not(PG_FUNCTION_ARGS) {
    PG_RETURN_UINT64(~(PG_GETARG_UINT64(0)));
}


PG_FUNCTION_INFO_V1(uint8_shl);
Datum uint8_shl(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);
    int32 shift = PG_GETARG_INT32(1);
    PG_RETURN_UINT64(a << shift);
}


PG_FUNCTION_INFO_V1(uint8_shr);
Datum uint8_shr(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);
    int32 shift = PG_GETARG_INT32(1);
    PG_RETURN_UINT64(a >> shift);
}


