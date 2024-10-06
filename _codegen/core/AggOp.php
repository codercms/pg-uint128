<?php

declare(strict_types=1);

enum AggOp: string
{
    case Sum = 'sum';
    case Avg = 'avg';

    case Min = 'min';
    case Max = 'max';

    function getFuncNameSuffix(): string
    {
        return match ($this) {
            self::Sum, self::Avg => '_avg_accum',
            self::Min => '_smaller',
            self::Max => '_larger',
        };
    }

    public function getSql(string $extName, Type $type, bool $defineFunc): string
    {
        $sql = "";

        $funcName = "{$type->pgName}{$this->getFuncNameSuffix()}";

        if ($defineFunc) {
            if ($this === self::Sum || $this === self::Avg) {
                $sql .= <<<SQL
-- Transition function for accumulating {$type->pgName}
CREATE FUNCTION $funcName(internal, $type->pgName)
RETURNS internal
AS '\$libdir/$extName', '$funcName'
LANGUAGE C IMMUTABLE PARALLEL SAFE;

-- Inverse transition function for accumulating {$type->pgName}
CREATE FUNCTION {$funcName}_inv(internal, {$type->pgName})
RETURNS internal
AS '\$libdir/$extName', '{$funcName}_inv'
LANGUAGE C IMMUTABLE PARALLEL SAFE;
SQL;
            } else if ($this === self::Min || $this === self::Max) {
                $sql .= <<<SQL
CREATE FUNCTION $funcName($type->pgName, $type->pgName)
RETURNS $type->pgName
AS '\$libdir/$extName', '$funcName'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;
SQL;

            } else {
                throw new InvalidArgumentException("Not supported aggregate op {$this->value}");
            }

            $sql .= "\n\n";
        }

        if ($this === self::Sum || $this === self::Avg) {
            $finalFunc = $this === self::Sum ? 'numeric_sum' : 'numeric_avg';

            $sql .= <<<SQL
CREATE AGGREGATE $this->value($type->pgName) (
    -- Transition function
    SFUNC = $funcName,
    -- Internal state type
    STYPE = internal,
    -- Internal state size
    SSPACE = 128,
    -- Final function to return the sum
    FINALFUNC = $finalFunc,
    -- Combine function for parallel aggregation
    COMBINEFUNC = numeric_avg_combine,
    -- Moving transition function
    MSFUNC = $funcName,
    -- Moving state type (same as STYPE)
    MSTYPE = internal,
    -- Moving inverse transition function
    MINVFUNC = {$funcName}_inv,
    -- Moving final function for windows
    MFINALFUNC = $finalFunc,
    -- Serialize function
    SERIALFUNC = numeric_avg_serialize,
    -- Deserialize function
    DESERIALFUNC = numeric_avg_deserialize,
    -- Aggregate is parallel safe
    PARALLEL = SAFE
);
SQL;

        } else if ($this === self::Min || $this === self::Max) {
            $sortOp = $this === self::Min ? '<' : '>';

            $sql .= <<<SQL
CREATE AGGREGATE $this->value($type->pgName) (
    -- Transition function
    SFUNC = $funcName,         
	STYPE = $type->pgName,
	COMBINEFUNC = $funcName,
    SORTOP = $sortOp,
    PARALLEL = SAFE
);
SQL;
        } else {
            throw new InvalidArgumentException("Not supported aggregate op {$this->value}");
        }

        $sql .= "\n";

        return $sql;
    }

    /**
     * @return array{0: string, 1: string}
     */
    public function getSqlTest(Type $type): array
    {
        $test = "";
        $expected = "";

        $q = "SELECT $this->value(s::$type->pgName) FROM generate_series(1, 10000) s;\n";

        $test .= $q;
        $expected .= $q;

        $expectedVal = match ($this) {
            self::Sum => '50005000',
            self::Avg => '5000.5000000000000000',
            self::Min => '1',
            self::Max => '10000',
        };

        $expected .= genSqlExpectedPaddedValue($this->value, $expectedVal, $this === self::Sum || $this === self::Avg);

        return [$test, $expected];
    }
}
