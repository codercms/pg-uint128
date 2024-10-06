<?php

declare(strict_types=1);

function getGenSeriesFuncName(Type $type): string
{
    return "generate_series_{$type->pgName}";
}

function getGenSeriesStepFuncName(Type $type): string
{
    return "generate_series_step_{$type->pgName}";
}

function getGenSeriesSupportFuncName(Type $type): string
{
    return "generate_series_{$type->pgName}_support";
}

function getTypeOpFuncName(Type $left, Type $right, Op $op): string
{
    return "{$left->pgName}_{$op->value}_{$right->pgName}";
}

function getRangeSubDiffFuncName(Type $type): string
{
    return "{$type->pgName}_range_subdiff";
}

function getRangeCanonicalFuncName(Type $type): string
{
    return "{$type->pgName}_range_canonical";
}
