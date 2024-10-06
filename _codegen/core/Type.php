<?php

declare(strict_types=1);

class Type
{
    public function __construct(
        public readonly string $name,
        public readonly bool $isUnsigned,
        public readonly int $bitSize,

        public readonly string $minValue,
        public readonly string $maxValue,

        public readonly string $pgName,

        public readonly string $pgGetArgMacro,
        public readonly string $pgReturnMacro,

        public readonly int $strLen,

        public readonly string $fromDatum,
        public readonly string $toDatum,
    ) {
    }

    public function getMaxConstC(): string
    {
        return strtoupper($this->name) . "_MAX";
    }

    public function getMinConstC(): string
    {
        return strtoupper($this->name) . "_MIN";
    }

    public function getStrBufLenConstC(): string
    {
        return strtoupper($this->name) . "_STRBUFLEN";
    }

    public function getPgSqlMinVal(): string
    {
        if ($this->isUnsigned) {
            return $this->minValue;
        }

        // Escape min value because of PostgreSQL operator orders
        return "($this->minValue)";
    }

    public function getRangePgTypeName(): string
    {
        return "{$this->pgName}range";
    }
}


const UINT16 = new Type(
    name: 'uint16',
    isUnsigned: true,
    bitSize: 16,
    minValue: '0',
    maxValue: '65535',
    pgName: 'uint2',
    pgGetArgMacro: 'PG_GETARG_UINT16',
    pgReturnMacro: 'PG_RETURN_UINT16',
    strLen: 5,
    fromDatum: 'DatumGetUInt16',
    toDatum: 'UInt16GetDatum',
);
const UINT32 = new Type(
    name: 'uint32',
    isUnsigned: true,
    bitSize: 32,
    minValue: '0',
    maxValue: '4294967295',
    pgName: 'uint4',
    pgGetArgMacro: 'PG_GETARG_UINT32',
    pgReturnMacro: 'PG_RETURN_UINT32',
    strLen: 10,
    fromDatum: 'DatumGetUInt32',
    toDatum: 'UInt32GetDatum',
);
const UINT64 = new Type(
    name: 'uint64',
    isUnsigned: true,
    bitSize: 64,
    minValue: '0',
    maxValue: '18446744073709551615',
    pgName: 'uint8',
    pgGetArgMacro: 'PG_GETARG_UINT64',
    pgReturnMacro: 'PG_RETURN_UINT64',
    strLen: 20,
    fromDatum: 'DatumGetUInt64',
    toDatum: 'UInt64GetDatum',
);
const UINT128 = new Type(
    name: 'uint128',
    isUnsigned: true,
    bitSize: 128,
    minValue: '0',
    maxValue: '340282366920938463463374607431768211455',
    pgName: 'uint16',
    pgGetArgMacro: 'PG_GETARG_UINT128',
    pgReturnMacro: 'PG_RETURN_UINT128',
    strLen: 39,
    fromDatum: 'DatumGetUInt128',
    toDatum: 'UInt128GetDatum',
);

const UINT_TYPES = [
    UINT16,
    UINT32,
    UINT64,
    UINT128,
];

const INT16 = new Type(
    name: 'int16',
    isUnsigned: false,
    bitSize: 16,
    minValue: '-32768',
    maxValue: '32767',
    pgName: 'int2',
    pgGetArgMacro: 'PG_GETARG_INT16',
    pgReturnMacro: 'PG_RETURN_INT16',
    strLen: 6,
    fromDatum: 'DatumGetInt16',
    toDatum: 'Int16GetDatum',
);
const INT32 = new Type(
    name: 'int32',
    isUnsigned: false,
    bitSize: 32,
    minValue: '-2147483648',
    maxValue: '2147483647',
    pgName: 'int4',
    pgGetArgMacro: 'PG_GETARG_INT32',
    pgReturnMacro: 'PG_RETURN_INT32',
    strLen: 11,
    fromDatum: 'DatumGetInt32',
    toDatum: 'Int32GetDatum',
);
const INT64 = new Type(
    name: 'int64',
    isUnsigned: false,
    bitSize: 64,
    minValue: '-9223372036854775808',
    maxValue: '9223372036854775807',
    pgName: 'int8',
    pgGetArgMacro: 'PG_GETARG_INT64',
    pgReturnMacro: 'PG_RETURN_INT64',
    strLen: 20,
    fromDatum: 'DatumGetInt64',
    toDatum: 'Int64GetDatum',
);
const INT128 = new Type(
    name: 'int128',
    isUnsigned: false,
    bitSize: 128,
    minValue: '-170141183460469231731687303715884105728',
    maxValue: '170141183460469231731687303715884105727',
    pgName: 'int16',
    pgGetArgMacro: 'PG_GETARG_INT128',
    pgReturnMacro: 'PG_RETURN_INT128',
    strLen: 40,
    fromDatum: 'DatumGetInt128',
    toDatum: 'Int128GetDatum',
);


const INT_TYPES = [
    INT16,
    INT32,
    INT64,
    INT128,
];


const UUID = new Type(
    name: 'pg_uuid_t',
    isUnsigned: true,
    bitSize: 128,
    minValue: '00000000-0000-0000-0000-000000000000',
    maxValue: 'FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF',
    pgName: 'uuid',
    pgGetArgMacro: 'PG_GETARG_UUID',
    pgReturnMacro: 'PG_RETURN_UUID',
    strLen: 36,
    fromDatum: '',
    toDatum: '',
);
