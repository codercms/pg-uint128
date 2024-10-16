// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "utils/fmgrprotos.h"
#include "int_utils.h"
#include "uint_utils.h"
#include "numeric_utils.h"

PG_FUNCTION_INFO_V1(uint4_avg_accum);
Datum uint4_avg_accum(PG_FUNCTION_ARGS) {
    char buf[UINT32_STRBUFLEN];
    uint32 num = PG_GETARG_UINT32(1);

    Numeric numParsed = uint32_to_numeric(num, buf, sizeof(buf));
    /* Initialize the FunctionCallInfoData for numeric_avg_accum */
    fcinfo->args[1].value = NumericGetDatum(numParsed);

    return numeric_avg_accum(fcinfo);
}

PG_FUNCTION_INFO_V1(uint4_avg_accum_inv);
Datum uint4_avg_accum_inv(PG_FUNCTION_ARGS) {
    char buf[UINT32_STRBUFLEN];
    uint32 num = PG_GETARG_UINT32(1);

    Numeric numParsed = uint32_to_numeric(num, buf, sizeof(buf));
    /* Initialize the FunctionCallInfoData for numeric_accum_inv */
    fcinfo->args[1].value = NumericGetDatum(numParsed);

    return numeric_accum_inv(fcinfo);
}


PG_FUNCTION_INFO_V1(uint4_smaller);
Datum uint4_smaller(PG_FUNCTION_ARGS) {
    uint32		arg1 = PG_GETARG_UINT32(0);
    uint32		arg2 = PG_GETARG_UINT32(1);

    PG_RETURN_UINT32(arg1 < arg2 ? arg1 : arg2);
}


PG_FUNCTION_INFO_V1(uint4_larger);
Datum uint4_larger(PG_FUNCTION_ARGS) {
    uint32		arg1 = PG_GETARG_UINT32(0);
    uint32		arg2 = PG_GETARG_UINT32(1);

    PG_RETURN_UINT32(arg1 > arg2 ? arg1 : arg2);
}


