// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "int_utils.h"
#include "uint_utils.h"

// UINT with UINT arithmetic funcs

PG_FUNCTION_INFO_V1(uint8_add_uint2);
Datum uint8_add_uint2(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint16 b = PG_GETARG_UINT16(1);
    uint64 result = 0;
    if (add_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_sub_uint2);
Datum uint8_sub_uint2(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint16 b = PG_GETARG_UINT16(1);
    uint64 result = 0;
    if (sub_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_mul_uint2);
Datum uint8_mul_uint2(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint16 b = PG_GETARG_UINT16(1);
    uint64 result = 0;
    if (mul_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_div_uint2);
Datum uint8_div_uint2(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint16 b = PG_GETARG_UINT16(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_UINT64(a / (uint64)b);
}


PG_FUNCTION_INFO_V1(uint8_mod_uint2);
Datum uint8_mod_uint2(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint16 b = PG_GETARG_UINT16(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_UINT64(a % (uint64)b);
}


PG_FUNCTION_INFO_V1(uint8_add_uint4);
Datum uint8_add_uint4(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint32 b = PG_GETARG_UINT32(1);
    uint64 result = 0;
    if (add_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_sub_uint4);
Datum uint8_sub_uint4(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint32 b = PG_GETARG_UINT32(1);
    uint64 result = 0;
    if (sub_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_mul_uint4);
Datum uint8_mul_uint4(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint32 b = PG_GETARG_UINT32(1);
    uint64 result = 0;
    if (mul_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_div_uint4);
Datum uint8_div_uint4(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint32 b = PG_GETARG_UINT32(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_UINT64(a / (uint64)b);
}


PG_FUNCTION_INFO_V1(uint8_mod_uint4);
Datum uint8_mod_uint4(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint32 b = PG_GETARG_UINT32(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_UINT64(a % (uint64)b);
}


PG_FUNCTION_INFO_V1(uint8_add_uint8);
Datum uint8_add_uint8(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint64 b = PG_GETARG_UINT64(1);
    uint64 result = 0;
    if (add_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_sub_uint8);
Datum uint8_sub_uint8(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint64 b = PG_GETARG_UINT64(1);
    uint64 result = 0;
    if (sub_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_mul_uint8);
Datum uint8_mul_uint8(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint64 b = PG_GETARG_UINT64(1);
    uint64 result = 0;
    if (mul_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_div_uint8);
Datum uint8_div_uint8(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint64 b = PG_GETARG_UINT64(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_UINT64(a / b);
}


PG_FUNCTION_INFO_V1(uint8_mod_uint8);
Datum uint8_mod_uint8(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint64 b = PG_GETARG_UINT64(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_UINT64(a % b);
}


PG_FUNCTION_INFO_V1(uint8_add_uint16);
Datum uint8_add_uint16(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint128 b = PG_GETARG_UINT128(1);
    uint64 result = 0;
    if (b > UINT64_MAX) {
        OUT_OF_RANGE_ERR(uint8);
    }
    if (add_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_sub_uint16);
Datum uint8_sub_uint16(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint128 b = PG_GETARG_UINT128(1);
    uint64 result = 0;
    if (b > UINT64_MAX) {
        OUT_OF_RANGE_ERR(uint8);
    }
    if (sub_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_mul_uint16);
Datum uint8_mul_uint16(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint128 b = PG_GETARG_UINT128(1);
    uint64 result = 0;
    if (b > UINT64_MAX) {
        OUT_OF_RANGE_ERR(uint8);
    }
    if (mul_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_div_uint16);
Datum uint8_div_uint16(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint128 b = PG_GETARG_UINT128(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_UINT64((uint128)a / b);
}


PG_FUNCTION_INFO_V1(uint8_mod_uint16);
Datum uint8_mod_uint16(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    uint128 b = PG_GETARG_UINT128(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    PG_RETURN_UINT64((uint128)a % b);
}



// Mixed sign, UINT with INT (signed) arithmetic funcs

PG_FUNCTION_INFO_V1(uint8_add_int2);
Datum uint8_add_int2(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int16 b = PG_GETARG_INT16(1);
    uint64 result = 0;
    if (b < 0) {
        if (sub_u64_overflow(a, -b, &result)) {
            OUT_OF_RANGE_ERR(uint8);
        }
    }
    if (add_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_sub_int2);
Datum uint8_sub_int2(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int16 b = PG_GETARG_INT16(1);
    uint64 result = 0;
    if (b < 0) {
        if (add_u64_overflow(a, -b, &result)) {
            OUT_OF_RANGE_ERR(uint8);
        }
    }
    if (sub_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_mul_int2);
Datum uint8_mul_int2(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int16 b = PG_GETARG_INT16(1);
    uint64 result = 0;
    if (b < 0) {
        UINT_MULTIPLY_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (mul_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_div_int2);
Datum uint8_div_int2(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int16 b = PG_GETARG_INT16(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (b < 0) {
        UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > a) {
        PG_RETURN_UINT64(0);
    }
    PG_RETURN_UINT64(a / (uint64)b);
}


PG_FUNCTION_INFO_V1(uint8_mod_int2);
Datum uint8_mod_int2(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int16 b = PG_GETARG_INT16(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (b < 0) {
        UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > a) {
        PG_RETURN_UINT64(a);
    }
    PG_RETURN_UINT64(a % (uint64)b);
}


PG_FUNCTION_INFO_V1(uint8_add_int4);
Datum uint8_add_int4(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int32 b = PG_GETARG_INT32(1);
    uint64 result = 0;
    if (b < 0) {
        if (sub_u64_overflow(a, -b, &result)) {
            OUT_OF_RANGE_ERR(uint8);
        }
    }
    if (add_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_sub_int4);
Datum uint8_sub_int4(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int32 b = PG_GETARG_INT32(1);
    uint64 result = 0;
    if (b < 0) {
        if (add_u64_overflow(a, -b, &result)) {
            OUT_OF_RANGE_ERR(uint8);
        }
    }
    if (sub_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_mul_int4);
Datum uint8_mul_int4(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int32 b = PG_GETARG_INT32(1);
    uint64 result = 0;
    if (b < 0) {
        UINT_MULTIPLY_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (mul_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_div_int4);
Datum uint8_div_int4(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int32 b = PG_GETARG_INT32(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (b < 0) {
        UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > a) {
        PG_RETURN_UINT64(0);
    }
    PG_RETURN_UINT64(a / (uint64)b);
}


PG_FUNCTION_INFO_V1(uint8_mod_int4);
Datum uint8_mod_int4(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int32 b = PG_GETARG_INT32(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (b < 0) {
        UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > a) {
        PG_RETURN_UINT64(a);
    }
    PG_RETURN_UINT64(a % (uint64)b);
}


PG_FUNCTION_INFO_V1(uint8_add_int8);
Datum uint8_add_int8(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int64 b = PG_GETARG_INT64(1);
    uint64 result = 0;
    if (b < 0) {
        if (sub_u64_overflow(a, -b, &result)) {
            OUT_OF_RANGE_ERR(uint8);
        }
    }
    if (add_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_sub_int8);
Datum uint8_sub_int8(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int64 b = PG_GETARG_INT64(1);
    uint64 result = 0;
    if (b < 0) {
        if (add_u64_overflow(a, -b, &result)) {
            OUT_OF_RANGE_ERR(uint8);
        }
    }
    if (sub_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_mul_int8);
Datum uint8_mul_int8(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int64 b = PG_GETARG_INT64(1);
    uint64 result = 0;
    if (b < 0) {
        UINT_MULTIPLY_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (mul_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_div_int8);
Datum uint8_div_int8(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int64 b = PG_GETARG_INT64(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (b < 0) {
        UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > a) {
        PG_RETURN_UINT64(0);
    }
    PG_RETURN_UINT64(a / (uint64)b);
}


PG_FUNCTION_INFO_V1(uint8_mod_int8);
Datum uint8_mod_int8(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int64 b = PG_GETARG_INT64(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (b < 0) {
        UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > a) {
        PG_RETURN_UINT64(a);
    }
    PG_RETURN_UINT64(a % (uint64)b);
}


PG_FUNCTION_INFO_V1(uint8_add_int16);
Datum uint8_add_int16(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int128 b = PG_GETARG_INT128(1);
    uint64 result = 0;
    if (b > UINT64_MAX) {
        OUT_OF_RANGE_ERR(uint8);
    }
    if (b < 0) {
        if (sub_u64_overflow(a, -b, &result)) {
            OUT_OF_RANGE_ERR(uint8);
        }
    }
    if (add_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_sub_int16);
Datum uint8_sub_int16(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int128 b = PG_GETARG_INT128(1);
    uint64 result = 0;
    if (b > UINT64_MAX) {
        OUT_OF_RANGE_ERR(uint8);
    }
    if (b < 0) {
        if (add_u64_overflow(a, -b, &result)) {
            OUT_OF_RANGE_ERR(uint8);
        }
    }
    if (sub_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_mul_int16);
Datum uint8_mul_int16(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int128 b = PG_GETARG_INT128(1);
    uint64 result = 0;
    if (b < 0) {
        UINT_MULTIPLY_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > UINT64_MAX) {
        OUT_OF_RANGE_ERR(uint8);
    }
    if (mul_u64_overflow(a, b, &result)) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64(result);
}


PG_FUNCTION_INFO_V1(uint8_div_int16);
Datum uint8_div_int16(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int128 b = PG_GETARG_INT128(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (b < 0) {
        UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > a) {
        PG_RETURN_UINT64(0);
    }
    PG_RETURN_UINT64(a / (uint64)b);
}


PG_FUNCTION_INFO_V1(uint8_mod_int16);
Datum uint8_mod_int16(PG_FUNCTION_ARGS)
{
    uint64 a = PG_GETARG_UINT64(0);
    int128 b = PG_GETARG_INT128(1);
    if (b == 0) {
        DIVISION_BY_ZERO_ERR;
    }
    if (b < 0) {
        UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR;
    }
    if (b > a) {
        PG_RETURN_UINT64(a);
    }
    PG_RETURN_UINT64(a % (uint64)b);
}


