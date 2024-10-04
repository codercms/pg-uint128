// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "int_utils.h"
#include "uint_utils.h"

// Signed comparison

PG_FUNCTION_INFO_V1(int4_from_int2);
Datum int4_from_int2(PG_FUNCTION_ARGS) {
    int16 a = PG_GETARG_INT16(0);

    PG_RETURN_INT32((int32) a);
}


PG_FUNCTION_INFO_V1(int4_to_int2);
Datum int4_to_int2(PG_FUNCTION_ARGS) {
    int32 a = PG_GETARG_INT32(0);

    if (a > INT16_MAX || a < INT16_MIN) {
        OUT_OF_RANGE_ERR(int2);
    }
    PG_RETURN_INT16((int16) a);
}


PG_FUNCTION_INFO_V1(int4_from_int8);
Datum int4_from_int8(PG_FUNCTION_ARGS) {
    int64 a = PG_GETARG_INT64(0);

    if (a > INT32_MAX || a < INT32_MIN) {
        OUT_OF_RANGE_ERR(int4);
    }
    PG_RETURN_INT32((int32) a);
}


PG_FUNCTION_INFO_V1(int4_to_int8);
Datum int4_to_int8(PG_FUNCTION_ARGS) {
    int32 a = PG_GETARG_INT32(0);

    PG_RETURN_INT64((int64) a);
}


PG_FUNCTION_INFO_V1(int4_from_int16);
Datum int4_from_int16(PG_FUNCTION_ARGS) {
    int128 a = PG_GETARG_INT128(0);

    if (a > INT32_MAX || a < INT32_MIN) {
        OUT_OF_RANGE_ERR(int4);
    }
    PG_RETURN_INT32((int32) a);
}


PG_FUNCTION_INFO_V1(int4_to_int16);
Datum int4_to_int16(PG_FUNCTION_ARGS) {
    int32 a = PG_GETARG_INT32(0);

    PG_RETURN_INT128((int128) a);
}


// Unsigned comparison

PG_FUNCTION_INFO_V1(int4_from_uint2);
Datum int4_from_uint2(PG_FUNCTION_ARGS) {
    uint16 a = PG_GETARG_UINT16(0);

    PG_RETURN_INT32((int32) a);
}


PG_FUNCTION_INFO_V1(int4_to_uint2);
Datum int4_to_uint2(PG_FUNCTION_ARGS) {
    int32 a = PG_GETARG_INT32(0);

    if (a < 0) {
        OUT_OF_RANGE_ERR(uint2);
    }
    if (a > UINT16_MAX) {
        OUT_OF_RANGE_ERR(uint2);
    }
    PG_RETURN_UINT16((uint16) a);
}


PG_FUNCTION_INFO_V1(int4_from_uint4);
Datum int4_from_uint4(PG_FUNCTION_ARGS) {
    uint32 a = PG_GETARG_UINT32(0);

    if (a > INT32_MAX) {
        OUT_OF_RANGE_ERR(int4);
    }
    PG_RETURN_INT32((int32) a);
}


PG_FUNCTION_INFO_V1(int4_to_uint4);
Datum int4_to_uint4(PG_FUNCTION_ARGS) {
    int32 a = PG_GETARG_INT32(0);

    if (a < 0) {
        OUT_OF_RANGE_ERR(uint4);
    }
    PG_RETURN_UINT32((uint32) a);
}


PG_FUNCTION_INFO_V1(int4_from_uint8);
Datum int4_from_uint8(PG_FUNCTION_ARGS) {
    uint64 a = PG_GETARG_UINT64(0);

    if (a > INT32_MAX) {
        OUT_OF_RANGE_ERR(int4);
    }
    PG_RETURN_INT32((int32) a);
}


PG_FUNCTION_INFO_V1(int4_to_uint8);
Datum int4_to_uint8(PG_FUNCTION_ARGS) {
    int32 a = PG_GETARG_INT32(0);

    if (a < 0) {
        OUT_OF_RANGE_ERR(uint8);
    }
    PG_RETURN_UINT64((uint64) a);
}


PG_FUNCTION_INFO_V1(int4_from_uint16);
Datum int4_from_uint16(PG_FUNCTION_ARGS) {
    uint128 a = PG_GETARG_UINT128(0);

    if (a > INT32_MAX) {
        OUT_OF_RANGE_ERR(int4);
    }
    PG_RETURN_INT32((int32) a);
}


PG_FUNCTION_INFO_V1(int4_to_uint16);
Datum int4_to_uint16(PG_FUNCTION_ARGS) {
    int32 a = PG_GETARG_INT32(0);

    if (a < 0) {
        OUT_OF_RANGE_ERR(uint16);
    }
    PG_RETURN_UINT128((uint128) a);
}


