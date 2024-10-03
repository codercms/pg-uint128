<?php

declare(strict_types=1);

$extName = 'uint128';

const INT_TYPES = [
    'int2',
    'int4',
    'int8',
];

const CROSS_TYPES = [
    'uint8' => ['uint16'],
    'uint16' => ['uint8'],
];

const SIGNED_TYPES = [
    'int2' => 'int2',
    'int4' => 'int4',
    'int8' => 'int8',
];

const UNSIGNED_TYPES = [
    'uint8' => 'uint8',
    'uint16' => 'uint16',
];

const MAX_VALUES = [
    'int2' => '32767',
    'int4' => '2147483647',
    'int8' => '9223372036854775807',
    'int16' => '170141183460469231731687303715884105727',

    'uint8' => '18446744073709551615',
    'uint16' => '340282366920938463463374607431768211455',
];

const MIN_VALUES = [
    'int2' => '(-32768)',
    'int4' => '(-2147483648)',
    'int8' => '(-9223372036854775808)',
    'int16' => '(-170141183460469231731687303715884105728)',

    'uint8' => '0',
    'uint16' => '0',
];

function genSQLCmpFunc(Op $op, string $leftType, string $rightType): string
{
    global $extName;

    $funcName = "{$leftType}_{$op->value}_{$rightType}";

    return <<<EOL
CREATE FUNCTION $funcName($leftType, $rightType) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '$funcName';
EOL;
}

function genSQLArithmeticFunc(Op $op, string $leftType, string $rightType): string
{
    global $extName;

    $funcName = "{$leftType}_{$op->value}_{$rightType}";

    return <<<EOL
CREATE FUNCTION $funcName($leftType, $rightType) RETURNS {$leftType}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '$funcName';
EOL;
}

/**
 * @return array{0: string, 1: string}
 */
function genSQLTestForCmpOp(Op $op, string $leftType, string $rightType): array
{
    if (!$op->isCMP()) {
        throw new \InvalidArgumentException("Op {$op->value} is not comparison op");
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
        $q = "SELECT $op[0]::$leftType $opSign $op[1]::$rightType;\n";

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
function genSQLTestForOverflowOp(Op $op, string $leftType, string $rightType): array
{
    if (!$op->canOverflow()) {
        throw new \InvalidArgumentException("Op {$op->value} cannot overflow");
    }

    $opSign = $op->config()->sign;

    [$leftVal, $rightVal] = match ($op) {
        Op::Add => [MAX_VALUES[$leftType], 1],
        Op::Sub => [MIN_VALUES[$leftType], 1],
        Op::Mul => [MAX_VALUES[$leftType], 2],
    };

    $sql = "SELECT {$leftVal}::{$leftType} {$opSign} {$rightVal}::{$rightType};\n";

    $expected = $sql;
    $expected .= "ERROR:  {$leftType} out of range\n";

    return [$sql, $expected];
}

/**
 * @return array{0: string, 1: string}
 */
function genSQLTestForArithmOp(Op $op, string $leftType, string $rightType): array
{
    if (!$op->isArithmetic()) {
        throw new InvalidArgumentException("Op {$op->value} is not arithmetic op");
    }

    $opSign = $op->config()->sign;

    $sql = "SELECT 120::{$leftType} {$opSign} 10::{$rightType};\n";

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
    $expected .= array_key_exists($leftType, UNSIGNED_TYPES)
        ? " {$expectedVal}\n"
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
            $q = "SELECT 1::{$leftType} {$opSign} 0::{$rightType};\n";

            $sql .= $q;
            $expected .= $q . "ERROR:  division by zero\n";
        }

        // Check mixed signed and unsigned arithmetic
        if (array_key_exists($leftType, SIGNED_TYPES) && array_key_exists($rightType, UNSIGNED_TYPES)) {
            $q = "SELECT (-120)::$leftType {$opSign} 10::{$rightType};\n";

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
            $expected .= array_key_exists($leftType, UNSIGNED_TYPES)
                ? " {$expectedVal}\n"
                : str_pad($expectedVal, strlen("----------") - 1, pad_type: STR_PAD_LEFT) . "\n";

            $expected .= "(1 row)\n\n";
        }
    }

    return [$sql, $expected];
}

class OpConfig
{
    public function __construct(
        public readonly string $cOp,
        public readonly string $sign,
        public readonly ?string $commutator = null,
        public readonly ?string $negator = null,
        public readonly ?string $restrict = null,
        public readonly ?string $join = null,
        public readonly bool $hashes = false,
        public readonly bool $merges = false,
        public readonly bool $hasLeftArg = true,
    ) {
    }

    public function toSQL(string $procedure, ?string $leftType, string $rightType): string
    {
        $sql = "CREATE OPERATOR {$this->sign} (\n";

        $parts = [];

        if ($leftType) {
            $parts[] = "LEFTARG={$leftType}";
        }

        $parts[] = "RIGHTARG={$rightType}";

        $parts[] = "PROCEDURE={$procedure}";

        if ($this->commutator) {
            $parts[] = "COMMUTATOR = {$this->commutator}";
        }

        if ($this->negator) {
            $parts[] = "NEGATOR = {$this->negator}";
        }

        if ($this->restrict) {
            $parts[] = "RESTRICT = {$this->restrict}";
        }

        if ($this->join) {
            $parts[] = "JOIN = {$this->join}";
        }

        if ($this->hashes) {
            $parts[] = "HASHES";
        }

        if ($this->merges) {
            $parts[] = "MERGES";
        }

        $sql .= implode(",\n", array_map(fn(string $str) => "    {$str}", $parts)) . "\n";
        $sql .= ");\n";

        return $sql;
    }
}

enum Op: string
{
    case Eq = 'eq';
    case Ne = 'ne';
    case Gt = 'gt';
    case Lt = 'lt';
    case Ge = 'ge';
    case Le = 'le';

    case Add = 'add';
    case Sub = 'sub';
    case Mul = 'mul';
    case Div = 'div';
    case Mod = 'mod';

    case Xor = 'xor';
    case And = 'and';
    case Or = 'or';
    case Not = 'not';

    case Shl = 'shl';
    case Shr = 'shr';

    public function isCMP(): bool
    {
        return match ($this) {
            self::Eq, self::Ne, self::Gt, self::Lt, self::Ge, self::Le => true,
            default => false,
        };
    }

    public function isArithmetic(): bool
    {
        return match ($this) {
            self::Add, self::Sub, self::Mul, self::Div, self::Mod => true,
            default => false,
        };
    }

    public function canOverflow(): bool
    {
        return match ($this) {
            self::Add, self::Sub, self::Mul => true,
            default => false,
        };
    }

    public function isDivision(): bool
    {
        return match ($this) {
            self::Div, self::Mod => true,
            default => false,
        };
    }

    public function config(): OpConfig
    {
        return match ($this) {
            self::Eq => new OpConfig(
                cOp: '==',
                sign: '=',
                commutator: '=',
                negator: '<>',
                restrict: 'eqsel',
                join: 'eqjoinsel',
                hashes: true,
                merges: true,
            ),
            self::Ne => new OpConfig(
                cOp: '!=',
                sign: '<>',
                commutator: '<>',
                negator: '=',
                restrict: 'neqsel',
                join: 'neqjoinsel',
                hashes: true,
                merges: true,
            ),
            self::Gt => new OpConfig(
                cOp: '>',
                sign: '>',
                commutator: '>',
                negator: '<=',
                restrict: 'scalargtsel',
                join: 'scalargtjoinsel',
            ),
            self::Lt => new OpConfig(
                cOp: '<',
                sign: '<',
                commutator: '<',
                negator: '>=',
                restrict: 'scalarltsel',
                join: 'scalarltjoinsel',
            ),
            self::Ge => new OpConfig(
                cOp: '>=',
                sign: '>=',
                commutator: '>=',
                negator: '<',
                restrict: 'scalargtsel',
                join: 'scalargtjoinsel',
            ),
            self::Le => new OpConfig(
                cOp: '<=',
                sign: '<=',
                commutator: '<=',
                negator: '>',
                restrict: 'scalarltsel',
                join: 'scalarltjoinsel',
            ),

            self::Add => new OpConfig(
                cOp: '+',
                sign: '+',
                commutator: '+'
            ),
            self::Sub => new OpConfig(
                cOp: '-',
                sign: '-',
                commutator: '-'
            ),
            self::Mul => new OpConfig(
                cOp: '*',
                sign: '*',
            ),
            self::Div => new OpConfig(
                cOp: '/',
                sign: '/'
            ),
            self::Mod => new OpConfig(
                cOp: '%',
                sign: '%'
            ),

            self::Xor => new OpConfig(
                cOp: '^',
                sign: '#',
                commutator: '#'
            ),
            self::And => new OpConfig(
                cOp: '&',
                sign: '&',
                commutator: '&'
            ),
            self::Or => new OpConfig(
                cOp: '|',
                sign: '|',
                commutator: '|'
            ),
            self::Not => new OpConfig(
                cOp: '~',
                sign: '~',
            ),

            self::Shl => new OpConfig(
                cOp: '<<',
                sign: '<<'
            ),
            self::Shr => new OpConfig(
                cOp: '>>',
                sign: '>>'
            ),
        };
    }
}

class TypeOpConfig
{
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
                $sql .= genSQLCmpFunc($op, $parent->name, $parent->name) . "\n\n";
            }

            foreach ($this->types as $EXT_TYPE) {
                $sql .= genSQLCmpFunc($op, $parent->name, $EXT_TYPE) . "\n\n";

                if ($this->inverseTypes) {
                    $sql .= genSQLCmpFunc($op, $EXT_TYPE, $parent->name) . "\n\n";
                }
            }

            return $sql;
        };

        $arithmFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;

            $sql = '';

            if (!$crossTypesOnly) {
                $sql .= genSQLArithmeticFunc($op, $parent->name, $parent->name) . "\n\n";
            }

            foreach ($this->types as $EXT_TYPE) {
                $sql .= genSQLArithmeticFunc($op, $parent->name, $EXT_TYPE) . "\n\n";

                if ($this->inverseTypes) {
                    $sql .= genSQLArithmeticFunc($op, $EXT_TYPE, $parent->name) . "\n\n";
                }
            }

            return $sql;
        };

        $bitwiseShiftFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;
            $sql = '';

            if (!$crossTypesOnly) {
                $sql .= <<<EOT
CREATE FUNCTION {$parent->name}_{$op->value}({$parent->name}, int4) RETURNS {$parent->name}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '{$parent->name}_{$op->value}';


EOT;
            }

            return $sql;
        };

        $notFunc = function () use ($extName, $parent): string {
            $op = $this->op;

            return <<<EOT
CREATE FUNCTION {$parent->name}_{$op->value}({$parent->name}) RETURNS {$parent->name}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '{$parent->name}_{$op->value}';

EOT;
        };

        $sql = match ($this->op) {
            Op::Eq, Op::Ne, Op::Gt, Op::Lt, Op::Ge, Op::Le => $cmpFunc(),
            Op::Add, Op::Sub, Op::Mul, Op::Div, Op::Mod => $arithmFunc(),
            Op::Xor, Op::And, Op::Or => $arithmFunc(),
            Op::Shl, Op::Shr => $bitwiseShiftFunc(),
            Op::Not => $notFunc(),
            default => '',
        };

        return $sql;
    }

    public function getSQLOperator(string $extName, TypeConfig $parent, bool $crossTypesOnly): string
    {
        $cmpFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;
            $cfg = $op->config();

            $sql = '';

            if (!$crossTypesOnly) {
                $sql .= $cfg->toSQL(
                        "{$parent->name}_{$op->value}_{$parent->name}",
                        $parent->name,
                        $parent->name
                    ) . "\n";
            }

            foreach ($this->types as $EXT_TYPE) {
                $sql .= $cfg->toSQL("{$parent->name}_{$op->value}_{$EXT_TYPE}", $parent->name, $EXT_TYPE) . "\n";

                if ($this->inverseTypes) {
                    $sql .= $cfg->toSQL("{$EXT_TYPE}_{$op->value}_{$parent->name}", $EXT_TYPE, $parent->name) . "\n";
                }
            }

            return $sql;
        };

        $arithmFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;
            $cfg = $op->config();

            $sql = '';

            if (!$crossTypesOnly) {
                $sql = $cfg->toSQL("{$parent->name}_{$op->value}_{$parent->name}", $parent->name, $parent->name) . "\n";
            }

            foreach ($this->types as $EXT_TYPE) {
                $sql .= $cfg->toSQL("{$parent->name}_{$op->value}_{$EXT_TYPE}", $parent->name, $EXT_TYPE) . "\n";

                if ($this->inverseTypes) {
                    $sql .= $cfg->toSQL("{$EXT_TYPE}_{$op->value}_{$parent->name}", $EXT_TYPE, $parent->name) . "\n";
                }
            }

            return $sql;
        };

        $bitwiseFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;
            $cfg = $op->config();

            $sql = '';

            if (!$crossTypesOnly) {
                $sql = $cfg->toSQL("{$parent->name}_{$op->value}_{$parent->name}", $parent->name, $parent->name) . "\n";
            }

            foreach ($this->types as $EXT_TYPE) {
                $sql .= $cfg->toSQL("{$parent->name}_{$op->value}_{$EXT_TYPE}", $parent->name, $EXT_TYPE) . "\n";

                if ($this->inverseTypes) {
                    $sql .= $cfg->toSQL("{$EXT_TYPE}_{$op->value}_{$parent->name}", $EXT_TYPE, $parent->name) . "\n";
                }
            }

            return $sql;
        };

        $bitwiseShiftFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;
            $cfg = $op->config();

            if (!$crossTypesOnly) {
                $sql = $cfg->toSQL("{$parent->name}_{$op->value}", $parent->name, 'int4') . "\n";
            } else {
                $sql = '';
            }

            return $sql;
        };

        $notFunc = function () use ($extName, $parent): string {
            $op = $this->op;
            $cfg = $op->config();

            return $cfg->toSQL("{$parent->name}_{$op->value}", null, $parent->name) . "\n";
        };

        $sql = match ($this->op) {
            Op::Eq, Op::Ne, Op::Gt, Op::Lt, Op::Ge, Op::Le => $cmpFunc(),
            Op::Add, Op::Sub, Op::Mul, Op::Div, Op::Mod => $arithmFunc(),
            Op::Xor, Op::And, Op::Or => $bitwiseFunc(),
            Op::Shl, Op::Shr => $bitwiseShiftFunc(),
            Op::Not => $notFunc(),
            default => '',
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
                [$cQ, $cE] = genSQLTestForCmpOp($this->op, $parent->name, $parent->name);

                $sql .= $cQ;
                $expected .= $cE;
            }

            foreach ($this->types as $EXT_TYPE) {
                [$cQ, $cE] = genSQLTestForCmpOp($this->op, $parent->name, $EXT_TYPE);

                $sql .= $cQ;
                $expected .= $cE;

                if ($this->inverseTypes) {
                    [$cQ, $cE] = genSQLTestForCmpOp($this->op, $EXT_TYPE, $parent->name);

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
                [$sq, $ex] = genSQLTestForArithmOp($this->op, $parent->name, $parent->name);
                $sql .= $sq;
                $expected .= $ex;
            }

            foreach ($this->types as $EXT_TYPE) {
                [$sq, $ex] = genSQLTestForArithmOp($this->op, $parent->name, $EXT_TYPE);
                $sql .= $sq;
                $expected .= $ex;

                if ($this->inverseTypes) {
                    [$sq, $ex] = genSQLTestForArithmOp($this->op, $EXT_TYPE, $parent->name);
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
    /**
     * @param string $name
     * @param array<TypeOpConfig> $ops
     */
    public function __construct(
        public readonly string $name,
        public readonly string $alignment,
        public readonly int $size,
        public readonly bool $passByValue = true,
        public readonly array $ops = [],
        public readonly array $casts = [],
        public readonly bool $crossTypesOnly = false,
    ) {
    }

    public function toSQL(string $extName): string
    {
        $sql = '';

        if (!$this->crossTypesOnly) {
            $sql = "CREATE TYPE {$this->name};\n\n";

            $passByValue = $this->passByValue ? 'PASSEDBYVALUE,' : '--PASSEDBYVALUE,';

            $sql .= <<<EOL
CREATE FUNCTION {$this->name}_in(cstring) RETURNS {$this->name}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '{$this->name}_in';

CREATE FUNCTION {$this->name}_out({$this->name}) RETURNS cstring
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '{$this->name}_out';

CREATE FUNCTION {$this->name}_recv(internal) RETURNS {$this->name}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '{$this->name}_recv';

CREATE FUNCTION {$this->name}_send({$this->name}) RETURNS bytea
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '{$this->name}_send';

CREATE TYPE {$this->name} (
    INPUT = {$this->name}_in,
    OUTPUT = {$this->name}_out,
    RECEIVE = {$this->name}_recv,
    SEND = {$this->name}_send,
    INTERNALLENGTH = {$this->size},
    {$passByValue}
    ALIGNMENT = {$this->alignment}
);


EOL;

            $sql .= "\n-- Inout casts block\n\n";

            // IN-OUT casts
            foreach (['double precision', 'numeric', 'real'] as $inoutType) {
                $sql .= "CREATE CAST ({$inoutType} AS {$this->name}) WITH INOUT AS ASSIGNMENT;\n";
                $sql .= "CREATE CAST ({$this->name} AS {$inoutType}) WITH INOUT AS IMPLICIT;\n";

                $sql .= "\n";
            }
        }

        $sql .= "\n-- Casts block";

        foreach ($this->casts as $EXT_TYPE) {
            $sql .= "\n\n";

            $sql .= <<<EOL
CREATE FUNCTION {$this->name}_from_{$EXT_TYPE}({$EXT_TYPE}) RETURNS {$this->name}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '{$this->name}_from_{$EXT_TYPE}';

CREATE FUNCTION {$this->name}_to_{$EXT_TYPE}({$this->name}) RETURNS {$EXT_TYPE}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '{$this->name}_to_{$EXT_TYPE}';


EOL;

            $sql .= "CREATE CAST ({$EXT_TYPE} AS {$this->name}) WITH FUNCTION {$this->name}_from_{$EXT_TYPE}({$EXT_TYPE}) AS IMPLICIT;\n";
            $sql .= "CREATE CAST ({$this->name} AS {$EXT_TYPE}) WITH FUNCTION {$this->name}_to_{$EXT_TYPE}({$this->name}) AS IMPLICIT;\n";
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
CREATE FUNCTION {$this->name}_cmp({$this->name}, {$this->name}) RETURNS int
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '{$this->name}_cmp';

CREATE FUNCTION {$this->name}_hash({$this->name}) RETURNS integer
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '{$this->name}_hash';


CREATE OPERATOR CLASS {$this->name}_ops
DEFAULT FOR TYPE {$this->name} USING btree FAMILY integer_ops AS
    OPERATOR 1 <,
    OPERATOR 2 <=,
    OPERATOR 3 =,
    OPERATOR 4 >=,
    OPERATOR 5 >,
    FUNCTION 1 {$this->name}_cmp({$this->name}, {$this->name})
;

CREATE OPERATOR CLASS {$this->name}_ops
DEFAULT FOR TYPE {$this->name} USING hash FAMILY integer_ops AS
    OPERATOR        1       = ,
    FUNCTION        1       {$this->name}_hash({$this->name});

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
        $sql = "-- Testing {$this->name}\n\n";
        $expected = "-- Testing {$this->name}\n";

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

/** @var array<TypeConfig> $types */
$types = [
    new TypeConfig(
        name: 'uint16',
        alignment: 'char',
        size: 16,
        passByValue: false,
        ops: [
            new TypeOpConfig(Op::Eq, types: INT_TYPES),
            new TypeOpConfig(Op::Ne, types: INT_TYPES),
            new TypeOpConfig(Op::Gt, types: INT_TYPES),
            new TypeOpConfig(Op::Lt, types: INT_TYPES),
            new TypeOpConfig(Op::Ge, types: INT_TYPES),
            new TypeOpConfig(Op::Le, types: INT_TYPES),

            new TypeOpConfig(Op::Add, types: INT_TYPES),
            new TypeOpConfig(Op::Sub, types: INT_TYPES),
            new TypeOpConfig(Op::Mul, types: INT_TYPES),
            new TypeOpConfig(Op::Div, types: INT_TYPES),
            new TypeOpConfig(Op::Mod, types: INT_TYPES),

            new TypeOpConfig(Op::Xor, types: INT_TYPES),
            new TypeOpConfig(Op::And, types: INT_TYPES),
            new TypeOpConfig(Op::Or, types: INT_TYPES),
            new TypeOpConfig(Op::Not, types: []),
            new TypeOpConfig(Op::Shl, types: ['int4']),
            new TypeOpConfig(Op::Shr, types: ['int4']),
        ],
        casts: array_merge(INT_TYPES, ['uuid']),
    ),
    new TypeConfig(
        name: 'uint8',
        alignment: 'double',
        size: 8,
        passByValue: true,
        ops: [
            new TypeOpConfig(Op::Eq, types: INT_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Ne, types: INT_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Gt, types: INT_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Lt, types: INT_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Ge, types: INT_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Le, types: INT_TYPES, inverseTypes: true),

            new TypeOpConfig(Op::Add, types: INT_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Sub, types: INT_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Mul, types: INT_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Div, types: INT_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Mod, types: INT_TYPES, inverseTypes: true),

            new TypeOpConfig(Op::Xor, types: INT_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::And, types: INT_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Or, types: INT_TYPES, inverseTypes: true),
            new TypeOpConfig(Op::Not, types: []),
            new TypeOpConfig(Op::Shl, types: ['int4']),
            new TypeOpConfig(Op::Shr, types: ['int4']),
        ],
        casts: INT_TYPES,
    ),
];

$buf = '';

foreach ($types as $type) {
    $buf .= $type->toSQL($extName) . "\n";
    // echo $type->toSQL($extName) . PHP_EOL;
}

$buf .= "\n\n-- Cross types ops\n";

/** @var array<string, string[]> $processedCastPairs */
$processedCastPairs = [];

// Cross types conversions
foreach ($types as $type) {
    $crossTypes = CROSS_TYPES[$type->name] ?? [];
    if ($crossTypes === []) {
        continue;
    }

    $typConfig = new TypeConfig(
        name: $type->name,
        alignment: $type->alignment,
        size: $type->size,
        passByValue: $type->passByValue,
        ops: array_values(array_filter(array_map(function (TypeOpConfig $typeCfg) use ($crossTypes) {
            if ($typeCfg->op === Op::Not) {
                return null;
            }

            return new TypeOpConfig(
                op: $typeCfg->op,
                types: $crossTypes,
            );
        }, $type->ops))),
        // Prevent generation duplicate casts
        casts: array_values(
            array_filter($crossTypes, static function (string $crossType) use ($type, $processedCastPairs) {
                if (!array_key_exists($crossType, $processedCastPairs)) {
                    return true;
                }

                return !in_array($type->name, $processedCastPairs[$crossType], true);
            })
        ),
        crossTypesOnly: true,
    );

    foreach ($crossTypes as $crossType) {
        $processedCastPairs[$type->name][] = $crossType;
        $processedCastPairs[$crossType][] = $type->name;
    }

    $buf .= $typConfig->toSQL($extName) . "\n\n";
}

file_put_contents("uint128--1.0.0.sql", $buf);

@mkdir("sql");
@mkdir("expected");

foreach ($types as $type) {
    [$test, $expected] = $type->toSQLTests();

    file_put_contents("sql/test_{$type->name}.sql", $test);
    file_put_contents("expected/test_{$type->name}.out", $expected);
}

return;
