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
    ) {
    }

    public function getSQLFunc(string $extName, TypeConfig $parent, bool $crossTypesOnly): string
    {
        $cmpFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;

            if (!$crossTypesOnly) {
                $sql = <<<EOT
CREATE FUNCTION {$parent->name}_{$op->value}({$parent->name}, {$parent->name}) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '{$parent->name}_{$op->value}';


EOT;
            } else {
                $sql = '';
            }

            foreach ($this->types as $EXT_TYPE) {
                $sql .= <<<EOT
CREATE FUNCTION {$parent->name}_{$op->value}_{$EXT_TYPE}({$parent->name}, {$EXT_TYPE}) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '{$parent->name}_{$op->value}_{$EXT_TYPE}';


EOT;
            }

            return $sql;
        };

        $arithmFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;

            if (!$crossTypesOnly) {
                $sql = <<<EOT
CREATE FUNCTION {$parent->name}_{$op->value}({$parent->name}, {$parent->name}) RETURNS {$parent->name}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '{$parent->name}_{$op->value}';


EOT;
            } else {
                $sql = '';
            }

            foreach ($this->types as $EXT_TYPE) {
                $sql .= <<<EOT
CREATE FUNCTION {$parent->name}_{$op->value}_{$EXT_TYPE}({$parent->name}, {$EXT_TYPE}) RETURNS {$parent->name}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '{$parent->name}_{$op->value}_{$EXT_TYPE}';


EOT;
            }

            return $sql;
        };

        $bitwiseFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;

            if (!$crossTypesOnly) {
                $sql = <<<EOT
CREATE FUNCTION {$parent->name}_{$op->value}({$parent->name}, {$parent->name}) RETURNS {$parent->name}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '{$parent->name}_{$op->value}';


EOT;
            } else {
                $sql = '';
            }

            foreach ($this->types as $EXT_TYPE) {
                $sql .= <<<EOT
CREATE FUNCTION {$parent->name}_{$op->value}_{$EXT_TYPE}({$parent->name}, {$EXT_TYPE}) RETURNS {$parent->name}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '{$parent->name}_{$op->value}_{$EXT_TYPE}';


EOT;
            }

            return $sql;
        };

        $bitwiseShiftFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;

            if (!$crossTypesOnly) {
                $sql = <<<EOT
CREATE FUNCTION {$parent->name}_{$op->value}({$parent->name}, int4) RETURNS {$parent->name}
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '\$libdir/{$extName}', '{$parent->name}_{$op->value}';


EOT;
            } else {
                $sql = '';
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
            Op::Xor, Op::And, Op::Or => $bitwiseFunc(),
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

            if (!$crossTypesOnly) {
                $sql = $cfg->toSQL("{$parent->name}_{$op->value}", $parent->name, $parent->name) . "\n";
            } else {
                $sql = '';
            }

            foreach ($this->types as $EXT_TYPE) {
                $sql .= $cfg->toSQL("{$parent->name}_{$op->value}_{$EXT_TYPE}", $parent->name, $EXT_TYPE) . "\n";
            }

            return $sql;
        };

        $arithmFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;
            $cfg = $op->config();

            if (!$crossTypesOnly) {
                $sql = $cfg->toSQL("{$parent->name}_{$op->value}", $parent->name, $parent->name) . "\n";
            } else {
                $sql = '';
            }

            foreach ($this->types as $EXT_TYPE) {
                $sql .= $cfg->toSQL("{$parent->name}_{$op->value}_{$EXT_TYPE}", $parent->name, $EXT_TYPE) . "\n";
            }

            return $sql;
        };

        $bitwiseFunc = function () use ($extName, $parent, $crossTypesOnly): string {
            $op = $this->op;
            $cfg = $op->config();

            if (!$crossTypesOnly) {
                $sql = $cfg->toSQL("{$parent->name}_{$op->value}", $parent->name, $parent->name) . "\n";
            } else {
                $sql = '';
            }

            foreach ($this->types as $EXT_TYPE) {
                $sql .= $cfg->toSQL("{$parent->name}_{$op->value}_{$EXT_TYPE}", $parent->name, $EXT_TYPE) . "\n";
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

return;
