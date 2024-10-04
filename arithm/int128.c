// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "int_utils.h"
#include "uint_utils.h"

// INT with INT (signed) arithmetic funcs

PG_FUNCTION_INFO_V1(int16_add_int16);
Datum int16_add_int16(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    int128 b = PG_GETARG_INT128(1);
    int128 result = 0;
    if (add_s128_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(int16);
    }
    PG_RETURN_INT128(result);
}


PG_FUNCTION_INFO_V1(int16_sub_int16);
Datum int16_sub_int16(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    int128 b = PG_GETARG_INT128(1);
    int128 result = 0;
    if (sub_s128_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(int16);
    }
    PG_RETURN_INT128(result);
}


PG_FUNCTION_INFO_V1(int16_mul_int16);
Datum int16_mul_int16(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    int128 b = PG_GETARG_INT128(1);
    int128 result = 0;
    if (mul_s128_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(int16);
    }
    PG_RETURN_INT128(result);
}


PG_FUNCTION_INFO_V1(int16_div_int16);
Datum int16_div_int16(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    int128 b = PG_GETARG_INT128(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_INT128(a / b);
}


PG_FUNCTION_INFO_V1(int16_mod_int16);
Datum int16_mod_int16(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    int128 b = PG_GETARG_INT128(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_INT128(a % b);
}



// Mixed sign, signed INT with UINT arithmetic funcs

PG_FUNCTION_INFO_V1(int16_add_uint2);
Datum int16_add_uint2(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint16 b = PG_GETARG_UINT16(1);
    int128 result = 0;
    if (add_s128_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(int16);
    }
    PG_RETURN_INT128(result);
}


PG_FUNCTION_INFO_V1(int16_sub_uint2);
Datum int16_sub_uint2(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint16 b = PG_GETARG_UINT16(1);
    int128 result = 0;
    if (sub_s128_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(int16);
    }
    PG_RETURN_INT128(result);
}


PG_FUNCTION_INFO_V1(int16_mul_uint2);
Datum int16_mul_uint2(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint16 b = PG_GETARG_UINT16(1);
    int128 result = 0;
    if (mul_s128_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(int16);
    }
    PG_RETURN_INT128(result);
}


PG_FUNCTION_INFO_V1(int16_div_uint2);
Datum int16_div_uint2(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint16 b = PG_GETARG_UINT16(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (a < 0) {
        PG_RETURN_INT128(0);
    }
    PG_RETURN_INT128(a / (int128)b);
}


PG_FUNCTION_INFO_V1(int16_mod_uint2);
Datum int16_mod_uint2(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint16 b = PG_GETARG_UINT16(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (a < 0) {
        PG_RETURN_INT128(a);
    }
    PG_RETURN_INT128(a % (int128)b);
}


PG_FUNCTION_INFO_V1(int16_add_uint4);
Datum int16_add_uint4(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint32 b = PG_GETARG_UINT32(1);
    int128 result = 0;
    if (add_s128_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(int16);
    }
    PG_RETURN_INT128(result);
}


PG_FUNCTION_INFO_V1(int16_sub_uint4);
Datum int16_sub_uint4(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint32 b = PG_GETARG_UINT32(1);
    int128 result = 0;
    if (sub_s128_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(int16);
    }
    PG_RETURN_INT128(result);
}


PG_FUNCTION_INFO_V1(int16_mul_uint4);
Datum int16_mul_uint4(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint32 b = PG_GETARG_UINT32(1);
    int128 result = 0;
    if (mul_s128_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(int16);
    }
    PG_RETURN_INT128(result);
}


PG_FUNCTION_INFO_V1(int16_div_uint4);
Datum int16_div_uint4(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint32 b = PG_GETARG_UINT32(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (a < 0) {
        PG_RETURN_INT128(0);
    }
    PG_RETURN_INT128(a / (int128)b);
}


PG_FUNCTION_INFO_V1(int16_mod_uint4);
Datum int16_mod_uint4(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint32 b = PG_GETARG_UINT32(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (a < 0) {
        PG_RETURN_INT128(a);
    }
    PG_RETURN_INT128(a % (int128)b);
}


PG_FUNCTION_INFO_V1(int16_add_uint8);
Datum int16_add_uint8(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint64 b = PG_GETARG_UINT64(1);
    int128 result = 0;
    if (add_s128_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(int16);
    }
    PG_RETURN_INT128(result);
}


PG_FUNCTION_INFO_V1(int16_sub_uint8);
Datum int16_sub_uint8(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint64 b = PG_GETARG_UINT64(1);
    int128 result = 0;
    if (sub_s128_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(int16);
    }
    PG_RETURN_INT128(result);
}


PG_FUNCTION_INFO_V1(int16_mul_uint8);
Datum int16_mul_uint8(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint64 b = PG_GETARG_UINT64(1);
    int128 result = 0;
    if (mul_s128_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(int16);
    }
    PG_RETURN_INT128(result);
}


PG_FUNCTION_INFO_V1(int16_div_uint8);
Datum int16_div_uint8(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint64 b = PG_GETARG_UINT64(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (a < 0) {
        PG_RETURN_INT128(0);
    }
    PG_RETURN_INT128(a / (int128)b);
}


PG_FUNCTION_INFO_V1(int16_mod_uint8);
Datum int16_mod_uint8(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint64 b = PG_GETARG_UINT64(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (a < 0) {
        PG_RETURN_INT128(a);
    }
    PG_RETURN_INT128(a % (int128)b);
}


PG_FUNCTION_INFO_V1(int16_add_uint16);
Datum int16_add_uint16(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint128 b = PG_GETARG_UINT128(1);
    int128 result = 0;
    if (b > INT128_MAX) {
        OUT_OF_RANGE_ERR(int16);
    }
    if (add_s128_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(int16);
    }
    PG_RETURN_INT128(result);
}


PG_FUNCTION_INFO_V1(int16_sub_uint16);
Datum int16_sub_uint16(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint128 b = PG_GETARG_UINT128(1);
    int128 result = 0;
    if (b > INT128_MAX) {
        OUT_OF_RANGE_ERR(int16);
    }
    if (sub_s128_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(int16);
    }
    PG_RETURN_INT128(result);
}


PG_FUNCTION_INFO_V1(int16_mul_uint16);
Datum int16_mul_uint16(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint128 b = PG_GETARG_UINT128(1);
    int128 result = 0;
    if (b > INT128_MAX) {
        OUT_OF_RANGE_ERR(int16);
    }
    if (mul_s128_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(int16);
    }
    PG_RETURN_INT128(result);
}


PG_FUNCTION_INFO_V1(int16_div_uint16);
Datum int16_div_uint16(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint128 b = PG_GETARG_UINT128(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (a < 0 || b > INT128_MAX) {
        PG_RETURN_INT128(0);
    }
    PG_RETURN_INT128(a / (int128)b);
}


PG_FUNCTION_INFO_V1(int16_mod_uint16);
Datum int16_mod_uint16(PG_FUNCTION_ARGS)
{
    int128 a = PG_GETARG_INT128(0);
    uint128 b = PG_GETARG_UINT128(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (a < 0 || b > INT128_MAX) {
        PG_RETURN_INT128(a);
    }
    PG_RETURN_INT128(a % (int128)b);
}


