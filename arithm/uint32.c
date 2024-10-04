// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "int_utils.h"
#include "uint_utils.h"

// UINT with UINT arithmetic funcs

PG_FUNCTION_INFO_V1(uint4_add_uint2);
Datum uint4_add_uint2(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint16 b = PG_GETARG_UINT16(1);
    uint32 result = 0;
    if (add_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_sub_uint2);
Datum uint4_sub_uint2(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint16 b = PG_GETARG_UINT16(1);
    uint32 result = 0;
    if (sub_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_mul_uint2);
Datum uint4_mul_uint2(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint16 b = PG_GETARG_UINT16(1);
    uint32 result = 0;
    if (mul_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_div_uint2);
Datum uint4_div_uint2(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint16 b = PG_GETARG_UINT16(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_UINT32(a / (uint32)b);
}


PG_FUNCTION_INFO_V1(uint4_mod_uint2);
Datum uint4_mod_uint2(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint16 b = PG_GETARG_UINT16(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_UINT32(a % (uint32)b);
}


PG_FUNCTION_INFO_V1(uint4_add_uint4);
Datum uint4_add_uint4(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint32 b = PG_GETARG_UINT32(1);
    uint32 result = 0;
    if (add_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_sub_uint4);
Datum uint4_sub_uint4(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint32 b = PG_GETARG_UINT32(1);
    uint32 result = 0;
    if (sub_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_mul_uint4);
Datum uint4_mul_uint4(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint32 b = PG_GETARG_UINT32(1);
    uint32 result = 0;
    if (mul_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_div_uint4);
Datum uint4_div_uint4(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint32 b = PG_GETARG_UINT32(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_UINT32(a / b);
}


PG_FUNCTION_INFO_V1(uint4_mod_uint4);
Datum uint4_mod_uint4(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint32 b = PG_GETARG_UINT32(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_UINT32(a % b);
}


PG_FUNCTION_INFO_V1(uint4_add_uint8);
Datum uint4_add_uint8(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint64 b = PG_GETARG_UINT64(1);
    uint32 result = 0;
    if (b > UINT32_MAX) {
        OUT_OF_RANGE_ERR(uint4);
    }
    if (add_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_sub_uint8);
Datum uint4_sub_uint8(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint64 b = PG_GETARG_UINT64(1);
    uint32 result = 0;
    if (b > UINT32_MAX) {
        OUT_OF_RANGE_ERR(uint4);
    }
    if (sub_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_mul_uint8);
Datum uint4_mul_uint8(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint64 b = PG_GETARG_UINT64(1);
    uint32 result = 0;
    if (b > UINT32_MAX) {
        OUT_OF_RANGE_ERR(uint4);
    }
    if (mul_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_div_uint8);
Datum uint4_div_uint8(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint64 b = PG_GETARG_UINT64(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_UINT32((uint64)a / b);
}


PG_FUNCTION_INFO_V1(uint4_mod_uint8);
Datum uint4_mod_uint8(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint64 b = PG_GETARG_UINT64(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_UINT32((uint64)a % b);
}


PG_FUNCTION_INFO_V1(uint4_add_uint16);
Datum uint4_add_uint16(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint128 b = PG_GETARG_UINT128(1);
    uint32 result = 0;
    if (b > UINT32_MAX) {
        OUT_OF_RANGE_ERR(uint4);
    }
    if (add_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_sub_uint16);
Datum uint4_sub_uint16(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint128 b = PG_GETARG_UINT128(1);
    uint32 result = 0;
    if (b > UINT32_MAX) {
        OUT_OF_RANGE_ERR(uint4);
    }
    if (sub_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_mul_uint16);
Datum uint4_mul_uint16(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint128 b = PG_GETARG_UINT128(1);
    uint32 result = 0;
    if (b > UINT32_MAX) {
        OUT_OF_RANGE_ERR(uint4);
    }
    if (mul_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_div_uint16);
Datum uint4_div_uint16(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint128 b = PG_GETARG_UINT128(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_UINT32((uint128)a / b);
}


PG_FUNCTION_INFO_V1(uint4_mod_uint16);
Datum uint4_mod_uint16(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    uint128 b = PG_GETARG_UINT128(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_UINT32((uint128)a % b);
}



// Mixed sign, UINT with INT (signed) arithmetic funcs

PG_FUNCTION_INFO_V1(uint4_add_int2);
Datum uint4_add_int2(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int16 b = PG_GETARG_INT16(1);
    uint32 result = 0;
    if (b < 0) {
        if (sub_u32_overflow(a, -b, &result)) {
            OUT_OF_RANGE_ERR(uint4);
        }
    }
    if (add_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_sub_int2);
Datum uint4_sub_int2(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int16 b = PG_GETARG_INT16(1);
    uint32 result = 0;
    if (b < 0) {
        if (add_u32_overflow(a, -b, &result)) {
            OUT_OF_RANGE_ERR(uint4);
        }
    }
    if (sub_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_mul_int2);
Datum uint4_mul_int2(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int16 b = PG_GETARG_INT16(1);
    uint32 result = 0;
    if (b < 0) {
        UINT_MULTIPLY_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (mul_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_div_int2);
Datum uint4_div_int2(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int16 b = PG_GETARG_INT16(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (b < 0) {
        UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > a) {
        PG_RETURN_UINT32(0);
    }
    PG_RETURN_UINT32(a / (uint32)b);
}


PG_FUNCTION_INFO_V1(uint4_mod_int2);
Datum uint4_mod_int2(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int16 b = PG_GETARG_INT16(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (b < 0) {
        UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > a) {
        PG_RETURN_UINT32(a);
    }
    PG_RETURN_UINT32(a % (uint32)b);
}


PG_FUNCTION_INFO_V1(uint4_add_int4);
Datum uint4_add_int4(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int32 b = PG_GETARG_INT32(1);
    uint32 result = 0;
    if (b < 0) {
        if (sub_u32_overflow(a, -b, &result)) {
            OUT_OF_RANGE_ERR(uint4);
        }
    }
    if (add_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_sub_int4);
Datum uint4_sub_int4(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int32 b = PG_GETARG_INT32(1);
    uint32 result = 0;
    if (b < 0) {
        if (add_u32_overflow(a, -b, &result)) {
            OUT_OF_RANGE_ERR(uint4);
        }
    }
    if (sub_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_mul_int4);
Datum uint4_mul_int4(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int32 b = PG_GETARG_INT32(1);
    uint32 result = 0;
    if (b < 0) {
        UINT_MULTIPLY_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (mul_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_div_int4);
Datum uint4_div_int4(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int32 b = PG_GETARG_INT32(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (b < 0) {
        UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > a) {
        PG_RETURN_UINT32(0);
    }
    PG_RETURN_UINT32(a / (uint32)b);
}


PG_FUNCTION_INFO_V1(uint4_mod_int4);
Datum uint4_mod_int4(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int32 b = PG_GETARG_INT32(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (b < 0) {
        UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > a) {
        PG_RETURN_UINT32(a);
    }
    PG_RETURN_UINT32(a % (uint32)b);
}


PG_FUNCTION_INFO_V1(uint4_add_int8);
Datum uint4_add_int8(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int64 b = PG_GETARG_INT64(1);
    uint32 result = 0;
    if (b > UINT32_MAX) {
        OUT_OF_RANGE_ERR(uint4);
    }
    if (b < 0) {
        if (sub_u32_overflow(a, -b, &result)) {
            OUT_OF_RANGE_ERR(uint4);
        }
    }
    if (add_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_sub_int8);
Datum uint4_sub_int8(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int64 b = PG_GETARG_INT64(1);
    uint32 result = 0;
    if (b > UINT32_MAX) {
        OUT_OF_RANGE_ERR(uint4);
    }
    if (b < 0) {
        if (add_u32_overflow(a, -b, &result)) {
            OUT_OF_RANGE_ERR(uint4);
        }
    }
    if (sub_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_mul_int8);
Datum uint4_mul_int8(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int64 b = PG_GETARG_INT64(1);
    uint32 result = 0;
    if (b < 0) {
        UINT_MULTIPLY_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > UINT32_MAX) {
        OUT_OF_RANGE_ERR(uint4);
    }
    if (mul_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_div_int8);
Datum uint4_div_int8(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int64 b = PG_GETARG_INT64(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (b < 0) {
        UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > a) {
        PG_RETURN_UINT32(0);
    }
    PG_RETURN_UINT32(a / (uint32)b);
}


PG_FUNCTION_INFO_V1(uint4_mod_int8);
Datum uint4_mod_int8(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int64 b = PG_GETARG_INT64(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (b < 0) {
        UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > a) {
        PG_RETURN_UINT32(a);
    }
    PG_RETURN_UINT32(a % (uint32)b);
}


PG_FUNCTION_INFO_V1(uint4_add_int16);
Datum uint4_add_int16(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int128 b = PG_GETARG_INT128(1);
    uint32 result = 0;
    if (b > UINT32_MAX) {
        OUT_OF_RANGE_ERR(uint4);
    }
    if (b < 0) {
        if (sub_u32_overflow(a, -b, &result)) {
            OUT_OF_RANGE_ERR(uint4);
        }
    }
    if (add_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_sub_int16);
Datum uint4_sub_int16(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int128 b = PG_GETARG_INT128(1);
    uint32 result = 0;
    if (b > UINT32_MAX) {
        OUT_OF_RANGE_ERR(uint4);
    }
    if (b < 0) {
        if (add_u32_overflow(a, -b, &result)) {
            OUT_OF_RANGE_ERR(uint4);
        }
    }
    if (sub_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_mul_int16);
Datum uint4_mul_int16(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int128 b = PG_GETARG_INT128(1);
    uint32 result = 0;
    if (b < 0) {
        UINT_MULTIPLY_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > UINT32_MAX) {
        OUT_OF_RANGE_ERR(uint4);
    }
    if (mul_u32_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32(result);
}


PG_FUNCTION_INFO_V1(uint4_div_int16);
Datum uint4_div_int16(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int128 b = PG_GETARG_INT128(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (b < 0) {
        UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > a) {
        PG_RETURN_UINT32(0);
    }
    PG_RETURN_UINT32(a / (uint32)b);
}


PG_FUNCTION_INFO_V1(uint4_mod_int16);
Datum uint4_mod_int16(PG_FUNCTION_ARGS)
{
    uint32 a = PG_GETARG_UINT32(0);
    int128 b = PG_GETARG_INT128(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (b < 0) {
        UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > a) {
        PG_RETURN_UINT32(a);
    }
    PG_RETURN_UINT32(a % (uint32)b);
}


