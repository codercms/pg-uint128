<?php

declare(strict_types=1);

require_once __DIR__ . '/Op.php';
require_once __DIR__ . '/Type.php';

function getTypeOpFuncName(Type $left, Type $right, Op $op): string
{
    return "{$left->pgName}_{$op->value}_{$right->pgName}";
}
