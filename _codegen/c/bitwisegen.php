<?php

declare(strict_types=1);

function genBitwiseFunc(Type $left, Op $op)
{
    $_ = match ($op) {
        Op::And, Op::Or, Op::Xor => 0,
        default => new InvalidArgumentException("Only bitwise ops except 'shl', 'shr', 'not' are supported")
    };

    $funcName = "{$left->pgName}_{$op->value}";
    $cOp = $op->config()->cOp;

    $fn = "PG_FUNCTION_INFO_V1($funcName);\n";
    $fn .= "Datum $funcName(PG_FUNCTION_ARGS) {\n";
    $fn .= "    $left->name a = $left->pgGetArgMacro(0);\n";
    $fn .= "    $left->name b = $left->pgGetArgMacro(1);\n";
    $fn .= "    $left->pgReturnMacro(a $cOp b);\n";
    $fn .= "}\n";

    return $fn;
}

function genBitwiseShiftFunc(Type $left, Op $op)
{
    $_ = match ($op) {
        Op::Shl, Op::Shr => 0,
        default => new InvalidArgumentException("Only bitwise shift ops are supported")
    };

    $funcName = "{$left->pgName}_{$op->value}";
    $cOp = $op->config()->cOp;

    $fn = "PG_FUNCTION_INFO_V1($funcName);\n";
    $fn .= "Datum $funcName(PG_FUNCTION_ARGS) {\n";
    $fn .= "    $left->name a = $left->pgGetArgMacro(0);\n";
    $fn .= "    int32 shift = PG_GETARG_INT32(1);\n";
    $fn .= "    $left->pgReturnMacro(a $cOp shift);\n";
    $fn .= "}\n";

    return $fn;
}

function genBitwiseNotFunc(Type $left, Op $op)
{
    $_ = match ($op) {
        Op::Not => 0,
        default => new InvalidArgumentException("Only bitwise NOT op is supported")
    };

    $funcName = "{$left->pgName}_{$op->value}";
    $cOp = $op->config()->cOp;

    $fn = "PG_FUNCTION_INFO_V1($funcName);\n";
    $fn .= "Datum $funcName(PG_FUNCTION_ARGS) {\n";
    $fn .= "    $left->pgReturnMacro($cOp($left->pgGetArgMacro(0)));\n";
    $fn .= "}\n";

    return $fn;
}

$header = <<<C
// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "int_utils.h"
#include "uint_utils.h"

C;

@mkdir("bitwise");

foreach ([...UINT_TYPES, INT128] as $LEFT_TYPE) {
    $buf = $header . "\n";

    $buf .= genBitwiseFunc($LEFT_TYPE, Op::And) . "\n\n";
    $buf .= genBitwiseFunc($LEFT_TYPE, Op::Or) . "\n\n";
    $buf .= genBitwiseFunc($LEFT_TYPE, Op::Xor) . "\n\n";
    $buf .= genBitwiseNotFunc($LEFT_TYPE, Op::Not) . "\n\n";
    $buf .= genBitwiseShiftFunc($LEFT_TYPE, Op::Shl) . "\n\n";
    $buf .= genBitwiseShiftFunc($LEFT_TYPE, Op::Shr) . "\n\n";

    $file = "bitwise/{$LEFT_TYPE->name}.c";
    file_put_contents($file, $buf);
    echo "$file successfully generated\n";
}
