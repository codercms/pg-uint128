<?php

declare(strict_types=1);

require_once __DIR__ . '/../core/index.php';

$extName = 'uint128';

function genSQLCmpFunc(Op $op, Type $leftType, Type $rightType): string
{
    global $extName;

    $funcName = getTypeOpFuncName($leftType, $rightType, $op);

    return <<<EOL
CREATE FUNCTION $funcName($leftType->pgName, $rightType->pgName) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/$extName', '$funcName';
EOL;
}

function genSQLArithmeticFunc(Op $op, Type $leftType, Type $rightType): string
{
    global $extName;

    $funcName = getTypeOpFuncName($leftType, $rightType, $op);

    return <<<EOL
CREATE FUNCTION $funcName($leftType->pgName, $rightType->pgName) RETURNS {$leftType->pgName}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/$extName', '$funcName';
EOL;
}

/**
 * @return array{0: string, 1: string}
 */
function genSQLTestForCmpOp(Op $op, Type $leftType, Type $rightType): array
{
    if (!$op->isCMP()) {
        throw new InvalidArgumentException("Op $op->value is not comparison op");
    }

    $opSign = $op->config()->sign;

    $ops = match ($op) {
        Op::Eq => [['1', '1', 't'], ['1', '0', 'f']],
        Op::Ne => [['1', '0', 't'], ['0', '0', 'f']],

        Op::Gt => [['1', '0', 't'], ['0', '1', 'f']],
        Op::Lt => [['0', '1', 't'], ['1', '0', 'f']],

        Op::Ge => [['1', '0', 't'], ['0', '1', 'f'], ['1', '1', 't']],
        Op::Le => [['0', '1', 't'], ['1', '0', 'f'], ['1', '1', 't']],
    };

    $sql = '';
    $expected = '';

    foreach ($ops as $op) {
        $q = "SELECT $op[0]::$leftType->pgName $opSign $op[1]::$rightType->pgName;\n";

        $sql .= $q;

        $expected .= $q;
        $expected .= " ?column? \n";
        $expected .= "----------\n";
        $expected .= " $op[2]\n";
        $expected .= "(1 row)\n\n";
    }

    return [$sql, $expected];
}

/**
 * @return array{0: string, 1: string}
 */
function genSQLTestForOverflowOp(Op $op, Type $leftType, Type $rightType): array
{
    if (!$op->canOverflow()) {
        throw new InvalidArgumentException("Op $op->value cannot overflow");
    }

    $opSign = $op->config()->sign;

    [$leftVal, $rightVal] = match ($op) {
        Op::Add => [$leftType->maxValue, '1'],
        Op::Sub => [$leftType->getPgSqlMinVal(), '1'],
        Op::Mul => [$leftType->maxValue, '2'],
    };

    $sql = "SELECT $leftVal::$leftType->pgName $opSign $rightVal::$rightType->pgName;\n";

    $expected = $sql;
    $expected .= "ERROR:  $leftType->pgName out of range\n";

    return [$sql, $expected];
}

/**
 * @return array{0: string, 1: string}
 */
function genSQLTestForArithmOp(Op $op, Type $leftType, Type $rightType): array
{
    if (!$op->isArithmetic()) {
        throw new InvalidArgumentException("Op $op->value is not arithmetic op");
    }

    $opSign = $op->config()->sign;

    $sql = "SELECT 120::$leftType->pgName $opSign 10::$rightType->pgName;\n";

    $expectedVal = match ($op) {
        Op::Add => '130',
        Op::Sub => '110',
        Op::Mul => '1200',
        Op::Div => '12',
        Op::Mod => '0'
    };

    $expected = $sql;
    $expected .= " ?column? \n";
    $expected .= "----------\n";

    // psql has different formatting for signed and unsigned integers
    $expected .= $leftType->isUnsigned
        ? " $expectedVal\n"
        : str_pad($expectedVal, strlen("----------") - 1, pad_type: STR_PAD_LEFT) . "\n";

    $expected .= "(1 row)\n\n";

    if ($leftType !== $rightType) {
        // Ops that could potentially overflow has to be checked for overflow
        if ($op->canOverflow()) {
            [$overflowSql, $overflowExpected] = genSQLTestForOverflowOp($op, $leftType, $rightType);

            $sql .= $overflowSql;
            $expected .= $overflowExpected;
        }

        // Division ops has to be checked for division by zero
        if ($op->isDivision()) {
            $q = "SELECT 1::$leftType->pgName $opSign 0::$rightType->pgName;\n";

            $sql .= $q;
            $expected .= $q . "ERROR:  division by zero\n";
        }

        // Check mixed signed and unsigned arithmetic
        if (!$leftType->isUnsigned && $rightType->isUnsigned) {
            $q = "SELECT (-120)::$leftType->pgName $opSign 10::$rightType->pgName;\n";

            $expectedVal = match ($op) {
                Op::Add => '-110',
                Op::Sub => '-130',
                Op::Mul => '-1200',
                Op::Div => '-12',
                Op::Mod => '0'
            };

            $sql .= $q;

            $expected .= $q;
            $expected .= " ?column? \n";
            $expected .= "----------\n";

            // psql has different formatting for signed and unsigned integers
            $expected .= $leftType->isUnsigned
                ? " $expectedVal\n"
                : str_pad($expectedVal, strlen("----------") - 1, pad_type: STR_PAD_LEFT) . "\n";

            $expected .= "(1 row)\n\n";
        }
    }

    return [$sql, $expected];
}

class TypeOpConfig
{
    /**
     * @param array<Type> $types
     */
    public function __construct(
        public readonly Op $op,
        public readonly array $types = [],
        public readonly bool $inverseTypes = false,
    ) {
    }

    public function getSQLFunc(string $extName, TypeConfig $parent, bool $crossTypesOnly): string
    {
        $cmpFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;

            $sql = "";

            if (!$crossTypesOnly) {
                $sql .= genSQLCmpFunc($op, $parent->type, $parent->type) . "\n\n";
            }

            foreach ($this->types as $EXT_TYPE) {
                $sql .= genSQLCmpFunc($op, $parent->type, $EXT_TYPE) . "\n\n";

                if ($this->inverseTypes) {
                    $sql .= genSQLCmpFunc($op, $EXT_TYPE, $parent->type) . "\n\n";
                }
            }

            return $sql;
        };

        $arithmFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;

            $sql = '';

            if (!$crossTypesOnly) {
                $sql .= genSQLArithmeticFunc($op, $parent->type, $parent->type) . "\n\n";
            }

            foreach ($this->types as $EXT_TYPE) {
                $sql .= genSQLArithmeticFunc($op, $parent->type, $EXT_TYPE) . "\n\n";

                if ($this->inverseTypes) {
                    $sql .= genSQLArithmeticFunc($op, $EXT_TYPE, $parent->type) . "\n\n";
                }
            }

            return $sql;
        };

        $bitwiseShiftFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;
            $sql = '';

            if (!$crossTypesOnly) {
                $funcName = "{$parent->type->pgName}_$op->value";

                $sql .= <<<EOT
CREATE FUNCTION $funcName({$parent->type->pgName}, int4) RETURNS {$parent->type->pgName}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/$extName', '$funcName';


EOT;
            }

            return $sql;
        };

        $bitwiseFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;
            $sql = '';

            if (!$crossTypesOnly) {
                $funcName = "{$parent->type->pgName}_$op->value";

                $sql .= <<<EOT
CREATE FUNCTION $funcName({$parent->type->pgName}, {$parent->type->pgName}) RETURNS {$parent->type->pgName}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/$extName', '$funcName';


EOT;
            }

            return $sql;
        };

        $notFunc = function () use ($extName, $parent): string {
            $op = $this->op;

            $funcName = "{$parent->type->pgName}_$op->value";

            return <<<EOT
CREATE FUNCTION $funcName({$parent->type->pgName}) RETURNS {$parent->type->pgName}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/$extName', '$funcName';

EOT;
        };

        return match ($this->op) {
            Op::Eq, Op::Ne, Op::Gt, Op::Lt, Op::Ge, Op::Le => $cmpFunc(),
            Op::Add, Op::Sub, Op::Mul, Op::Div, Op::Mod => $arithmFunc(),
            Op::Xor, Op::And, Op::Or => $bitwiseFunc(),
            Op::Shl, Op::Shr => $bitwiseShiftFunc(),
            Op::Not => $notFunc(),
        };
    }

    public function getSQLOperator(string $extName, TypeConfig $parent, bool $crossTypesOnly): string
    {
        $cmpFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;
            $cfg = $op->config();

            $sql = '';

            if (!$crossTypesOnly) {
                $funcName = getTypeOpFuncName($parent->type, $parent->type, $op);

                $sql .= $cfg->toSQL(
                        $funcName,
                        $parent->name,
                        $parent->name
                    ) . "\n";
            }

            foreach ($this->types as $EXT_TYPE) {
                $funcName = getTypeOpFuncName($parent->type, $EXT_TYPE, $op);

                $sql .= $cfg->toSQL($funcName, $parent->name, $EXT_TYPE->pgName) . "\n";

                if ($this->inverseTypes) {
                    $funcName = getTypeOpFuncName($EXT_TYPE, $parent->type, $op);

                    $sql .= $cfg->toSQL($funcName, $EXT_TYPE->pgName, $parent->name) . "\n";
                }
            }

            return $sql;
        };

        $arithmFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;
            $cfg = $op->config();

            $sql = '';

            if (!$crossTypesOnly) {
                $funcName = getTypeOpFuncName($parent->type, $parent->type, $op);

                $sql = $cfg->toSQL($funcName, $parent->name, $parent->name) . "\n";
            }

            foreach ($this->types as $EXT_TYPE) {
                $funcName = getTypeOpFuncName($parent->type, $EXT_TYPE, $op);

                $sql .= $cfg->toSQL($funcName, $parent->name, $EXT_TYPE->pgName) . "\n";

                if ($this->inverseTypes) {
                    $funcName = getTypeOpFuncName($EXT_TYPE, $parent->type, $op);

                    $sql .= $cfg->toSQL($funcName, $EXT_TYPE->pgName, $parent->name) . "\n";
                }
            }

            return $sql;
        };

        $bitwiseFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;
            $cfg = $op->config();

            $sql = '';

            if (!$crossTypesOnly) {
                $funcName = "{$parent->type->pgName}_{$op->value}";

                $sql = $cfg->toSQL($funcName, $parent->name, $parent->name) . "\n";
            }

            foreach ($this->types as $EXT_TYPE) {
                $funcName = getTypeOpFuncName($parent->type, $EXT_TYPE, $op);

                $sql .= $cfg->toSQL($funcName, $parent->name, $EXT_TYPE->pgName) . "\n";

                if ($this->inverseTypes) {
                    $funcName = getTypeOpFuncName($EXT_TYPE, $parent->type, $op);

                    $sql .= $cfg->toSQL($funcName, $EXT_TYPE->pgName, $parent->name) . "\n";
                }
            }

            return $sql;
        };

        $bitwiseShiftFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;
            $cfg = $op->config();

            if (!$crossTypesOnly) {
                $sql = $cfg->toSQL("{$parent->name}_$op->value", $parent->name, 'int4') . "\n";
            } else {
                $sql = '';
            }

            return $sql;
        };

        $notFunc = function () use ($extName, $parent): string {
            $op = $this->op;
            $cfg = $op->config();

            return $cfg->toSQL("{$parent->name}_$op->value", null, $parent->name) . "\n";
        };

        $sql = match ($this->op) {
            Op::Eq, Op::Ne, Op::Gt, Op::Lt, Op::Ge, Op::Le => $cmpFunc(),
            Op::Add, Op::Sub, Op::Mul, Op::Div, Op::Mod => $arithmFunc(),
            Op::Xor, Op::And, Op::Or => $bitwiseFunc(),
            Op::Shl, Op::Shr => $bitwiseShiftFunc(),
            Op::Not => $notFunc(),
        };

        return $sql;
    }

    /**
     * @return array{0: string, 1: string}
     */
    public function getSQLTest(TypeConfig $parent, bool $crossTypesOnly): array
    {
        $cmpFunc = function () use ($parent, $crossTypesOnly): array {
            $sql = '';
            $expected = '';

            if (!$crossTypesOnly) {
                [$cQ, $cE] = genSQLTestForCmpOp($this->op, $parent->type, $parent->type);

                $sql .= $cQ;
                $expected .= $cE;
            }

            foreach ($this->types as $EXT_TYPE) {
                [$cQ, $cE] = genSQLTestForCmpOp($this->op, $parent->type, $EXT_TYPE);

                $sql .= $cQ;
                $expected .= $cE;

                if ($this->inverseTypes) {
                    [$cQ, $cE] = genSQLTestForCmpOp($this->op, $EXT_TYPE, $parent->type);

                    $sql .= $cQ;
                    $expected .= $cE;
                }
            }

            if ($sql !== '') {
                $sql .= "\n";
            }

            return [$sql, $expected];
        };

        $arithmFunc = function () use ($parent, $crossTypesOnly): array {
            $sql = '';
            $expected = '';

            if (!$crossTypesOnly) {
                [$sq, $ex] = genSQLTestForArithmOp($this->op, $parent->type, $parent->type);
                $sql .= $sq;
                $expected .= $ex;
            }

            foreach ($this->types as $EXT_TYPE) {
                [$sq, $ex] = genSQLTestForArithmOp($this->op, $parent->type, $EXT_TYPE);
                $sql .= $sq;
                $expected .= $ex;

                if ($this->inverseTypes) {
                    [$sq, $ex] = genSQLTestForArithmOp($this->op, $EXT_TYPE, $parent->type);
                    $sql .= $sq;
                    $expected .= $ex;
                }
            }

            if ($sql !== '') {
                $sql .= "\n";
            }

            return [$sql, $expected];
        };

        [$sql, $expected] = match ($this->op) {
            Op::Eq, Op::Ne, Op::Gt, Op::Lt, Op::Ge, Op::Le => $cmpFunc(),
            Op::Add, Op::Sub, Op::Mul, Op::Div, Op::Mod => $arithmFunc(),
            default => '',
//            Op::Xor, Op::And, Op::Or => $bitwiseFunc(),
//            Op::Shl, Op::Shr => $bitwiseShiftFunc(),
//            Op::Not => $notFunc(),
        };

        return [$sql, $expected];
    }
}

class TypeConfig
{
    public readonly string $name;

    /**
     * @param array<TypeOpConfig> $ops
     * @param array<Type> $casts
     */
    public function __construct(
        public readonly Type $type,
        public readonly string $alignment,
        public readonly bool $passByValue = true,
        public readonly array $ops = [],
        public readonly array $casts = [],
        public readonly bool $crossTypesOnly = false,
    ) {
        $this->name = $type->pgName;
    }

    public function toSQL(string $extName): string
    {
        $sql = '';

        if (!$this->crossTypesOnly) {
            $passByValue = $this->passByValue ? 'PASSEDBYVALUE,' : '--PASSEDBYVALUE,';
            $byteSize = $this->type->bitSize / 8;

            $sql .= <<<EOL
CREATE FUNCTION {$this->name}_in(cstring) RETURNS {$this->name}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/$extName', '{$this->name}_in';

CREATE FUNCTION {$this->name}_out($this->name) RETURNS cstring
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/$extName', '{$this->name}_out';

CREATE FUNCTION {$this->name}_recv(internal) RETURNS {$this->name}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/$extName', '{$this->name}_recv';

CREATE FUNCTION {$this->name}_send($this->name) RETURNS bytea
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/$extName', '{$this->name}_send';

CREATE TYPE $this->name (
    INPUT = {$this->name}_in,
    OUTPUT = {$this->name}_out,
    RECEIVE = {$this->name}_recv,
    SEND = {$this->name}_send,
    INTERNALLENGTH = $byteSize,
    {$passByValue}
    ALIGNMENT = {$this->alignment}
);


EOL;

            $sql .= "\n-- Inout casts block\n\n";

            // IN-OUT casts
            foreach (['double precision', 'numeric', 'real'] as $inoutType) {
                $sql .= "CREATE CAST ($inoutType AS $this->name) WITH INOUT AS ASSIGNMENT;\n";
                $sql .= "CREATE CAST ($this->name AS $inoutType) WITH INOUT AS IMPLICIT;\n";

                $sql .= "\n";
            }
        }

        $sql .= "\n-- Casts block";

        foreach ($this->casts as $EXT_TYPE) {
            $EXT_TYPE = $EXT_TYPE->pgName;

            $sql .= "\n\n";

            $sql .= <<<EOL
CREATE FUNCTION {$this->name}_from_$EXT_TYPE($EXT_TYPE) RETURNS {$this->name}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/$extName', '{$this->name}_from_$EXT_TYPE';

CREATE FUNCTION {$this->name}_to_$EXT_TYPE($this->name) RETURNS {$EXT_TYPE}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/$extName', '{$this->name}_to_$EXT_TYPE';


EOL;

            $sql .= "CREATE CAST ($EXT_TYPE AS $this->name) WITH FUNCTION {$this->name}_from_$EXT_TYPE($EXT_TYPE) AS IMPLICIT;\n";
            $sql .= "CREATE CAST ($this->name AS $EXT_TYPE) WITH FUNCTION {$this->name}_to_$EXT_TYPE($this->name) AS IMPLICIT;\n";
        }

        $sql .= "\n-- Ops block\n\n";

        foreach ($this->ops as $op) {
            $sql .= $op->getSQLFunc($extName, $this, $this->crossTypesOnly) . "\n";
        }

        foreach ($this->ops as $op) {
            $sql .= $op->getSQLOperator($extName, $this, $this->crossTypesOnly) . "\n";
        }

        if (!$this->crossTypesOnly) {
            $sql .= "\n-- Index ops block\n\n";
            $sql .= <<<EOT
CREATE FUNCTION {$this->name}_cmp($this->name, $this->name) RETURNS int
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/$extName', '{$this->name}_cmp';

CREATE FUNCTION {$this->name}_hash($this->name) RETURNS integer
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/$extName', '{$this->name}_hash';


CREATE OPERATOR CLASS {$this->name}_ops
DEFAULT FOR TYPE $this->name USING btree FAMILY integer_ops AS
    OPERATOR 1 <,
    OPERATOR 2 <=,
    OPERATOR 3 =,
    OPERATOR 4 >=,
    OPERATOR 5 >,
    FUNCTION 1 {$this->name}_cmp($this->name, $this->name)
;

CREATE OPERATOR CLASS {$this->name}_ops
DEFAULT FOR TYPE $this->name USING hash FAMILY integer_ops AS
    OPERATOR        1       = ,
    FUNCTION        1       {$this->name}_hash($this->name);

EOT;
        }

        $sql .= "\n";

        return $sql;
    }

    /**
     * @return array{0: string, 1: string}
     */
    public function toSQLTests(): array
    {
        $sql = "-- Testing $this->name\n\n";
        $expected = "-- Testing $this->name\n";

        $sql .= "-- Ops block\n\n";
        $expected .= "-- Ops block\n";

        foreach ($this->ops as $op) {
            [$tSql, $tExpected] = $op->getSQLTest($this, $this->crossTypesOnly);
            $sql .= $tSql;
            $expected .= $tExpected;
        }

        return [$sql, $expected];
    }
}

const INT_CAST_TYPES = [INT16, INT32, INT64];

/** @var array<TypeConfig> $types */
$types = [
    new TypeConfig(
        type: UINT128,
        alignment: 'char',
        passByValue: false,
        ops: [
            new TypeOpConfig(Op::Eq, types: INT_CAST_TYPES),
            new TypeOpConfig(Op::Ne, types: INT_CAST_TYPES),
            new TypeOpConfig(Op::Gt, types: INT_CAST_TYPES),
            new TypeOpConfig(Op::Lt, types: INT_CAST_TYPES),
            new TypeOpConfig(Op::Ge, types: INT_CAST_TYPES),
            new TypeOpConfig(Op::Le, types: INT_CAST_TYPES),

            new TypeOpConfig(Op::Add, types: INT_CAST_TYPES),
            new TypeOpConfig(Op::Sub, types: INT_CAST_TYPES),
            new TypeOpConfig(Op::Mul, types: INT_CAST_TYPES),
            new TypeOpConfig(Op::Div, types: INT_CAST_TYPES),
            new TypeOpConfig(Op::Mod, types: INT_CAST_TYPES),

            new TypeOpConfig(Op::Xor, /* types: INT_CAST_TYPES */),
            new TypeOpConfig(Op::And, /* types: INT_CAST_TYPES */),
            new TypeOpConfig(Op::Or, /*types: INT_CAST_TYPES */),
            new TypeOpConfig(Op::Not, types: []),
            new TypeOpConfig(Op::Shl, /*types: [INT32]*/),
            new TypeOpConfig(Op::Shr, /*types: [INT32]*/),
        ],
        casts: array_merge(INT_CAST_TYPES, [UUID]),
    ),
    new TypeConfig(
        type: UINT64,
        alignment: 'double',
        passByValue: true,
        ops: [
            new TypeOpConfig(Op::Eq, types: INT_CAST_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Ne, types: INT_CAST_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Gt, types: INT_CAST_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Lt, types: INT_CAST_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Ge, types: INT_CAST_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Le, types: INT_CAST_TYPES, inverseTypes: true),

            new TypeOpConfig(Op::Add, types: INT_CAST_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Sub, types: INT_CAST_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Mul, types: INT_CAST_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Div, types: INT_CAST_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Mod, types: INT_CAST_TYPES, inverseTypes: true),

            new TypeOpConfig(Op::Xor, /*types: INT_CAST_TYPES, inverseTypes: true*/),
            new TypeOpConfig(Op::And, /*types: INT_CAST_TYPES, inverseTypes: true*/),
            new TypeOpConfig(Op::Or, /*types: INT_CAST_TYPES, inverseTypes: true*/),
            new TypeOpConfig(Op::Not, types: []),
            new TypeOpConfig(Op::Shl, /*types: [INT32]*/),
            new TypeOpConfig(Op::Shr, /*types: [INT32]*/),
        ],
        casts: INT_CAST_TYPES,
    ),

//    new TypeConfig(
//        type: INT128,
//        alignment: 'char',
//        passByValue: false,
//        ops: [
//            new TypeOpConfig(Op::Eq, types: INT_CAST_TYPES),
//            new TypeOpConfig(Op::Ne, types: INT_CAST_TYPES),
//            new TypeOpConfig(Op::Gt, types: INT_CAST_TYPES),
//            new TypeOpConfig(Op::Lt, types: INT_CAST_TYPES),
//            new TypeOpConfig(Op::Ge, types: INT_CAST_TYPES),
//            new TypeOpConfig(Op::Le, types: INT_CAST_TYPES),
//
//            new TypeOpConfig(Op::Add, types: INT_CAST_TYPES),
//            new TypeOpConfig(Op::Sub, types: INT_CAST_TYPES),
//            new TypeOpConfig(Op::Mul, types: INT_CAST_TYPES),
//            new TypeOpConfig(Op::Div, types: INT_CAST_TYPES),
//            new TypeOpConfig(Op::Mod, types: INT_CAST_TYPES),
//
//            new TypeOpConfig(Op::Xor, types: INT_CAST_TYPES),
//            new TypeOpConfig(Op::And, types: INT_CAST_TYPES),
//            new TypeOpConfig(Op::Or, types: INT_CAST_TYPES),
//            new TypeOpConfig(Op::Not, types: []),
//            new TypeOpConfig(Op::Shl, types: [INT32]),
//            new TypeOpConfig(Op::Shr, types: [INT32]),
//        ],
//        casts: array_merge(INT_CAST_TYPES),
//    ),
];

$buf = '';

foreach ($types as $type) {
    $buf .= "CREATE TYPE {$type->type->pgName};\n";
}

$buf .= "\n";

foreach ($types as $type) {
    $buf .= $type->toSQL($extName) . "\n";
}

$buf .= "\n\n-- Cross types ops\n";


const CROSS_TYPES = [
    'uint8' => [UINT128, /*INT128*/],
    'uint16' => [UINT64, /*INT128*/],
//    'int16' => [UINT64, UINT128],
];

/** @var array<string, string[]> $processedCastPairs */
$processedCastPairs = [];

// Cross types conversions
foreach ($types as $type) {
    /** @var array<Type> $crossTypes */
    $crossTypes = CROSS_TYPES[$type->type->pgName] ?? [];
    if ($crossTypes === []) {
        continue;
    }

    $typConfig = new TypeConfig(
        type: $type->type,
        alignment: $type->alignment,
        passByValue: $type->passByValue,
        ops: array_values(array_filter(array_map(function (TypeOpConfig $typeCfg) use ($crossTypes) {
            return match ($typeCfg->op) {
                // Bitwise doesn't scale between types
                Op::Not, Op::And, Op::Or, Op::Xor, Op::Shl, Op::Shr => null,
                default => new TypeOpConfig(
                    op: $typeCfg->op,
                    types: $crossTypes,
                )
            };
        }, $type->ops))),
        // Prevent generation duplicate casts
        casts: array_values(
            array_filter($crossTypes, static function (Type $crossType) use ($type, $processedCastPairs) {
                if (!array_key_exists($crossType->pgName, $processedCastPairs)) {
                    return true;
                }

                return !in_array($type->name, $processedCastPairs[$crossType->pgName], true);
            })
        ),
        crossTypesOnly: true,
    );

    foreach ($crossTypes as $crossType) {
        $processedCastPairs[$type->type->pgName][] = $crossType->pgName;
        $processedCastPairs[$crossType->pgName][] = $type->type->pgName;
    }

    $buf .= $typConfig->toSQL($extName) . "\n\n";
}


file_put_contents("uint128--1.0.0.sql", $buf);
echo "uint128--1.0.0.sql successfully generated\n";

@mkdir("sql");
@mkdir("expected");

foreach ($types as $type) {
    [$test, $expected] = $type->toSQLTests();

    file_put_contents("sql/test_{$type->type->pgName}.sql", $test);
    file_put_contents("expected/test_{$type->type->pgName}.out", $expected);

    echo "sql/test_{$type->type->pgName}.sql successfully generated\n";
    echo "expected/test_{$type->type->pgName}.out successfully generated\n";
}

return;
