// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "utils/fmgrprotos.h"
#include "int_utils.h"
#include "uint_utils.h"
#include "numeric_utils.h"

PG_FUNCTION_INFO_V1(uint16_avg_accum);
Datum uint16_avg_accum(PG_FUNCTION_ARGS) {
    char buf[UINT128_STRBUFLEN];
    uint128 num = PG_GETARG_UINT128(1);

    Numeric numParsed = uint128_to_numeric(num, buf, sizeof(buf));
    /* Initialize the FunctionCallInfoData for numeric_avg_accum */
    fcinfo->args[1].value = NumericGetDatum(numParsed);

    return numeric_avg_accum(fcinfo);
}

PG_FUNCTION_INFO_V1(uint16_avg_accum_inv);
Datum uint16_avg_accum_inv(PG_FUNCTION_ARGS) {
    char buf[UINT128_STRBUFLEN];
    uint128 num = PG_GETARG_UINT128(1);

    Numeric numParsed = uint128_to_numeric(num, buf, sizeof(buf));
    /* Initialize the FunctionCallInfoData for numeric_accum_inv */
    fcinfo->args[1].value = NumericGetDatum(numParsed);

    return numeric_accum_inv(fcinfo);
}


PG_FUNCTION_INFO_V1(uint16_smaller);
Datum uint16_smaller(PG_FUNCTION_ARGS) {
    uint128		arg1 = PG_GETARG_UINT128(0);
    uint128		arg2 = PG_GETARG_UINT128(1);
    uint128		result;

    result = ((arg1 < arg2) ? arg1 : arg2);
    PG_RETURN_UINT128(result);
}


PG_FUNCTION_INFO_V1(uint16_larger);
Datum uint16_larger(PG_FUNCTION_ARGS) {
    uint128		arg1 = PG_GETARG_UINT128(0);
    uint128		arg2 = PG_GETARG_UINT128(1);
    uint128		result;

    result = ((arg1 > arg2) ? arg1 : arg2);
    PG_RETURN_UINT128(result);
}


