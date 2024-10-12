// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "utils/fmgrprotos.h"
#include "int_utils.h"
#include "uint_utils.h"
#include "numeric_utils.h"

PG_FUNCTION_INFO_V1(uint2_avg_accum);
Datum uint2_avg_accum(PG_FUNCTION_ARGS) {
    char buf[UINT16_STRBUFLEN];
    uint16 num = PG_GETARG_UINT16(1);

    Numeric numParsed = uint16_to_numeric(num, buf, sizeof(buf));
    /* Initialize the FunctionCallInfoData for numeric_avg_accum */
    fcinfo->args[1].value = NumericGetDatum(numParsed);

    return numeric_avg_accum(fcinfo);
}

PG_FUNCTION_INFO_V1(uint2_avg_accum_inv);
Datum uint2_avg_accum_inv(PG_FUNCTION_ARGS) {
    char buf[UINT16_STRBUFLEN];
    uint16 num = PG_GETARG_UINT16(1);

    Numeric numParsed = uint16_to_numeric(num, buf, sizeof(buf));
    /* Initialize the FunctionCallInfoData for numeric_accum_inv */
    fcinfo->args[1].value = NumericGetDatum(numParsed);

    return numeric_accum_inv(fcinfo);
}


PG_FUNCTION_INFO_V1(uint2_smaller);
Datum uint2_smaller(PG_FUNCTION_ARGS) {
    uint16		arg1 = PG_GETARG_UINT16(0);
    uint16		arg2 = PG_GETARG_UINT16(1);

    PG_RETURN_UINT16(arg1 < arg2 ? arg1 : arg2);
}


PG_FUNCTION_INFO_V1(uint2_larger);
Datum uint2_larger(PG_FUNCTION_ARGS) {
    uint16		arg1 = PG_GETARG_UINT16(0);
    uint16		arg2 = PG_GETARG_UINT16(1);

    PG_RETURN_UINT16(arg1 > arg2 ? arg1 : arg2);
}


