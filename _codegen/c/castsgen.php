<?php

declare(strict_types=1);

require_once __DIR__ . '/../core/index.php';

function getCastUIntFromIntFunc(Type $left, Type $right): string
{
    if (!$left->isUnsigned || $right->isUnsigned) {
        throw new InvalidArgumentException("Only cast uint from signed int is supported");
    }

    $funcName = "{$left->pgName}_from_{$right->pgName}";

    $fn = "PG_FUNCTION_INFO_V1($funcName);\n";
    $fn .= "Datum $funcName(PG_FUNCTION_ARGS) {\n";
    $fn .= "    $right->name a = $right->pgGetArgMacro(0);\n";
    $fn .= "    if (a < 0) {\n";
    $fn .= "        OUT_OF_RANGE_ERR($left->pgName);\n";
    $fn .= "    }\n";
    $fn .= "\n";

    // Check for overflow when casting wider integer types than receiver type
    if ($right->bitSize > $left->bitSize) {
        $fn .= "    if (a > {$left->getMaxConstC()}) {\n";
        $fn .= "        OUT_OF_RANGE_ERR($left->pgName);\n";
        $fn .= "    }\n";
    }

    $fn .= "    $left->pgReturnMacro(($left->name) a);\n";
    $fn .= "}\n";

    return $fn;
}

function getCastIntFromUIntFunc(Type $left, Type $right): string
{
    if ($left->isUnsigned || !$right->isUnsigned) {
        throw new InvalidArgumentException("Only cast signed int from uint is supported");
    }

    $funcName = "{$left->pgName}_from_{$right->pgName}";

    $fn = "PG_FUNCTION_INFO_V1($funcName);\n";
    $fn .= "Datum $funcName(PG_FUNCTION_ARGS) {\n";
    $fn .= "    $right->name a = $right->pgGetArgMacro(0);\n";
    $fn .= "\n";

    // Check for overflow when casting wider integer types than receiver type
    if ($right->bitSize >= $left->bitSize) {
        $fn .= "    if (a > {$left->getMaxConstC()}) {\n";
        $fn .= "        OUT_OF_RANGE_ERR($left->pgName);\n";
        $fn .= "    }\n";
    }

    $fn .= "    $left->pgReturnMacro(($left->name) a);\n";
    $fn .= "}\n";

    return $fn;
}

function getCastIntFromIntFunc(Type $left, Type $right): string
{
    if ($left->isUnsigned || $right->isUnsigned) {
        throw new InvalidArgumentException("Only cast signed int from signed int is supported");
    }

    $funcName = "{$left->pgName}_from_{$right->pgName}";

    $fn = "PG_FUNCTION_INFO_V1($funcName);\n";
    $fn .= "Datum $funcName(PG_FUNCTION_ARGS) {\n";
    $fn .= "    $right->name a = $right->pgGetArgMacro(0);\n";
    $fn .= "\n";

    // Check for overflow when casting wider integer types than receiver type
    if ($right->bitSize > $left->bitSize) {
        $fn .= "    if (a > {$left->getMaxConstC()} || a < {$left->getMinConstC()}) {\n";
        $fn .= "        OUT_OF_RANGE_ERR($left->pgName);\n";
        $fn .= "    }\n";
    }

    $fn .= "    $left->pgReturnMacro(($left->name) a);\n";
    $fn .= "}\n";

    return $fn;
}

function getCastUIntFromUIntFunc(Type $left, Type $right): string
{
    if (!$left->isUnsigned || !$right->isUnsigned) {
        throw new InvalidArgumentException("Only cast uint from uint is supported");
    }

    $funcName = "{$left->pgName}_from_{$right->pgName}";

    $fn = "PG_FUNCTION_INFO_V1($funcName);\n";
    $fn .= "Datum $funcName(PG_FUNCTION_ARGS) {\n";
    $fn .= "    $right->name a = $right->pgGetArgMacro(0);\n";
    $fn .= "\n";

    // Check for overflow when casting wider integer types than receiver type
    if ($right->bitSize > $left->bitSize) {
        $fn .= "    if (a > {$left->getMaxConstC()}) {\n";
        $fn .= "        OUT_OF_RANGE_ERR($left->pgName);\n";
        $fn .= "    }\n";
    }

    $fn .= "    $left->pgReturnMacro(($left->name) a);\n";
    $fn .= "}\n";

    return $fn;
}

function getCastUIntToIntFunc(Type $left, Type $right): string
{
    if (!$left->isUnsigned || $right->isUnsigned) {
        throw new InvalidArgumentException("Only cast uint to signed int is supported");
    }

    $funcName = "{$left->pgName}_to_{$right->pgName}";

    $fn = "PG_FUNCTION_INFO_V1($funcName);\n";
    $fn .= "Datum $funcName(PG_FUNCTION_ARGS) {\n";
    $fn .= "    $left->name a = $left->pgGetArgMacro(0);\n";
    $fn .= "\n";

    // Check for overflow when casting wider integer types than receiver type
    if ($left->bitSize >= $right->bitSize) {
        $fn .= "    if (a > {$right->getMaxConstC()}) {\n";
        $fn .= "        OUT_OF_RANGE_ERR($right->pgName);\n";
        $fn .= "    }\n";
    }

    $fn .= "    $right->pgReturnMacro(($right->name) a);\n";
    $fn .= "}\n";

    return $fn;
}

function getCastIntToUIntFunc(Type $left, Type $right): string
{
    if ($left->isUnsigned || !$right->isUnsigned) {
        throw new InvalidArgumentException("Only cast signed int to uint is supported");
    }

    $funcName = "{$left->pgName}_to_{$right->pgName}";

    $fn = "PG_FUNCTION_INFO_V1($funcName);\n";
    $fn .= "Datum $funcName(PG_FUNCTION_ARGS) {\n";
    $fn .= "    $left->name a = $left->pgGetArgMacro(0);\n";
    $fn .= "\n";
    $fn .= "    if (a < 0) {\n";
    $fn .= "        OUT_OF_RANGE_ERR($right->pgName);\n";
    $fn .= "    }\n";

    // Check for overflow when casting wider integer types than receiver type
    if ($left->bitSize > $right->bitSize) {
        $fn .= "    if (a > {$right->getMaxConstC()}) {\n";
        $fn .= "        OUT_OF_RANGE_ERR($right->pgName);\n";
        $fn .= "    }\n";
    }

    $fn .= "    $right->pgReturnMacro(($right->name) a);\n";
    $fn .= "}\n";

    return $fn;
}

function getCastIntToIntFunc(Type $left, Type $right): string
{
    if ($left->isUnsigned || $right->isUnsigned) {
        throw new InvalidArgumentException("Only cast signed int to signed int is supported");
    }

    $funcName = "{$left->pgName}_to_{$right->pgName}";

    $fn = "PG_FUNCTION_INFO_V1($funcName);\n";
    $fn .= "Datum $funcName(PG_FUNCTION_ARGS) {\n";
    $fn .= "    $left->name a = $left->pgGetArgMacro(0);\n";
    $fn .= "\n";

    // Check for overflow when casting wider integer types than receiver type
    if ($left->bitSize > $right->bitSize) {
        $fn .= "    if (a > {$right->getMaxConstC()} || a < {$right->getMinConstC()}) {\n";
        $fn .= "        OUT_OF_RANGE_ERR($right->pgName);\n";
        $fn .= "    }\n";
    }

    $fn .= "    $right->pgReturnMacro(($right->name) a);\n";
    $fn .= "}\n";

    return $fn;
}

function getCastUIntToUIntFunc(Type $left, Type $right): string
{
    if (!$left->isUnsigned || !$right->isUnsigned) {
        throw new InvalidArgumentException("Only cast uint to uint is supported");
    }

    $funcName = "{$left->pgName}_to_{$right->pgName}";

    $fn = "PG_FUNCTION_INFO_V1($funcName);\n";
    $fn .= "Datum $funcName(PG_FUNCTION_ARGS) {\n";
    $fn .= "    $left->name a = $left->pgGetArgMacro(0);\n";
    $fn .= "\n";

    // Check for overflow when casting wider integer types than receiver type
    if ($left->bitSize > $right->bitSize) {
        $fn .= "    if (a > {$right->getMaxConstC()}) {\n";
        $fn .= "        OUT_OF_RANGE_ERR($right->pgName);\n";
        $fn .= "    }\n";
    }

    $fn .= "    $right->pgReturnMacro(($right->name) a);\n";
    $fn .= "}\n";

    return $fn;
}

$header = <<<C
// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "int_utils.h"
#include "uint_utils.h"

C;

@mkdir("casts");

foreach (UINT_TYPES as $LEFT_TYPE) {
    $buf = $header;

    $buf .= "\n// Unsigned casts\n\n";

    foreach (UINT_TYPES as $RIGHT_TYPE) {
        if ($RIGHT_TYPE === $LEFT_TYPE) {
            continue;
        }

        $buf .= getCastUIntFromUIntFunc($LEFT_TYPE, $RIGHT_TYPE) . "\n\n";
        $buf .= getCastUIntToUIntFunc($LEFT_TYPE, $RIGHT_TYPE) . "\n\n";
    }

    $buf .= "// Signed casts\n\n";

    foreach (INT_TYPES as $RIGHT_TYPE) {
        $buf .= getCastUIntFromIntFunc($LEFT_TYPE, $RIGHT_TYPE) . "\n\n";
        $buf .= getCastUIntToIntFunc($LEFT_TYPE, $RIGHT_TYPE) . "\n\n";
    }

    file_put_contents("casts/{$LEFT_TYPE->name}.c", $buf);
    echo "casts/{$LEFT_TYPE->name}.c successfully generated\n";
}

foreach (INT_TYPES as $LEFT_TYPE) {
    $buf = $header;

    $buf .= "\n// Signed comparison\n\n";

    foreach (INT_TYPES as $RIGHT_TYPE) {
        if ($RIGHT_TYPE === $LEFT_TYPE) {
            continue;
        }

        $buf .= getCastIntFromIntFunc($LEFT_TYPE, $RIGHT_TYPE) . "\n\n";
        $buf .= getCastIntToIntFunc($LEFT_TYPE, $RIGHT_TYPE) . "\n\n";
    }

    $buf .= "// Unsigned comparison\n\n";

    foreach (UINT_TYPES as $RIGHT_TYPE) {
        $buf .= getCastIntFromUIntFunc($LEFT_TYPE, $RIGHT_TYPE) . "\n\n";
        $buf .= getCastIntToUIntFunc($LEFT_TYPE, $RIGHT_TYPE) . "\n\n";
    }

    file_put_contents("casts/{$LEFT_TYPE->name}.c", $buf);
    echo "casts/{$LEFT_TYPE->name}.c successfully generated\n";
}
