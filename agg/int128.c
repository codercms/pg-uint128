// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "utils/fmgrprotos.h"
#include "int_utils.h"
#include "uint_utils.h"
#include "numeric_utils.h"

PG_FUNCTION_INFO_V1(int16_avg_accum);
Datum int16_avg_accum(PG_FUNCTION_ARGS) {
    char buf[INT128_STRBUFLEN];
    int128 num = PG_GETARG_INT128(1);

    Numeric numParsed = int128_to_numeric(num, buf, sizeof(buf));
    /* Initialize the FunctionCallInfoData for numeric_avg_accum */
    fcinfo->args[1].value = NumericGetDatum(numParsed);

    return numeric_avg_accum(fcinfo);
}

PG_FUNCTION_INFO_V1(int16_avg_accum_inv);
Datum int16_avg_accum_inv(PG_FUNCTION_ARGS) {
    char buf[INT128_STRBUFLEN];
    int128 num = PG_GETARG_INT128(1);

    Numeric numParsed = int128_to_numeric(num, buf, sizeof(buf));
    /* Initialize the FunctionCallInfoData for numeric_accum_inv */
    fcinfo->args[1].value = NumericGetDatum(numParsed);

    return numeric_accum_inv(fcinfo);
}


PG_FUNCTION_INFO_V1(int16_smaller);
Datum int16_smaller(PG_FUNCTION_ARGS) {
    int128		arg1 = PG_GETARG_INT128(0);
    int128		arg2 = PG_GETARG_INT128(1);
    int128		result;

    result = ((arg1 < arg2) ? arg1 : arg2);
    PG_RETURN_INT128(result);
}


PG_FUNCTION_INFO_V1(int16_larger);
Datum int16_larger(PG_FUNCTION_ARGS) {
    int128		arg1 = PG_GETARG_INT128(0);
    int128		arg2 = PG_GETARG_INT128(1);
    int128		result;

    result = ((arg1 > arg2) ? arg1 : arg2);
    PG_RETURN_INT128(result);
}


