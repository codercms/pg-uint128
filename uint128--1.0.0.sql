-- uint128--1.0.0.sql

CREATE TYPE uint16;

CREATE FUNCTION uint16_in(cstring) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_in';

CREATE FUNCTION uint16_out(uint16) RETURNS cstring
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_out';

CREATE FUNCTION uint16_recv(internal) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_recv';

CREATE FUNCTION uint16_send(uint16) RETURNS bytea
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_send';

CREATE TYPE uint16 (
    INPUT = uint16_in,
    OUTPUT = uint16_out,
    RECEIVE = uint16_recv,
    SEND = uint16_send,
    INTERNALLENGTH = 16,
    --PASSEDBYVALUE,  -- requires 64-bit
    ALIGNMENT = char
);

CREATE CAST (double precision AS uint16) WITH INOUT AS ASSIGNMENT;
CREATE CAST (numeric AS uint16) WITH INOUT AS ASSIGNMENT;
CREATE CAST (real AS uint16) WITH INOUT AS ASSIGNMENT;

CREATE CAST (uint16 AS double precision) WITH INOUT AS IMPLICIT;
CREATE CAST (uint16 AS numeric) WITH INOUT AS IMPLICIT;
CREATE CAST (uint16 AS real) WITH INOUT AS IMPLICIT;

-- Ops

CREATE FUNCTION uint16_eq(uint16, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_eq';

CREATE FUNCTION uint16_ne(uint16, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ne';

CREATE FUNCTION uint16_gt(uint16, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_gt';

CREATE FUNCTION uint16_ge(uint16, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ge';

CREATE FUNCTION uint16_lt(uint16, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_lt';

CREATE FUNCTION uint16_le(uint16, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_le';

CREATE FUNCTION uint16_cmp(uint16, uint16) RETURNS int
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_cmp';

CREATE FUNCTION uint16_hash(uint16) RETURNS integer
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_hash';

CREATE FUNCTION uint16_add(uint16, uint16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_add';

CREATE FUNCTION uint16_sub(uint16, uint16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_sub';

CREATE FUNCTION uint16_mul(uint16, uint16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mul';

CREATE FUNCTION uint16_div(uint16, uint16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_div';

CREATE FUNCTION uint16_mod(uint16, uint16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mod';

CREATE FUNCTION uint16_xor(uint16, uint16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_xor';

CREATE FUNCTION uint16_and(uint16, uint16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_and';

CREATE FUNCTION uint16_or(uint16, uint16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_or';

CREATE FUNCTION uint16_not(uint16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_not';

CREATE FUNCTION uint16_shl(uint16, int4) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_shl';

CREATE FUNCTION uint16_shr(uint16, int4) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_shr';

CREATE OPERATOR = (
  LEFTARG = uint16,
  RIGHTARG = uint16,
  PROCEDURE = uint16_eq,
  COMMUTATOR = '=',
  NEGATOR = '<>',
  RESTRICT = eqsel,
  JOIN = eqjoinsel,
  HASHES, MERGES
);

CREATE OPERATOR <> (
  LEFTARG = uint16,
  RIGHTARG = uint16,
  PROCEDURE = uint16_ne,
  COMMUTATOR = '<>',
  NEGATOR = '=',
  RESTRICT = neqsel,
  JOIN = neqjoinsel
);

CREATE OPERATOR < (
  LEFTARG = uint16,
  RIGHTARG = uint16,
  PROCEDURE = uint16_lt,
  COMMUTATOR = > ,
  NEGATOR = >= ,
  RESTRICT = scalarltsel,
  JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
  LEFTARG = uint16,
  RIGHTARG = uint16,
  PROCEDURE = uint16_le,
  COMMUTATOR = >= ,
  NEGATOR = > ,
  RESTRICT = scalarltsel,
  JOIN = scalarltjoinsel
);

CREATE OPERATOR > (
  LEFTARG = uint16,
  RIGHTARG = uint16,
  PROCEDURE = uint16_gt,
  COMMUTATOR = < ,
  NEGATOR = <= ,
  RESTRICT = scalargtsel,
  JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
  LEFTARG = uint16,
  RIGHTARG = uint16,
  PROCEDURE = uint16_ge,
  COMMUTATOR = <= ,
  NEGATOR = < ,
  RESTRICT = scalargtsel,
  JOIN = scalargtjoinsel
);

CREATE OPERATOR + (
    LEFTARG = uint16,
    RIGHTARG = uint16,
    PROCEDURE = uint16_add,
    COMMUTATOR = '+'
);

CREATE OPERATOR - (
    LEFTARG = uint16,
    RIGHTARG = uint16,
    PROCEDURE = uint16_sub
);

CREATE OPERATOR * (
    LEFTARG = uint16,
    RIGHTARG = uint16,
    PROCEDURE = uint16_mul,
    COMMUTATOR = '*'
);

CREATE OPERATOR / (
    LEFTARG = uint16,
    RIGHTARG = uint16,
    PROCEDURE = uint16_div
);

CREATE OPERATOR % (
    LEFTARG = uint16,
    RIGHTARG = uint16,
    PROCEDURE = uint16_mod
);

CREATE OPERATOR # (
    LEFTARG = uint16,
    RIGHTARG = uint16,
    PROCEDURE = uint16_xor,
    COMMUTATOR = '#'
);

CREATE OPERATOR & (
    LEFTARG = uint16,
    RIGHTARG = uint16,
    PROCEDURE = uint16_and,
    COMMUTATOR = '&'
);

CREATE OPERATOR | (
    LEFTARG = uint16,
    RIGHTARG = uint16,
    PROCEDURE = uint16_or,
    COMMUTATOR = '|'
);

CREATE OPERATOR ~ (
    RIGHTARG = uint16,
    PROCEDURE = uint16_not
);

CREATE OPERATOR << (
    LEFTARG = uint16,
    RIGHTARG = int4,
    PROCEDURE = uint16_shl
);

CREATE OPERATOR >> (
    LEFTARG = uint16,
    RIGHTARG = int4,
    PROCEDURE = uint16_shr
);

CREATE OPERATOR CLASS uint16_ops
DEFAULT FOR TYPE uint16 USING btree AS
    OPERATOR 1 <,
    OPERATOR 2 <=,
    OPERATOR 3 =,
    OPERATOR 4 >=,
    OPERATOR 5 >,
    FUNCTION 1 uint16_cmp(uint16, uint16)
;

CREATE OPERATOR CLASS uint16_hash_ops
DEFAULT FOR TYPE uint16 USING hash AS
    OPERATOR        1       = ,
    FUNCTION        1       uint16_hash(uint16);
