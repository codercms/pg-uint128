// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "utils/fmgrprotos.h"
#include "int_utils.h"
#include "uint_utils.h"
#include "numeric_utils.h"

PG_FUNCTION_INFO_V1(uint8_avg_accum);
Datum uint8_avg_accum(PG_FUNCTION_ARGS) {
    char buf[UINT64_STRBUFLEN];
    uint64 num = PG_GETARG_UINT64(1);

    Numeric numParsed = uint64_to_numeric(num, buf, sizeof(buf));
    /* Initialize the FunctionCallInfoData for numeric_avg_accum */
    fcinfo->args[1].value = NumericGetDatum(numParsed);

    return numeric_avg_accum(fcinfo);
}

PG_FUNCTION_INFO_V1(uint8_avg_accum_inv);
Datum uint8_avg_accum_inv(PG_FUNCTION_ARGS) {
    char buf[UINT64_STRBUFLEN];
    uint64 num = PG_GETARG_UINT64(1);

    Numeric numParsed = uint64_to_numeric(num, buf, sizeof(buf));
    /* Initialize the FunctionCallInfoData for numeric_accum_inv */
    fcinfo->args[1].value = NumericGetDatum(numParsed);

    return numeric_accum_inv(fcinfo);
}


PG_FUNCTION_INFO_V1(uint8_smaller);
Datum uint8_smaller(PG_FUNCTION_ARGS) {
    uint64		arg1 = PG_GETARG_UINT64(0);
    uint64		arg2 = PG_GETARG_UINT64(1);

    PG_RETURN_UINT64(arg1 < arg2 ? arg1 : arg2);
}


PG_FUNCTION_INFO_V1(uint8_larger);
Datum uint8_larger(PG_FUNCTION_ARGS) {
    uint64		arg1 = PG_GETARG_UINT64(0);
    uint64		arg2 = PG_GETARG_UINT64(1);

    PG_RETURN_UINT64(arg1 > arg2 ? arg1 : arg2);
}


