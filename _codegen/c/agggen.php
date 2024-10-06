<?php

declare(strict_types=1);

require_once __DIR__ . '/../core/index.php';

function genSumAvgAggAcuumFunc(Type $left): string
{
    $suffix = AggOp::Sum->getFuncNameSuffix();
    $funcName = "{$left->pgName}{$suffix}";

    $fn = "PG_FUNCTION_INFO_V1($funcName);\n";
    $fn .= "Datum $funcName(PG_FUNCTION_ARGS) {\n";
    $fn .= "    char buf[{$left->getStrBufLenConstC()}];\n";
    $fn .= "    {$left->name} num = $left->pgGetArgMacro(1);\n";
    $fn .= "\n";
    $fn .= "    Numeric numParsed = {$left->name}_to_numeric(num, buf, sizeof(buf));";
    $fn .= "\n";
    $fn .= "    /* Initialize the FunctionCallInfoData for numeric_avg_accum */\n";
    $fn .= "    fcinfo->args[1].value = NumericGetDatum(numParsed);\n";
    $fn .= "\n";
    $fn .= "    return numeric_avg_accum(fcinfo);\n";
    $fn .= "}\n";

    $funcName = "{$left->pgName}{$suffix}_inv";

    $fn .= "\n";
    $fn .= "PG_FUNCTION_INFO_V1($funcName);\n";
    $fn .= "Datum $funcName(PG_FUNCTION_ARGS) {\n";
    $fn .= "    char buf[{$left->getStrBufLenConstC()}];\n";
    $fn .= "    {$left->name} num = $left->pgGetArgMacro(1);\n";
    $fn .= "\n";
    $fn .= "    Numeric numParsed = {$left->name}_to_numeric(num, buf, sizeof(buf));";
    $fn .= "\n";
    $fn .= "    /* Initialize the FunctionCallInfoData for numeric_accum_inv */\n";
    $fn .= "    fcinfo->args[1].value = NumericGetDatum(numParsed);\n";
    $fn .= "\n";
    $fn .= "    return numeric_accum_inv(fcinfo);\n";
    $fn .= "}\n";

    return $fn;
}

function genMinMaxAggFunc(Type $left, AggOp $op): string
{
    $_ = match ($op) {
        AggOp::Min, AggOp::Max => 0,
        default => new InvalidArgumentException("Only min/max ops are supported")
    };

    $funcName = "{$left->pgName}{$op->getFuncNameSuffix()}";

    $fn = "PG_FUNCTION_INFO_V1($funcName);\n";
    $fn .= "Datum $funcName(PG_FUNCTION_ARGS) {\n";
    $fn .= "    {$left->name}		arg1 = $left->pgGetArgMacro(0);\n";
    $fn .= "    {$left->name}		arg2 = $left->pgGetArgMacro(1);\n";
    $fn .= "    {$left->name}		result;\n";
    $fn .= "\n";

    if ($op === AggOp::Min) {
        $fn .= "    result = ((arg1 < arg2) ? arg1 : arg2);\n";
    } else {
        $fn .= "    result = ((arg1 > arg2) ? arg1 : arg2);\n";
    }

    $fn .= "    $left->pgReturnMacro(result);\n";
    $fn .= "}\n";

    return $fn;
}

$header = <<<C
// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "utils/fmgrprotos.h"
#include "int_utils.h"
#include "uint_utils.h"
#include "numeric_utils.h"

C;

@mkdir("agg");

foreach ([...UINT_TYPES, INT128] as $LEFT_TYPE) {
    $buf = $header . "\n";

    $buf .= genSumAvgAggAcuumFunc($LEFT_TYPE) . "\n\n";

    $buf .= genMinMaxAggFunc($LEFT_TYPE, AggOp::Min) . "\n\n";
    $buf .= genMinMaxAggFunc($LEFT_TYPE, AggOp::Max) . "\n\n";

    $file = "agg/{$LEFT_TYPE->name}.c";
    file_put_contents($file, $buf);
    echo "$file successfully generated\n";
}
