<?php

declare(strict_types=1);

require_once __DIR__ . '/../core/index.php';

function getArithmFuncName(Type $left, Type $right, Op $op): string
{
    return "{$left->pgName}_{$op->value}_{$right->pgName}";
}

function getOverflowFuncName(Type $left, Type $right, Op $op): string
{
    $prefix = $left->isUnsigned ? 'u' : 's';

    $name = "{$op->value}_{$prefix}{$left->bitSize}";

//    if ($left->isUnsigned !== $right->isUnsigned) {
//        $prefix = $right->isUnsigned ? 'u' : 's';
//        $name .= "_{$prefix}{$right->bitSize}";
//    }

    $name .= "_overflow";

    return $name;
}

function getArithmOpCastedBasedOnBitSize(Type $left, Type $right, Op $op): string
{
    $opC = $op->config()->cOp;

    return match (true) {
        $left->bitSize === $right->bitSize => "a $opC b",
        $left->bitSize > $right->bitSize => "a $opC ($left->name)b",
        default => "($right->name)a $opC b"
    };
}

function genSameSignArithmFunc(Type $left, Type $right, Op $op)
{
    if ($left->isUnsigned != $right->isUnsigned) {
        throw new \InvalidArgumentException("Mixed type arithmetic is not supported");
    }

    $fnName = getArithmFuncName($left, $right, $op);

    $fn = "PG_FUNCTION_INFO_V1($fnName);\n";
    $fn .= "Datum {$fnName}(PG_FUNCTION_ARGS)\n";
    $fn .= "{\n";
    $fn .= "    $left->name a = $left->pgGetArgMacro(0);\n";
    $fn .= "    $right->name b = $right->pgGetArgMacro(1);\n";

    if ($op->isDivision()) {
        $fn .= "    if (b == 0) {\n";
        $fn .= "        DIVISION_BY_ZERO_ERR;\n";
        $fn .= "    }\n";

        $opParam = getArithmOpCastedBasedOnBitSize($left, $right, $op);

        $fn .= "    $left->pgReturnMacro($opParam);\n";
        $fn .= "}\n";

        return $fn;
    }

    if ($op->canOverflow()) {
        $fn .= "    $left->name result = 0;\n";

        // Handle potential overflow before casting
        if ($right->bitSize > $left->bitSize) {
            $fn .= "    if (b > {$left->getMaxConstC()}) {\n";
            $fn .= "        OUT_OF_RANGE_ERR($left->pgName);\n";
            $fn .= "    }\n";
        }

        $overflowFn = getOverflowFuncName($left, $right, $op);
        $fn .= "    if ($overflowFn(a, b, &result)) {\n";
        $fn .= "        OUT_OF_RANGE_ERR($left->pgName);\n";
        $fn .= "    }\n";
        $fn .= "    $left->pgReturnMacro(result);\n";
    } else {
        throw new \InvalidArgumentException("Unknown op {$op->value}");
    }

    $fn .= "}\n";

    return $fn;
}

function genUIntWithSignedIntArithmFunc(Type $left, Type $right, Op $op)
{
    if (!$left->isUnsigned || $right->isUnsigned) {
        throw new \InvalidArgumentException("Only uint with signed int arithmetic is supported");
    }

    $fnName = getArithmFuncName($left, $right, $op);

    $fn = "PG_FUNCTION_INFO_V1($fnName);\n";
    $fn .= "Datum {$fnName}(PG_FUNCTION_ARGS)\n";
    $fn .= "{\n";
    $fn .= "    $left->name a = $left->pgGetArgMacro(0);\n";
    $fn .= "    $right->name b = $right->pgGetArgMacro(1);\n";

    if ($op->isDivision()) {
        $fn .= "    if (b == 0) {\n";
        $fn .= "        DIVISION_BY_ZERO_ERR;\n";
        $fn .= "    }\n";
        $fn .= "    if (b < 0) {\n";
        $fn .= "        UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR;\n";
        $fn .= "    }\n";

        $fn .= "    if (b > a) {\n";
        $fn .= "        $left->pgReturnMacro(" . ($op === Op::Div ? '0' : 'a') . ");\n";
        $fn .= "    }\n";

        $cOp = $op->config()->sign;

        $fn .= "    $left->pgReturnMacro(a $cOp ($left->name)b);\n";
        $fn .= "}\n";

        return $fn;
    }

    if ($op->canOverflow()) {
        $fn .= "    $left->name result = 0;\n";

        // Cannot multiple unsigned int by negative signed int
        if ($op === Op::Mul) {
            $fn .= "    if (b < 0) {\n";
            $fn .= "        UINT_MULTIPLY_BY_NEGATIVE_SIGNED_INT_ERR;\n";
            $fn .= "    }\n";
        }

        // Handle potential overflow before casting
        if ($right->bitSize > $left->bitSize) {
            $fn .= "    if (b > {$left->getMaxConstC()}) {\n";
            $fn .= "        OUT_OF_RANGE_ERR($left->pgName);\n";
            $fn .= "    }\n";
        }

        $negOp = match ($op) {
            Op::Add => Op::Sub,
            Op::Sub => Op::Add,
            Op::Mul => null,
            default => throw new InvalidArgumentException("Unknown op {$op->value}")
        };

        // Handle negative signed integers
        if ($negOp) {
            $negOverflowFn = getOverflowFuncName($left, $right, $negOp);

            $fn .= "    if (b < 0) {\n";
            $fn .= "        if ($negOverflowFn(a, -b, &result)) {\n";
            $fn .= "            OUT_OF_RANGE_ERR($left->pgName);\n";
            $fn .= "        }\n";
            $fn .= "    }\n";
        }

        $overflowFn = getOverflowFuncName($left, $right, $op);
        $fn .= "    if ($overflowFn(a, b, &result)) {\n";
        $fn .= "        OUT_OF_RANGE_ERR($left->pgName);\n";
        $fn .= "    }\n";
        $fn .= "    $left->pgReturnMacro(result);\n";
    } else {
        throw new \InvalidArgumentException("Unknown op {$op->value}");
    }

    $fn .= "}\n";

    return $fn;
}

function genSignedIntWithUIntArithmFunc(Type $left, Type $right, Op $op)
{
    if ($left->isUnsigned || !$right->isUnsigned) {
        throw new \InvalidArgumentException("Only signed int with uint arithmetic is supported");
    }

    $fnName = getArithmFuncName($left, $right, $op);

    $fn = "PG_FUNCTION_INFO_V1($fnName);\n";
    $fn .= "Datum {$fnName}(PG_FUNCTION_ARGS)\n";
    $fn .= "{\n";
    $fn .= "    $left->name a = $left->pgGetArgMacro(0);\n";
    $fn .= "    $right->name b = $right->pgGetArgMacro(1);\n";

    if ($op->isDivision()) {
        $fn .= "    if (b == 0) {\n";
        $fn .= "        DIVISION_BY_ZERO_ERR;\n";
        $fn .= "    }\n";

        /**
         * In integer division, any division where the absolute value of the numerator is less than the denominator results in 0.
         * In integer modulo, any division where the absolute value of the numerator is less than the denominator results in original value of numerator.
         */
        $fn .= "    if (Abs(a) < b) {\n";
        $fn .= "        $left->pgReturnMacro(" . ($op === Op::Div ? '0' : 'a') . ");\n";
        $fn .= "    }\n";

        $cOp = $op->config()->sign;

        $fn .= "    $left->pgReturnMacro(a $cOp ($left->name)b);\n";
        $fn .= "}\n";

        return $fn;
    }

    if ($op->canOverflow()) {
        $fn .= "    $left->name result = 0;\n";

        // Handle potential overflow before casting
        if ($right->bitSize >= $left->bitSize) {
            $fn .= "    if (b > {$left->getMaxConstC()}) {\n";
            $fn .= "        OUT_OF_RANGE_ERR($left->pgName);\n";
            $fn .= "    }\n";
        }

        $overflowFn = getOverflowFuncName($left, $right, $op);
        $fn .= "    if ($overflowFn(a, b, &result)) {\n";
        $fn .= "        OUT_OF_RANGE_ERR($left->pgName);\n";
        $fn .= "    }\n";
        $fn .= "    $left->pgReturnMacro(result);\n";
    } else {
        throw new \InvalidArgumentException("Unknown op {$op->value}");
    }

    $fn .= "}\n";

    return $fn;
}

$header = <<<C
// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "int_utils.h"
#include "uint_utils.h"

C;

@mkdir("arithm");

foreach (UINT_TYPES as $LEFT_TYPE) {
    $buf = $header;

    $buf .= "\n// UINT with UINT arithmetic funcs\n\n";

    foreach (UINT_TYPES as $RIGHT_TYPE) {
        $buf .= genSameSignArithmFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Add) . "\n\n";
        $buf .= genSameSignArithmFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Sub) . "\n\n";
        $buf .= genSameSignArithmFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Mul) . "\n\n";
        $buf .= genSameSignArithmFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Div) . "\n\n";
        $buf .= genSameSignArithmFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Mod) . "\n\n";
    }

    $buf .= "\n// Mixed sign, UINT with INT (signed) arithmetic funcs\n\n";

    foreach (INT_TYPES as $RIGHT_TYPE) {
        $buf .= genUIntWithSignedIntArithmFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Add) . "\n\n";
        $buf .= genUIntWithSignedIntArithmFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Sub) . "\n\n";
        $buf .= genUIntWithSignedIntArithmFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Mul) . "\n\n";
        $buf .= genUIntWithSignedIntArithmFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Div) . "\n\n";
        $buf .= genUIntWithSignedIntArithmFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Mod) . "\n\n";
    }

    file_put_contents("arithm/{$LEFT_TYPE->name}.c", $buf);
    echo "arithm/{$LEFT_TYPE->name}.c successfully generated\n";
}

foreach (INT_TYPES as $LEFT_TYPE) {
    $buf = $header;

    $buf .= "\n// INT with INT (signed) arithmetic funcs\n\n";

    $buf .= genSameSignArithmFunc(INT128, $LEFT_TYPE, Op::Add) . "\n\n";
    $buf .= genSameSignArithmFunc(INT128, $LEFT_TYPE, Op::Sub) . "\n\n";
    $buf .= genSameSignArithmFunc(INT128, $LEFT_TYPE, Op::Mul) . "\n\n";
    $buf .= genSameSignArithmFunc(INT128, $LEFT_TYPE, Op::Div) . "\n\n";
    $buf .= genSameSignArithmFunc(INT128, $LEFT_TYPE, Op::Mod) . "\n\n";

    $buf .= "\n// Mixed sign, signed INT with UINT arithmetic funcs\n\n";

    foreach (UINT_TYPES as $RIGHT_TYPE) {
        $buf .= genSignedIntWithUIntArithmFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Add) . "\n\n";
        $buf .= genSignedIntWithUIntArithmFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Sub) . "\n\n";
        $buf .= genSignedIntWithUIntArithmFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Mul) . "\n\n";
        $buf .= genSignedIntWithUIntArithmFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Div) . "\n\n";
        $buf .= genSignedIntWithUIntArithmFunc($LEFT_TYPE, $RIGHT_TYPE, Op::Mod) . "\n\n";
    }

    file_put_contents("arithm/{$LEFT_TYPE->name}.c", $buf);
    echo "arithm/{$LEFT_TYPE->name}.c successfully generated\n";
}
