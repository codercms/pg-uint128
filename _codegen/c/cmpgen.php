<?php

declare(strict_types=1);

require_once __DIR__ . '/../core/index.php';

function getCmpOpCastedBasedOnBitSize(Type $left, Type $right, Op $op): string
{
    $opC = $op->config()->cOp;

    return match (true) {
        $left->bitSize === $right->bitSize => "a $opC b",
        $left->bitSize > $right->bitSize => "a $opC ($left->name)b",
        default => "($right->name)a $opC b"
    };
}

function getCmpFuncName(Type $left, Type $right, Op $op): string
{
    return "{$left->pgName}_{$op->value}_{$right->pgName}";
}

function genSameSignTypesCmpFunc(Type $left, Type $right, Op $op)
{
    if ($left->isUnsigned != $right->isUnsigned) {
        throw new \InvalidArgumentException("Mixed type comparison is not supported");
    }

    $fnName = getCmpFuncName($left, $right, $op);

    $fn = "PG_FUNCTION_INFO_V1($fnName);\n";
    $fn .= "Datum {$fnName}(PG_FUNCTION_ARGS)\n";
    $fn .= "{\n";
    $fn .= "    const $left->name a = $left->pgGetArgMacro(0);\n";
    $fn .= "    const $right->name b = $right->pgGetArgMacro(1);\n";

    $opPart = getCmpOpCastedBasedOnBitSize($left, $right, $op);

    $fn .= "    PG_RETURN_BOOL($opPart);\n";
    $fn .= "}\n";

    return $fn;
}

function genMixedSignTypesCmpFunc(Type $left, Type $right, Op $op)
{
    if (($left->isUnsigned && $right->isUnsigned) || (!$left->isUnsigned && !$right->isUnsigned)) {
        throw new \InvalidArgumentException("Same sign arithmetic is not allowed");
    }

    $fnName = getCmpFuncName($left, $right, $op);

    $fn = "PG_FUNCTION_INFO_V1($fnName);\n";
    $fn .= "Datum {$fnName}(PG_FUNCTION_ARGS)\n";
    $fn .= "{\n";
    $fn .= "    const $left->name a = $left->pgGetArgMacro(0);\n";
    $fn .= "    const $right->name b = $right->pgGetArgMacro(1);\n";

    $retValOnNegative = match ($op) {
        Op::Eq => 'false',
        Op::Ne => 'true',
        Op::Gt, Op::Ge => $left->isUnsigned ? 'true' : 'false',
        Op::Lt, Op::Le => $left->isUnsigned ? 'false' : 'true',
    };

    $checkNegativeVar = $left->isUnsigned ? 'b' : 'a';
    $fn .= "    if ($checkNegativeVar < 0) {\n        PG_RETURN_BOOL($retValOnNegative);\n    }\n";

    $opPart = getCmpOpCastedBasedOnBitSize($left, $right, $op);

    $fn .= "    PG_RETURN_BOOL($opPart);\n";
    $fn .= "}\n";

    return $fn;
}

$header = <<<C
// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "int_utils.h"
#include "uint_utils.h"

C;

@mkdir("cmp");

foreach (UINT_TYPES as $LEFT_TYPE) {
    $buf = $header;

    $buf .= "\n// Unsigned comparison\n\n";

    foreach (UINT_TYPES as $RIGHT_TYPE) {
        $buf .= genSameSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Eq) . "\n\n";
        $buf .= genSameSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Ne) . "\n\n";
        $buf .= genSameSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Gt) . "\n\n";
        $buf .= genSameSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Lt) . "\n\n";
        $buf .= genSameSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Ge) . "\n\n";
        $buf .= genSameSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Le) . "\n\n";
    }

    $buf .= "// Signed comparison\n\n";

    foreach (INT_TYPES as $RIGHT_TYPE) {
        $buf .= genMixedSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Eq) . "\n\n";
        $buf .= genMixedSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Ne) . "\n\n";
        $buf .= genMixedSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Gt) . "\n\n";
        $buf .= genMixedSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Lt) . "\n\n";
        $buf .= genMixedSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Ge) . "\n\n";
        $buf .= genMixedSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Le) . "\n\n";
    }

    file_put_contents("cmp/{$LEFT_TYPE->name}.c", $buf);
    echo "cmp/{$LEFT_TYPE->name}.c successfully generated\n";
}

foreach (INT_TYPES as $LEFT_TYPE) {
    $buf = $header;

    $buf .= "\n// Signed comparison\n\n";

    foreach (INT_TYPES as $RIGHT_TYPE) {
        $buf .= genSameSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Eq) . "\n\n";
        $buf .= genSameSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Ne) . "\n\n";
        $buf .= genSameSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Gt) . "\n\n";
        $buf .= genSameSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Lt) . "\n\n";
        $buf .= genSameSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Ge) . "\n\n";
        $buf .= genSameSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Le) . "\n\n";
    }

    $buf .= "// Unsigned comparison\n\n";

    foreach (UINT_TYPES as $RIGHT_TYPE) {
        $buf .= genMixedSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Eq) . "\n\n";
        $buf .= genMixedSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Ne) . "\n\n";
        $buf .= genMixedSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Gt) . "\n\n";
        $buf .= genMixedSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Lt) . "\n\n";
        $buf .= genMixedSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Ge) . "\n\n";
        $buf .= genMixedSignTypesCmpFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Le) . "\n\n";
    }

    file_put_contents("cmp/{$LEFT_TYPE->name}.c", $buf);
    echo "cmp/{$LEFT_TYPE->name}.c successfully generated\n";
}
