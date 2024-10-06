CREATE TYPE uint16;
CREATE TYPE uint8;
CREATE TYPE uint4;
CREATE TYPE uint2;
CREATE TYPE int16;

-- Type uint16 block

CREATE FUNCTION uint16_in(cstring) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_in';

CREATE FUNCTION uint16_out(uint16) RETURNS cstring
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_out';

CREATE FUNCTION uint16_recv(internal) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_recv';

CREATE FUNCTION uint16_send(uint16) RETURNS bytea
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_send';

CREATE TYPE uint16 (
    INPUT = uint16_in,
    OUTPUT = uint16_out,
    RECEIVE = uint16_recv,
    SEND = uint16_send,
    INTERNALLENGTH = 16,
    --PASSEDBYVALUE,
    ALIGNMENT = char
);


-- Inout casts block

CREATE CAST (double precision AS uint16) WITH INOUT AS ASSIGNMENT;
CREATE CAST (uint16 AS double precision) WITH INOUT AS IMPLICIT;

CREATE CAST (numeric AS uint16) WITH INOUT AS ASSIGNMENT;
CREATE CAST (uint16 AS numeric) WITH INOUT AS IMPLICIT;

CREATE CAST (real AS uint16) WITH INOUT AS ASSIGNMENT;
CREATE CAST (uint16 AS real) WITH INOUT AS IMPLICIT;


-- Casts block

CREATE FUNCTION uint16_from_int2(int2) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_from_int2';

CREATE FUNCTION uint16_to_int2(uint16) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_to_int2';

CREATE CAST (int2 AS uint16) WITH FUNCTION uint16_from_int2(int2) AS IMPLICIT;
CREATE CAST (uint16 AS int2) WITH FUNCTION uint16_to_int2(uint16) AS IMPLICIT;


CREATE FUNCTION uint16_from_int4(int4) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_from_int4';

CREATE FUNCTION uint16_to_int4(uint16) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_to_int4';

CREATE CAST (int4 AS uint16) WITH FUNCTION uint16_from_int4(int4) AS IMPLICIT;
CREATE CAST (uint16 AS int4) WITH FUNCTION uint16_to_int4(uint16) AS IMPLICIT;


CREATE FUNCTION uint16_from_int8(int8) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_from_int8';

CREATE FUNCTION uint16_to_int8(uint16) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_to_int8';

CREATE CAST (int8 AS uint16) WITH FUNCTION uint16_from_int8(int8) AS IMPLICIT;
CREATE CAST (uint16 AS int8) WITH FUNCTION uint16_to_int8(uint16) AS IMPLICIT;


CREATE FUNCTION uint16_from_uuid(uuid) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_from_uuid';

CREATE FUNCTION uint16_to_uuid(uint16) RETURNS uuid
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_to_uuid';

CREATE CAST (uuid AS uint16) WITH FUNCTION uint16_from_uuid(uuid) AS IMPLICIT;
CREATE CAST (uint16 AS uuid) WITH FUNCTION uint16_to_uuid(uint16) AS IMPLICIT;

-- Ops block

CREATE FUNCTION uint16_eq_uint16(uint16, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_eq_uint16';

CREATE FUNCTION uint16_eq_int2(uint16, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_eq_int2';

CREATE FUNCTION int2_eq_uint16(int2, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_eq_uint16';

CREATE FUNCTION uint16_eq_int4(uint16, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_eq_int4';

CREATE FUNCTION int4_eq_uint16(int4, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_eq_uint16';

CREATE FUNCTION uint16_eq_int8(uint16, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_eq_int8';

CREATE FUNCTION int8_eq_uint16(int8, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_eq_uint16';


CREATE FUNCTION uint16_ne_uint16(uint16, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ne_uint16';

CREATE FUNCTION uint16_ne_int2(uint16, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ne_int2';

CREATE FUNCTION int2_ne_uint16(int2, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_ne_uint16';

CREATE FUNCTION uint16_ne_int4(uint16, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ne_int4';

CREATE FUNCTION int4_ne_uint16(int4, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_ne_uint16';

CREATE FUNCTION uint16_ne_int8(uint16, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ne_int8';

CREATE FUNCTION int8_ne_uint16(int8, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_ne_uint16';


CREATE FUNCTION uint16_gt_uint16(uint16, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_gt_uint16';

CREATE FUNCTION uint16_gt_int2(uint16, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_gt_int2';

CREATE FUNCTION int2_gt_uint16(int2, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_gt_uint16';

CREATE FUNCTION uint16_gt_int4(uint16, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_gt_int4';

CREATE FUNCTION int4_gt_uint16(int4, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_gt_uint16';

CREATE FUNCTION uint16_gt_int8(uint16, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_gt_int8';

CREATE FUNCTION int8_gt_uint16(int8, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_gt_uint16';


CREATE FUNCTION uint16_lt_uint16(uint16, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_lt_uint16';

CREATE FUNCTION uint16_lt_int2(uint16, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_lt_int2';

CREATE FUNCTION int2_lt_uint16(int2, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_lt_uint16';

CREATE FUNCTION uint16_lt_int4(uint16, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_lt_int4';

CREATE FUNCTION int4_lt_uint16(int4, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_lt_uint16';

CREATE FUNCTION uint16_lt_int8(uint16, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_lt_int8';

CREATE FUNCTION int8_lt_uint16(int8, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_lt_uint16';


CREATE FUNCTION uint16_ge_uint16(uint16, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ge_uint16';

CREATE FUNCTION uint16_ge_int2(uint16, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ge_int2';

CREATE FUNCTION int2_ge_uint16(int2, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_ge_uint16';

CREATE FUNCTION uint16_ge_int4(uint16, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ge_int4';

CREATE FUNCTION int4_ge_uint16(int4, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_ge_uint16';

CREATE FUNCTION uint16_ge_int8(uint16, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ge_int8';

CREATE FUNCTION int8_ge_uint16(int8, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_ge_uint16';


CREATE FUNCTION uint16_le_uint16(uint16, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_le_uint16';

CREATE FUNCTION uint16_le_int2(uint16, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_le_int2';

CREATE FUNCTION int2_le_uint16(int2, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_le_uint16';

CREATE FUNCTION uint16_le_int4(uint16, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_le_int4';

CREATE FUNCTION int4_le_uint16(int4, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_le_uint16';

CREATE FUNCTION uint16_le_int8(uint16, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_le_int8';

CREATE FUNCTION int8_le_uint16(int8, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_le_uint16';


CREATE FUNCTION uint16_add_uint16(uint16, uint16) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_add_uint16';

CREATE FUNCTION uint16_add_int2(uint16, int2) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_add_int2';

CREATE FUNCTION int2_add_uint16(int2, uint16) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_add_uint16';

CREATE FUNCTION uint16_add_int4(uint16, int4) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_add_int4';

CREATE FUNCTION int4_add_uint16(int4, uint16) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_add_uint16';

CREATE FUNCTION uint16_add_int8(uint16, int8) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_add_int8';

CREATE FUNCTION int8_add_uint16(int8, uint16) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_add_uint16';


CREATE FUNCTION uint16_sub_uint16(uint16, uint16) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_sub_uint16';

CREATE FUNCTION uint16_sub_int2(uint16, int2) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_sub_int2';

CREATE FUNCTION int2_sub_uint16(int2, uint16) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_sub_uint16';

CREATE FUNCTION uint16_sub_int4(uint16, int4) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_sub_int4';

CREATE FUNCTION int4_sub_uint16(int4, uint16) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_sub_uint16';

CREATE FUNCTION uint16_sub_int8(uint16, int8) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_sub_int8';

CREATE FUNCTION int8_sub_uint16(int8, uint16) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_sub_uint16';


CREATE FUNCTION uint16_mul_uint16(uint16, uint16) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mul_uint16';

CREATE FUNCTION uint16_mul_int2(uint16, int2) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mul_int2';

CREATE FUNCTION int2_mul_uint16(int2, uint16) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_mul_uint16';

CREATE FUNCTION uint16_mul_int4(uint16, int4) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mul_int4';

CREATE FUNCTION int4_mul_uint16(int4, uint16) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_mul_uint16';

CREATE FUNCTION uint16_mul_int8(uint16, int8) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mul_int8';

CREATE FUNCTION int8_mul_uint16(int8, uint16) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_mul_uint16';


CREATE FUNCTION uint16_div_uint16(uint16, uint16) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_div_uint16';

CREATE FUNCTION uint16_div_int2(uint16, int2) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_div_int2';

CREATE FUNCTION int2_div_uint16(int2, uint16) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_div_uint16';

CREATE FUNCTION uint16_div_int4(uint16, int4) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_div_int4';

CREATE FUNCTION int4_div_uint16(int4, uint16) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_div_uint16';

CREATE FUNCTION uint16_div_int8(uint16, int8) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_div_int8';

CREATE FUNCTION int8_div_uint16(int8, uint16) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_div_uint16';


CREATE FUNCTION uint16_mod_uint16(uint16, uint16) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mod_uint16';

CREATE FUNCTION uint16_mod_int2(uint16, int2) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mod_int2';

CREATE FUNCTION int2_mod_uint16(int2, uint16) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_mod_uint16';

CREATE FUNCTION uint16_mod_int4(uint16, int4) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mod_int4';

CREATE FUNCTION int4_mod_uint16(int4, uint16) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_mod_uint16';

CREATE FUNCTION uint16_mod_int8(uint16, int8) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mod_int8';

CREATE FUNCTION int8_mod_uint16(int8, uint16) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_mod_uint16';


CREATE FUNCTION uint16_xor(uint16, uint16) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_xor';


CREATE FUNCTION uint16_and(uint16, uint16) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_and';


CREATE FUNCTION uint16_or(uint16, uint16) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_or';


CREATE FUNCTION uint16_not(uint16) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_not';

CREATE FUNCTION uint16_shl(uint16, int4) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_shl';


CREATE FUNCTION uint16_shr(uint16, int4) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_shr';


CREATE OPERATOR = (
    LEFTARG=uint16,
    RIGHTARG=uint16,
    PROCEDURE=uint16_eq_uint16,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint16,
    RIGHTARG=int2,
    PROCEDURE=uint16_eq_int2,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int2,
    RIGHTARG=uint16,
    PROCEDURE=int2_eq_uint16,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint16,
    RIGHTARG=int4,
    PROCEDURE=uint16_eq_int4,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int4,
    RIGHTARG=uint16,
    PROCEDURE=int4_eq_uint16,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint16,
    RIGHTARG=int8,
    PROCEDURE=uint16_eq_int8,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int8,
    RIGHTARG=uint16,
    PROCEDURE=int8_eq_uint16,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR <> (
    LEFTARG=uint16,
    RIGHTARG=uint16,
    PROCEDURE=uint16_ne_uint16,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint16,
    RIGHTARG=int2,
    PROCEDURE=uint16_ne_int2,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int2,
    RIGHTARG=uint16,
    PROCEDURE=int2_ne_uint16,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint16,
    RIGHTARG=int4,
    PROCEDURE=uint16_ne_int4,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int4,
    RIGHTARG=uint16,
    PROCEDURE=int4_ne_uint16,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint16,
    RIGHTARG=int8,
    PROCEDURE=uint16_ne_int8,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int8,
    RIGHTARG=uint16,
    PROCEDURE=int8_ne_uint16,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR > (
    LEFTARG=uint16,
    RIGHTARG=uint16,
    PROCEDURE=uint16_gt_uint16,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint16,
    RIGHTARG=int2,
    PROCEDURE=uint16_gt_int2,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int2,
    RIGHTARG=uint16,
    PROCEDURE=int2_gt_uint16,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint16,
    RIGHTARG=int4,
    PROCEDURE=uint16_gt_int4,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int4,
    RIGHTARG=uint16,
    PROCEDURE=int4_gt_uint16,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint16,
    RIGHTARG=int8,
    PROCEDURE=uint16_gt_int8,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int8,
    RIGHTARG=uint16,
    PROCEDURE=int8_gt_uint16,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR < (
    LEFTARG=uint16,
    RIGHTARG=uint16,
    PROCEDURE=uint16_lt_uint16,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint16,
    RIGHTARG=int2,
    PROCEDURE=uint16_lt_int2,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int2,
    RIGHTARG=uint16,
    PROCEDURE=int2_lt_uint16,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint16,
    RIGHTARG=int4,
    PROCEDURE=uint16_lt_int4,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int4,
    RIGHTARG=uint16,
    PROCEDURE=int4_lt_uint16,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint16,
    RIGHTARG=int8,
    PROCEDURE=uint16_lt_int8,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int8,
    RIGHTARG=uint16,
    PROCEDURE=int8_lt_uint16,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR >= (
    LEFTARG=uint16,
    RIGHTARG=uint16,
    PROCEDURE=uint16_ge_uint16,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint16,
    RIGHTARG=int2,
    PROCEDURE=uint16_ge_int2,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int2,
    RIGHTARG=uint16,
    PROCEDURE=int2_ge_uint16,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint16,
    RIGHTARG=int4,
    PROCEDURE=uint16_ge_int4,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int4,
    RIGHTARG=uint16,
    PROCEDURE=int4_ge_uint16,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint16,
    RIGHTARG=int8,
    PROCEDURE=uint16_ge_int8,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int8,
    RIGHTARG=uint16,
    PROCEDURE=int8_ge_uint16,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR <= (
    LEFTARG=uint16,
    RIGHTARG=uint16,
    PROCEDURE=uint16_le_uint16,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint16,
    RIGHTARG=int2,
    PROCEDURE=uint16_le_int2,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int2,
    RIGHTARG=uint16,
    PROCEDURE=int2_le_uint16,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint16,
    RIGHTARG=int4,
    PROCEDURE=uint16_le_int4,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int4,
    RIGHTARG=uint16,
    PROCEDURE=int4_le_uint16,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint16,
    RIGHTARG=int8,
    PROCEDURE=uint16_le_int8,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int8,
    RIGHTARG=uint16,
    PROCEDURE=int8_le_uint16,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR + (
    LEFTARG=uint16,
    RIGHTARG=uint16,
    PROCEDURE=uint16_add_uint16,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint16,
    RIGHTARG=int2,
    PROCEDURE=uint16_add_int2,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int2,
    RIGHTARG=uint16,
    PROCEDURE=int2_add_uint16,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint16,
    RIGHTARG=int4,
    PROCEDURE=uint16_add_int4,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int4,
    RIGHTARG=uint16,
    PROCEDURE=int4_add_uint16,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint16,
    RIGHTARG=int8,
    PROCEDURE=uint16_add_int8,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int8,
    RIGHTARG=uint16,
    PROCEDURE=int8_add_uint16,
    COMMUTATOR = +
);


CREATE OPERATOR - (
    LEFTARG=uint16,
    RIGHTARG=uint16,
    PROCEDURE=uint16_sub_uint16,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint16,
    RIGHTARG=int2,
    PROCEDURE=uint16_sub_int2,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int2,
    RIGHTARG=uint16,
    PROCEDURE=int2_sub_uint16,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint16,
    RIGHTARG=int4,
    PROCEDURE=uint16_sub_int4,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int4,
    RIGHTARG=uint16,
    PROCEDURE=int4_sub_uint16,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint16,
    RIGHTARG=int8,
    PROCEDURE=uint16_sub_int8,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int8,
    RIGHTARG=uint16,
    PROCEDURE=int8_sub_uint16,
    COMMUTATOR = -
);


CREATE OPERATOR * (
    LEFTARG=uint16,
    RIGHTARG=uint16,
    PROCEDURE=uint16_mul_uint16
);

CREATE OPERATOR * (
    LEFTARG=uint16,
    RIGHTARG=int2,
    PROCEDURE=uint16_mul_int2
);

CREATE OPERATOR * (
    LEFTARG=int2,
    RIGHTARG=uint16,
    PROCEDURE=int2_mul_uint16
);

CREATE OPERATOR * (
    LEFTARG=uint16,
    RIGHTARG=int4,
    PROCEDURE=uint16_mul_int4
);

CREATE OPERATOR * (
    LEFTARG=int4,
    RIGHTARG=uint16,
    PROCEDURE=int4_mul_uint16
);

CREATE OPERATOR * (
    LEFTARG=uint16,
    RIGHTARG=int8,
    PROCEDURE=uint16_mul_int8
);

CREATE OPERATOR * (
    LEFTARG=int8,
    RIGHTARG=uint16,
    PROCEDURE=int8_mul_uint16
);


CREATE OPERATOR / (
    LEFTARG=uint16,
    RIGHTARG=uint16,
    PROCEDURE=uint16_div_uint16
);

CREATE OPERATOR / (
    LEFTARG=uint16,
    RIGHTARG=int2,
    PROCEDURE=uint16_div_int2
);

CREATE OPERATOR / (
    LEFTARG=int2,
    RIGHTARG=uint16,
    PROCEDURE=int2_div_uint16
);

CREATE OPERATOR / (
    LEFTARG=uint16,
    RIGHTARG=int4,
    PROCEDURE=uint16_div_int4
);

CREATE OPERATOR / (
    LEFTARG=int4,
    RIGHTARG=uint16,
    PROCEDURE=int4_div_uint16
);

CREATE OPERATOR / (
    LEFTARG=uint16,
    RIGHTARG=int8,
    PROCEDURE=uint16_div_int8
);

CREATE OPERATOR / (
    LEFTARG=int8,
    RIGHTARG=uint16,
    PROCEDURE=int8_div_uint16
);


CREATE OPERATOR % (
    LEFTARG=uint16,
    RIGHTARG=uint16,
    PROCEDURE=uint16_mod_uint16
);

CREATE OPERATOR % (
    LEFTARG=uint16,
    RIGHTARG=int2,
    PROCEDURE=uint16_mod_int2
);

CREATE OPERATOR % (
    LEFTARG=int2,
    RIGHTARG=uint16,
    PROCEDURE=int2_mod_uint16
);

CREATE OPERATOR % (
    LEFTARG=uint16,
    RIGHTARG=int4,
    PROCEDURE=uint16_mod_int4
);

CREATE OPERATOR % (
    LEFTARG=int4,
    RIGHTARG=uint16,
    PROCEDURE=int4_mod_uint16
);

CREATE OPERATOR % (
    LEFTARG=uint16,
    RIGHTARG=int8,
    PROCEDURE=uint16_mod_int8
);

CREATE OPERATOR % (
    LEFTARG=int8,
    RIGHTARG=uint16,
    PROCEDURE=int8_mod_uint16
);


CREATE OPERATOR # (
    LEFTARG=uint16,
    RIGHTARG=uint16,
    PROCEDURE=uint16_xor,
    COMMUTATOR = #
);


CREATE OPERATOR & (
    LEFTARG=uint16,
    RIGHTARG=uint16,
    PROCEDURE=uint16_and,
    COMMUTATOR = &
);


CREATE OPERATOR | (
    LEFTARG=uint16,
    RIGHTARG=uint16,
    PROCEDURE=uint16_or,
    COMMUTATOR = |
);


CREATE OPERATOR ~ (
    RIGHTARG=uint16,
    PROCEDURE=uint16_not
);


CREATE OPERATOR << (
    LEFTARG=uint16,
    RIGHTARG=int4,
    PROCEDURE=uint16_shl
);


CREATE OPERATOR >> (
    LEFTARG=uint16,
    RIGHTARG=int4,
    PROCEDURE=uint16_shr
);



-- Index ops block

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


CREATE OPERATOR CLASS uint16_ops
DEFAULT FOR TYPE uint16 USING btree FAMILY integer_ops AS
    OPERATOR 1 <,
    OPERATOR 2 <=,
    OPERATOR 3 =,
    OPERATOR 4 >=,
    OPERATOR 5 >,
    FUNCTION 1 uint16_cmp(uint16, uint16)
;

CREATE OPERATOR CLASS uint16_ops
DEFAULT FOR TYPE uint16 USING hash FAMILY integer_ops AS
    OPERATOR        1       = ,
    FUNCTION        1       uint16_hash(uint16);

-- Agg ops block

-- Transition function for accumulating uint16
CREATE FUNCTION uint16_avg_accum(internal, uint16)
RETURNS internal
AS '$libdir/uint128', 'uint16_avg_accum'
LANGUAGE C IMMUTABLE PARALLEL SAFE;

-- Inverse transition function for accumulating uint16
CREATE FUNCTION uint16_avg_accum_inv(internal, uint16)
RETURNS internal
AS '$libdir/uint128', 'uint16_avg_accum_inv'
LANGUAGE C IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE sum(uint16) (
    -- Transition function
    SFUNC = uint16_avg_accum,
    -- Internal state type
    STYPE = internal,
    -- Internal state size
    SSPACE = 128,
    -- Final function to return the sum
    FINALFUNC = numeric_sum,
    -- Combine function for parallel aggregation
    COMBINEFUNC = numeric_avg_combine,
    -- Moving transition function
    MSFUNC = uint16_avg_accum,
    -- Moving state type (same as STYPE)
    MSTYPE = internal,
    -- Moving inverse transition function
    MINVFUNC = uint16_avg_accum_inv,
    -- Moving final function for windows
    MFINALFUNC = numeric_sum,
    -- Serialize function
    SERIALFUNC = numeric_avg_serialize,
    -- Deserialize function
    DESERIALFUNC = numeric_avg_deserialize,
    -- Aggregate is parallel safe
    PARALLEL = SAFE
);

CREATE AGGREGATE avg(uint16) (
    -- Transition function
    SFUNC = uint16_avg_accum,
    -- Internal state type
    STYPE = internal,
    -- Internal state size
    SSPACE = 128,
    -- Final function to return the sum
    FINALFUNC = numeric_avg,
    -- Combine function for parallel aggregation
    COMBINEFUNC = numeric_avg_combine,
    -- Moving transition function
    MSFUNC = uint16_avg_accum,
    -- Moving state type (same as STYPE)
    MSTYPE = internal,
    -- Moving inverse transition function
    MINVFUNC = uint16_avg_accum_inv,
    -- Moving final function for windows
    MFINALFUNC = numeric_avg,
    -- Serialize function
    SERIALFUNC = numeric_avg_serialize,
    -- Deserialize function
    DESERIALFUNC = numeric_avg_deserialize,
    -- Aggregate is parallel safe
    PARALLEL = SAFE
);

CREATE FUNCTION uint16_smaller(uint16, uint16)
RETURNS uint16
AS '$libdir/uint128', 'uint16_smaller'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

CREATE AGGREGATE min(uint16) (
    -- Transition function
    SFUNC = uint16_smaller,         
	STYPE = uint16,
	COMBINEFUNC = uint16_smaller,
    SORTOP = <,
    PARALLEL = SAFE
);

CREATE FUNCTION uint16_larger(uint16, uint16)
RETURNS uint16
AS '$libdir/uint128', 'uint16_larger'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

CREATE AGGREGATE max(uint16) (
    -- Transition function
    SFUNC = uint16_larger,         
	STYPE = uint16,
	COMBINEFUNC = uint16_larger,
    SORTOP = >,
    PARALLEL = SAFE
);


-- Generate series block

CREATE FUNCTION generate_series_uint16_support(internal)
RETURNS internal
AS '$libdir/uint128', 'generate_series_uint16_support'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

CREATE FUNCTION generate_series(uint16, uint16)
RETURNS SETOF uint16
AS '$libdir/uint128', 'generate_series_uint16'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT SUPPORT generate_series_uint16_support;

CREATE FUNCTION generate_series(uint16, uint16, uint16)
RETURNS SETOF uint16
AS '$libdir/uint128', 'generate_series_step_uint16'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT SUPPORT generate_series_uint16_support;


-- Type uint8 block

CREATE FUNCTION uint8_in(cstring) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_in';

CREATE FUNCTION uint8_out(uint8) RETURNS cstring
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_out';

CREATE FUNCTION uint8_recv(internal) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_recv';

CREATE FUNCTION uint8_send(uint8) RETURNS bytea
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_send';

CREATE TYPE uint8 (
    INPUT = uint8_in,
    OUTPUT = uint8_out,
    RECEIVE = uint8_recv,
    SEND = uint8_send,
    INTERNALLENGTH = 8,
    PASSEDBYVALUE,
    ALIGNMENT = double
);


-- Inout casts block

CREATE CAST (double precision AS uint8) WITH INOUT AS ASSIGNMENT;
CREATE CAST (uint8 AS double precision) WITH INOUT AS IMPLICIT;

CREATE CAST (numeric AS uint8) WITH INOUT AS ASSIGNMENT;
CREATE CAST (uint8 AS numeric) WITH INOUT AS IMPLICIT;

CREATE CAST (real AS uint8) WITH INOUT AS ASSIGNMENT;
CREATE CAST (uint8 AS real) WITH INOUT AS IMPLICIT;


-- Casts block

CREATE FUNCTION uint8_from_int2(int2) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_from_int2';

CREATE FUNCTION uint8_to_int2(uint8) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_to_int2';

CREATE CAST (int2 AS uint8) WITH FUNCTION uint8_from_int2(int2) AS IMPLICIT;
CREATE CAST (uint8 AS int2) WITH FUNCTION uint8_to_int2(uint8) AS IMPLICIT;


CREATE FUNCTION uint8_from_int4(int4) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_from_int4';

CREATE FUNCTION uint8_to_int4(uint8) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_to_int4';

CREATE CAST (int4 AS uint8) WITH FUNCTION uint8_from_int4(int4) AS IMPLICIT;
CREATE CAST (uint8 AS int4) WITH FUNCTION uint8_to_int4(uint8) AS IMPLICIT;


CREATE FUNCTION uint8_from_int8(int8) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_from_int8';

CREATE FUNCTION uint8_to_int8(uint8) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_to_int8';

CREATE CAST (int8 AS uint8) WITH FUNCTION uint8_from_int8(int8) AS IMPLICIT;
CREATE CAST (uint8 AS int8) WITH FUNCTION uint8_to_int8(uint8) AS IMPLICIT;

-- Ops block

CREATE FUNCTION uint8_eq_uint8(uint8, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_eq_uint8';

CREATE FUNCTION uint8_eq_int2(uint8, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_eq_int2';

CREATE FUNCTION int2_eq_uint8(int2, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_eq_uint8';

CREATE FUNCTION uint8_eq_int4(uint8, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_eq_int4';

CREATE FUNCTION int4_eq_uint8(int4, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_eq_uint8';

CREATE FUNCTION uint8_eq_int8(uint8, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_eq_int8';

CREATE FUNCTION int8_eq_uint8(int8, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_eq_uint8';


CREATE FUNCTION uint8_ne_uint8(uint8, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ne_uint8';

CREATE FUNCTION uint8_ne_int2(uint8, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ne_int2';

CREATE FUNCTION int2_ne_uint8(int2, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_ne_uint8';

CREATE FUNCTION uint8_ne_int4(uint8, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ne_int4';

CREATE FUNCTION int4_ne_uint8(int4, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_ne_uint8';

CREATE FUNCTION uint8_ne_int8(uint8, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ne_int8';

CREATE FUNCTION int8_ne_uint8(int8, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_ne_uint8';


CREATE FUNCTION uint8_gt_uint8(uint8, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_gt_uint8';

CREATE FUNCTION uint8_gt_int2(uint8, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_gt_int2';

CREATE FUNCTION int2_gt_uint8(int2, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_gt_uint8';

CREATE FUNCTION uint8_gt_int4(uint8, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_gt_int4';

CREATE FUNCTION int4_gt_uint8(int4, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_gt_uint8';

CREATE FUNCTION uint8_gt_int8(uint8, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_gt_int8';

CREATE FUNCTION int8_gt_uint8(int8, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_gt_uint8';


CREATE FUNCTION uint8_lt_uint8(uint8, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_lt_uint8';

CREATE FUNCTION uint8_lt_int2(uint8, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_lt_int2';

CREATE FUNCTION int2_lt_uint8(int2, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_lt_uint8';

CREATE FUNCTION uint8_lt_int4(uint8, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_lt_int4';

CREATE FUNCTION int4_lt_uint8(int4, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_lt_uint8';

CREATE FUNCTION uint8_lt_int8(uint8, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_lt_int8';

CREATE FUNCTION int8_lt_uint8(int8, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_lt_uint8';


CREATE FUNCTION uint8_ge_uint8(uint8, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ge_uint8';

CREATE FUNCTION uint8_ge_int2(uint8, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ge_int2';

CREATE FUNCTION int2_ge_uint8(int2, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_ge_uint8';

CREATE FUNCTION uint8_ge_int4(uint8, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ge_int4';

CREATE FUNCTION int4_ge_uint8(int4, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_ge_uint8';

CREATE FUNCTION uint8_ge_int8(uint8, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ge_int8';

CREATE FUNCTION int8_ge_uint8(int8, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_ge_uint8';


CREATE FUNCTION uint8_le_uint8(uint8, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_le_uint8';

CREATE FUNCTION uint8_le_int2(uint8, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_le_int2';

CREATE FUNCTION int2_le_uint8(int2, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_le_uint8';

CREATE FUNCTION uint8_le_int4(uint8, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_le_int4';

CREATE FUNCTION int4_le_uint8(int4, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_le_uint8';

CREATE FUNCTION uint8_le_int8(uint8, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_le_int8';

CREATE FUNCTION int8_le_uint8(int8, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_le_uint8';


CREATE FUNCTION uint8_add_uint8(uint8, uint8) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_add_uint8';

CREATE FUNCTION uint8_add_int2(uint8, int2) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_add_int2';

CREATE FUNCTION int2_add_uint8(int2, uint8) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_add_uint8';

CREATE FUNCTION uint8_add_int4(uint8, int4) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_add_int4';

CREATE FUNCTION int4_add_uint8(int4, uint8) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_add_uint8';

CREATE FUNCTION uint8_add_int8(uint8, int8) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_add_int8';

CREATE FUNCTION int8_add_uint8(int8, uint8) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_add_uint8';


CREATE FUNCTION uint8_sub_uint8(uint8, uint8) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_sub_uint8';

CREATE FUNCTION uint8_sub_int2(uint8, int2) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_sub_int2';

CREATE FUNCTION int2_sub_uint8(int2, uint8) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_sub_uint8';

CREATE FUNCTION uint8_sub_int4(uint8, int4) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_sub_int4';

CREATE FUNCTION int4_sub_uint8(int4, uint8) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_sub_uint8';

CREATE FUNCTION uint8_sub_int8(uint8, int8) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_sub_int8';

CREATE FUNCTION int8_sub_uint8(int8, uint8) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_sub_uint8';


CREATE FUNCTION uint8_mul_uint8(uint8, uint8) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mul_uint8';

CREATE FUNCTION uint8_mul_int2(uint8, int2) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mul_int2';

CREATE FUNCTION int2_mul_uint8(int2, uint8) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_mul_uint8';

CREATE FUNCTION uint8_mul_int4(uint8, int4) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mul_int4';

CREATE FUNCTION int4_mul_uint8(int4, uint8) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_mul_uint8';

CREATE FUNCTION uint8_mul_int8(uint8, int8) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mul_int8';

CREATE FUNCTION int8_mul_uint8(int8, uint8) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_mul_uint8';


CREATE FUNCTION uint8_div_uint8(uint8, uint8) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_div_uint8';

CREATE FUNCTION uint8_div_int2(uint8, int2) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_div_int2';

CREATE FUNCTION int2_div_uint8(int2, uint8) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_div_uint8';

CREATE FUNCTION uint8_div_int4(uint8, int4) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_div_int4';

CREATE FUNCTION int4_div_uint8(int4, uint8) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_div_uint8';

CREATE FUNCTION uint8_div_int8(uint8, int8) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_div_int8';

CREATE FUNCTION int8_div_uint8(int8, uint8) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_div_uint8';


CREATE FUNCTION uint8_mod_uint8(uint8, uint8) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mod_uint8';

CREATE FUNCTION uint8_mod_int2(uint8, int2) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mod_int2';

CREATE FUNCTION int2_mod_uint8(int2, uint8) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_mod_uint8';

CREATE FUNCTION uint8_mod_int4(uint8, int4) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mod_int4';

CREATE FUNCTION int4_mod_uint8(int4, uint8) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_mod_uint8';

CREATE FUNCTION uint8_mod_int8(uint8, int8) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mod_int8';

CREATE FUNCTION int8_mod_uint8(int8, uint8) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_mod_uint8';


CREATE FUNCTION uint8_xor(uint8, uint8) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_xor';


CREATE FUNCTION uint8_and(uint8, uint8) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_and';


CREATE FUNCTION uint8_or(uint8, uint8) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_or';


CREATE FUNCTION uint8_not(uint8) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_not';

CREATE FUNCTION uint8_shl(uint8, int4) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_shl';


CREATE FUNCTION uint8_shr(uint8, int4) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_shr';


CREATE OPERATOR = (
    LEFTARG=uint8,
    RIGHTARG=uint8,
    PROCEDURE=uint8_eq_uint8,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint8,
    RIGHTARG=int2,
    PROCEDURE=uint8_eq_int2,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int2,
    RIGHTARG=uint8,
    PROCEDURE=int2_eq_uint8,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint8,
    RIGHTARG=int4,
    PROCEDURE=uint8_eq_int4,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int4,
    RIGHTARG=uint8,
    PROCEDURE=int4_eq_uint8,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint8,
    RIGHTARG=int8,
    PROCEDURE=uint8_eq_int8,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int8,
    RIGHTARG=uint8,
    PROCEDURE=int8_eq_uint8,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR <> (
    LEFTARG=uint8,
    RIGHTARG=uint8,
    PROCEDURE=uint8_ne_uint8,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint8,
    RIGHTARG=int2,
    PROCEDURE=uint8_ne_int2,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int2,
    RIGHTARG=uint8,
    PROCEDURE=int2_ne_uint8,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint8,
    RIGHTARG=int4,
    PROCEDURE=uint8_ne_int4,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int4,
    RIGHTARG=uint8,
    PROCEDURE=int4_ne_uint8,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint8,
    RIGHTARG=int8,
    PROCEDURE=uint8_ne_int8,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int8,
    RIGHTARG=uint8,
    PROCEDURE=int8_ne_uint8,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR > (
    LEFTARG=uint8,
    RIGHTARG=uint8,
    PROCEDURE=uint8_gt_uint8,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint8,
    RIGHTARG=int2,
    PROCEDURE=uint8_gt_int2,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int2,
    RIGHTARG=uint8,
    PROCEDURE=int2_gt_uint8,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint8,
    RIGHTARG=int4,
    PROCEDURE=uint8_gt_int4,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int4,
    RIGHTARG=uint8,
    PROCEDURE=int4_gt_uint8,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint8,
    RIGHTARG=int8,
    PROCEDURE=uint8_gt_int8,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int8,
    RIGHTARG=uint8,
    PROCEDURE=int8_gt_uint8,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR < (
    LEFTARG=uint8,
    RIGHTARG=uint8,
    PROCEDURE=uint8_lt_uint8,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint8,
    RIGHTARG=int2,
    PROCEDURE=uint8_lt_int2,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int2,
    RIGHTARG=uint8,
    PROCEDURE=int2_lt_uint8,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint8,
    RIGHTARG=int4,
    PROCEDURE=uint8_lt_int4,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int4,
    RIGHTARG=uint8,
    PROCEDURE=int4_lt_uint8,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint8,
    RIGHTARG=int8,
    PROCEDURE=uint8_lt_int8,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int8,
    RIGHTARG=uint8,
    PROCEDURE=int8_lt_uint8,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR >= (
    LEFTARG=uint8,
    RIGHTARG=uint8,
    PROCEDURE=uint8_ge_uint8,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint8,
    RIGHTARG=int2,
    PROCEDURE=uint8_ge_int2,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int2,
    RIGHTARG=uint8,
    PROCEDURE=int2_ge_uint8,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint8,
    RIGHTARG=int4,
    PROCEDURE=uint8_ge_int4,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int4,
    RIGHTARG=uint8,
    PROCEDURE=int4_ge_uint8,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint8,
    RIGHTARG=int8,
    PROCEDURE=uint8_ge_int8,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int8,
    RIGHTARG=uint8,
    PROCEDURE=int8_ge_uint8,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR <= (
    LEFTARG=uint8,
    RIGHTARG=uint8,
    PROCEDURE=uint8_le_uint8,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint8,
    RIGHTARG=int2,
    PROCEDURE=uint8_le_int2,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int2,
    RIGHTARG=uint8,
    PROCEDURE=int2_le_uint8,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint8,
    RIGHTARG=int4,
    PROCEDURE=uint8_le_int4,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int4,
    RIGHTARG=uint8,
    PROCEDURE=int4_le_uint8,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint8,
    RIGHTARG=int8,
    PROCEDURE=uint8_le_int8,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int8,
    RIGHTARG=uint8,
    PROCEDURE=int8_le_uint8,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR + (
    LEFTARG=uint8,
    RIGHTARG=uint8,
    PROCEDURE=uint8_add_uint8,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint8,
    RIGHTARG=int2,
    PROCEDURE=uint8_add_int2,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int2,
    RIGHTARG=uint8,
    PROCEDURE=int2_add_uint8,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint8,
    RIGHTARG=int4,
    PROCEDURE=uint8_add_int4,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int4,
    RIGHTARG=uint8,
    PROCEDURE=int4_add_uint8,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint8,
    RIGHTARG=int8,
    PROCEDURE=uint8_add_int8,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int8,
    RIGHTARG=uint8,
    PROCEDURE=int8_add_uint8,
    COMMUTATOR = +
);


CREATE OPERATOR - (
    LEFTARG=uint8,
    RIGHTARG=uint8,
    PROCEDURE=uint8_sub_uint8,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint8,
    RIGHTARG=int2,
    PROCEDURE=uint8_sub_int2,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int2,
    RIGHTARG=uint8,
    PROCEDURE=int2_sub_uint8,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint8,
    RIGHTARG=int4,
    PROCEDURE=uint8_sub_int4,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int4,
    RIGHTARG=uint8,
    PROCEDURE=int4_sub_uint8,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint8,
    RIGHTARG=int8,
    PROCEDURE=uint8_sub_int8,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int8,
    RIGHTARG=uint8,
    PROCEDURE=int8_sub_uint8,
    COMMUTATOR = -
);


CREATE OPERATOR * (
    LEFTARG=uint8,
    RIGHTARG=uint8,
    PROCEDURE=uint8_mul_uint8
);

CREATE OPERATOR * (
    LEFTARG=uint8,
    RIGHTARG=int2,
    PROCEDURE=uint8_mul_int2
);

CREATE OPERATOR * (
    LEFTARG=int2,
    RIGHTARG=uint8,
    PROCEDURE=int2_mul_uint8
);

CREATE OPERATOR * (
    LEFTARG=uint8,
    RIGHTARG=int4,
    PROCEDURE=uint8_mul_int4
);

CREATE OPERATOR * (
    LEFTARG=int4,
    RIGHTARG=uint8,
    PROCEDURE=int4_mul_uint8
);

CREATE OPERATOR * (
    LEFTARG=uint8,
    RIGHTARG=int8,
    PROCEDURE=uint8_mul_int8
);

CREATE OPERATOR * (
    LEFTARG=int8,
    RIGHTARG=uint8,
    PROCEDURE=int8_mul_uint8
);


CREATE OPERATOR / (
    LEFTARG=uint8,
    RIGHTARG=uint8,
    PROCEDURE=uint8_div_uint8
);

CREATE OPERATOR / (
    LEFTARG=uint8,
    RIGHTARG=int2,
    PROCEDURE=uint8_div_int2
);

CREATE OPERATOR / (
    LEFTARG=int2,
    RIGHTARG=uint8,
    PROCEDURE=int2_div_uint8
);

CREATE OPERATOR / (
    LEFTARG=uint8,
    RIGHTARG=int4,
    PROCEDURE=uint8_div_int4
);

CREATE OPERATOR / (
    LEFTARG=int4,
    RIGHTARG=uint8,
    PROCEDURE=int4_div_uint8
);

CREATE OPERATOR / (
    LEFTARG=uint8,
    RIGHTARG=int8,
    PROCEDURE=uint8_div_int8
);

CREATE OPERATOR / (
    LEFTARG=int8,
    RIGHTARG=uint8,
    PROCEDURE=int8_div_uint8
);


CREATE OPERATOR % (
    LEFTARG=uint8,
    RIGHTARG=uint8,
    PROCEDURE=uint8_mod_uint8
);

CREATE OPERATOR % (
    LEFTARG=uint8,
    RIGHTARG=int2,
    PROCEDURE=uint8_mod_int2
);

CREATE OPERATOR % (
    LEFTARG=int2,
    RIGHTARG=uint8,
    PROCEDURE=int2_mod_uint8
);

CREATE OPERATOR % (
    LEFTARG=uint8,
    RIGHTARG=int4,
    PROCEDURE=uint8_mod_int4
);

CREATE OPERATOR % (
    LEFTARG=int4,
    RIGHTARG=uint8,
    PROCEDURE=int4_mod_uint8
);

CREATE OPERATOR % (
    LEFTARG=uint8,
    RIGHTARG=int8,
    PROCEDURE=uint8_mod_int8
);

CREATE OPERATOR % (
    LEFTARG=int8,
    RIGHTARG=uint8,
    PROCEDURE=int8_mod_uint8
);


CREATE OPERATOR # (
    LEFTARG=uint8,
    RIGHTARG=uint8,
    PROCEDURE=uint8_xor,
    COMMUTATOR = #
);


CREATE OPERATOR & (
    LEFTARG=uint8,
    RIGHTARG=uint8,
    PROCEDURE=uint8_and,
    COMMUTATOR = &
);


CREATE OPERATOR | (
    LEFTARG=uint8,
    RIGHTARG=uint8,
    PROCEDURE=uint8_or,
    COMMUTATOR = |
);


CREATE OPERATOR ~ (
    RIGHTARG=uint8,
    PROCEDURE=uint8_not
);


CREATE OPERATOR << (
    LEFTARG=uint8,
    RIGHTARG=int4,
    PROCEDURE=uint8_shl
);


CREATE OPERATOR >> (
    LEFTARG=uint8,
    RIGHTARG=int4,
    PROCEDURE=uint8_shr
);



-- Index ops block

CREATE FUNCTION uint8_cmp(uint8, uint8) RETURNS int
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_cmp';

CREATE FUNCTION uint8_hash(uint8) RETURNS integer
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_hash';


CREATE OPERATOR CLASS uint8_ops
DEFAULT FOR TYPE uint8 USING btree FAMILY integer_ops AS
    OPERATOR 1 <,
    OPERATOR 2 <=,
    OPERATOR 3 =,
    OPERATOR 4 >=,
    OPERATOR 5 >,
    FUNCTION 1 uint8_cmp(uint8, uint8)
;

CREATE OPERATOR CLASS uint8_ops
DEFAULT FOR TYPE uint8 USING hash FAMILY integer_ops AS
    OPERATOR        1       = ,
    FUNCTION        1       uint8_hash(uint8);

-- Agg ops block

-- Transition function for accumulating uint8
CREATE FUNCTION uint8_avg_accum(internal, uint8)
RETURNS internal
AS '$libdir/uint128', 'uint8_avg_accum'
LANGUAGE C IMMUTABLE PARALLEL SAFE;

-- Inverse transition function for accumulating uint8
CREATE FUNCTION uint8_avg_accum_inv(internal, uint8)
RETURNS internal
AS '$libdir/uint128', 'uint8_avg_accum_inv'
LANGUAGE C IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE sum(uint8) (
    -- Transition function
    SFUNC = uint8_avg_accum,
    -- Internal state type
    STYPE = internal,
    -- Internal state size
    SSPACE = 128,
    -- Final function to return the sum
    FINALFUNC = numeric_sum,
    -- Combine function for parallel aggregation
    COMBINEFUNC = numeric_avg_combine,
    -- Moving transition function
    MSFUNC = uint8_avg_accum,
    -- Moving state type (same as STYPE)
    MSTYPE = internal,
    -- Moving inverse transition function
    MINVFUNC = uint8_avg_accum_inv,
    -- Moving final function for windows
    MFINALFUNC = numeric_sum,
    -- Serialize function
    SERIALFUNC = numeric_avg_serialize,
    -- Deserialize function
    DESERIALFUNC = numeric_avg_deserialize,
    -- Aggregate is parallel safe
    PARALLEL = SAFE
);

CREATE AGGREGATE avg(uint8) (
    -- Transition function
    SFUNC = uint8_avg_accum,
    -- Internal state type
    STYPE = internal,
    -- Internal state size
    SSPACE = 128,
    -- Final function to return the sum
    FINALFUNC = numeric_avg,
    -- Combine function for parallel aggregation
    COMBINEFUNC = numeric_avg_combine,
    -- Moving transition function
    MSFUNC = uint8_avg_accum,
    -- Moving state type (same as STYPE)
    MSTYPE = internal,
    -- Moving inverse transition function
    MINVFUNC = uint8_avg_accum_inv,
    -- Moving final function for windows
    MFINALFUNC = numeric_avg,
    -- Serialize function
    SERIALFUNC = numeric_avg_serialize,
    -- Deserialize function
    DESERIALFUNC = numeric_avg_deserialize,
    -- Aggregate is parallel safe
    PARALLEL = SAFE
);

CREATE FUNCTION uint8_smaller(uint8, uint8)
RETURNS uint8
AS '$libdir/uint128', 'uint8_smaller'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

CREATE AGGREGATE min(uint8) (
    -- Transition function
    SFUNC = uint8_smaller,         
	STYPE = uint8,
	COMBINEFUNC = uint8_smaller,
    SORTOP = <,
    PARALLEL = SAFE
);

CREATE FUNCTION uint8_larger(uint8, uint8)
RETURNS uint8
AS '$libdir/uint128', 'uint8_larger'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

CREATE AGGREGATE max(uint8) (
    -- Transition function
    SFUNC = uint8_larger,         
	STYPE = uint8,
	COMBINEFUNC = uint8_larger,
    SORTOP = >,
    PARALLEL = SAFE
);


-- Generate series block

CREATE FUNCTION generate_series_uint8_support(internal)
RETURNS internal
AS '$libdir/uint128', 'generate_series_uint8_support'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

CREATE FUNCTION generate_series(uint8, uint8)
RETURNS SETOF uint8
AS '$libdir/uint128', 'generate_series_uint8'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT SUPPORT generate_series_uint8_support;

CREATE FUNCTION generate_series(uint8, uint8, uint8)
RETURNS SETOF uint8
AS '$libdir/uint128', 'generate_series_step_uint8'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT SUPPORT generate_series_uint8_support;


-- Type uint4 block

CREATE FUNCTION uint4_in(cstring) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_in';

CREATE FUNCTION uint4_out(uint4) RETURNS cstring
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_out';

CREATE FUNCTION uint4_recv(internal) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_recv';

CREATE FUNCTION uint4_send(uint4) RETURNS bytea
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_send';

CREATE TYPE uint4 (
    INPUT = uint4_in,
    OUTPUT = uint4_out,
    RECEIVE = uint4_recv,
    SEND = uint4_send,
    INTERNALLENGTH = 4,
    PASSEDBYVALUE,
    ALIGNMENT = int4
);


-- Inout casts block

CREATE CAST (double precision AS uint4) WITH INOUT AS ASSIGNMENT;
CREATE CAST (uint4 AS double precision) WITH INOUT AS IMPLICIT;

CREATE CAST (numeric AS uint4) WITH INOUT AS ASSIGNMENT;
CREATE CAST (uint4 AS numeric) WITH INOUT AS IMPLICIT;

CREATE CAST (real AS uint4) WITH INOUT AS ASSIGNMENT;
CREATE CAST (uint4 AS real) WITH INOUT AS IMPLICIT;


-- Casts block

CREATE FUNCTION uint4_from_int2(int2) RETURNS uint4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_from_int2';

CREATE FUNCTION uint4_to_int2(uint4) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_to_int2';

CREATE CAST (int2 AS uint4) WITH FUNCTION uint4_from_int2(int2) AS IMPLICIT;
CREATE CAST (uint4 AS int2) WITH FUNCTION uint4_to_int2(uint4) AS IMPLICIT;


CREATE FUNCTION uint4_from_int4(int4) RETURNS uint4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_from_int4';

CREATE FUNCTION uint4_to_int4(uint4) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_to_int4';

CREATE CAST (int4 AS uint4) WITH FUNCTION uint4_from_int4(int4) AS IMPLICIT;
CREATE CAST (uint4 AS int4) WITH FUNCTION uint4_to_int4(uint4) AS IMPLICIT;


CREATE FUNCTION uint4_from_int8(int8) RETURNS uint4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_from_int8';

CREATE FUNCTION uint4_to_int8(uint4) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_to_int8';

CREATE CAST (int8 AS uint4) WITH FUNCTION uint4_from_int8(int8) AS IMPLICIT;
CREATE CAST (uint4 AS int8) WITH FUNCTION uint4_to_int8(uint4) AS IMPLICIT;

-- Ops block

CREATE FUNCTION uint4_eq_uint4(uint4, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_eq_uint4';

CREATE FUNCTION uint4_eq_int2(uint4, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_eq_int2';

CREATE FUNCTION int2_eq_uint4(int2, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_eq_uint4';

CREATE FUNCTION uint4_eq_int4(uint4, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_eq_int4';

CREATE FUNCTION int4_eq_uint4(int4, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_eq_uint4';

CREATE FUNCTION uint4_eq_int8(uint4, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_eq_int8';

CREATE FUNCTION int8_eq_uint4(int8, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_eq_uint4';


CREATE FUNCTION uint4_ne_uint4(uint4, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_ne_uint4';

CREATE FUNCTION uint4_ne_int2(uint4, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_ne_int2';

CREATE FUNCTION int2_ne_uint4(int2, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_ne_uint4';

CREATE FUNCTION uint4_ne_int4(uint4, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_ne_int4';

CREATE FUNCTION int4_ne_uint4(int4, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_ne_uint4';

CREATE FUNCTION uint4_ne_int8(uint4, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_ne_int8';

CREATE FUNCTION int8_ne_uint4(int8, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_ne_uint4';


CREATE FUNCTION uint4_gt_uint4(uint4, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_gt_uint4';

CREATE FUNCTION uint4_gt_int2(uint4, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_gt_int2';

CREATE FUNCTION int2_gt_uint4(int2, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_gt_uint4';

CREATE FUNCTION uint4_gt_int4(uint4, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_gt_int4';

CREATE FUNCTION int4_gt_uint4(int4, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_gt_uint4';

CREATE FUNCTION uint4_gt_int8(uint4, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_gt_int8';

CREATE FUNCTION int8_gt_uint4(int8, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_gt_uint4';


CREATE FUNCTION uint4_lt_uint4(uint4, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_lt_uint4';

CREATE FUNCTION uint4_lt_int2(uint4, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_lt_int2';

CREATE FUNCTION int2_lt_uint4(int2, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_lt_uint4';

CREATE FUNCTION uint4_lt_int4(uint4, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_lt_int4';

CREATE FUNCTION int4_lt_uint4(int4, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_lt_uint4';

CREATE FUNCTION uint4_lt_int8(uint4, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_lt_int8';

CREATE FUNCTION int8_lt_uint4(int8, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_lt_uint4';


CREATE FUNCTION uint4_ge_uint4(uint4, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_ge_uint4';

CREATE FUNCTION uint4_ge_int2(uint4, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_ge_int2';

CREATE FUNCTION int2_ge_uint4(int2, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_ge_uint4';

CREATE FUNCTION uint4_ge_int4(uint4, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_ge_int4';

CREATE FUNCTION int4_ge_uint4(int4, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_ge_uint4';

CREATE FUNCTION uint4_ge_int8(uint4, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_ge_int8';

CREATE FUNCTION int8_ge_uint4(int8, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_ge_uint4';


CREATE FUNCTION uint4_le_uint4(uint4, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_le_uint4';

CREATE FUNCTION uint4_le_int2(uint4, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_le_int2';

CREATE FUNCTION int2_le_uint4(int2, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_le_uint4';

CREATE FUNCTION uint4_le_int4(uint4, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_le_int4';

CREATE FUNCTION int4_le_uint4(int4, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_le_uint4';

CREATE FUNCTION uint4_le_int8(uint4, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_le_int8';

CREATE FUNCTION int8_le_uint4(int8, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_le_uint4';


CREATE FUNCTION uint4_add_uint4(uint4, uint4) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_add_uint4';

CREATE FUNCTION uint4_add_int2(uint4, int2) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_add_int2';

CREATE FUNCTION int2_add_uint4(int2, uint4) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_add_uint4';

CREATE FUNCTION uint4_add_int4(uint4, int4) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_add_int4';

CREATE FUNCTION int4_add_uint4(int4, uint4) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_add_uint4';

CREATE FUNCTION uint4_add_int8(uint4, int8) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_add_int8';

CREATE FUNCTION int8_add_uint4(int8, uint4) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_add_uint4';


CREATE FUNCTION uint4_sub_uint4(uint4, uint4) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_sub_uint4';

CREATE FUNCTION uint4_sub_int2(uint4, int2) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_sub_int2';

CREATE FUNCTION int2_sub_uint4(int2, uint4) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_sub_uint4';

CREATE FUNCTION uint4_sub_int4(uint4, int4) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_sub_int4';

CREATE FUNCTION int4_sub_uint4(int4, uint4) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_sub_uint4';

CREATE FUNCTION uint4_sub_int8(uint4, int8) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_sub_int8';

CREATE FUNCTION int8_sub_uint4(int8, uint4) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_sub_uint4';


CREATE FUNCTION uint4_mul_uint4(uint4, uint4) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_mul_uint4';

CREATE FUNCTION uint4_mul_int2(uint4, int2) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_mul_int2';

CREATE FUNCTION int2_mul_uint4(int2, uint4) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_mul_uint4';

CREATE FUNCTION uint4_mul_int4(uint4, int4) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_mul_int4';

CREATE FUNCTION int4_mul_uint4(int4, uint4) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_mul_uint4';

CREATE FUNCTION uint4_mul_int8(uint4, int8) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_mul_int8';

CREATE FUNCTION int8_mul_uint4(int8, uint4) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_mul_uint4';


CREATE FUNCTION uint4_div_uint4(uint4, uint4) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_div_uint4';

CREATE FUNCTION uint4_div_int2(uint4, int2) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_div_int2';

CREATE FUNCTION int2_div_uint4(int2, uint4) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_div_uint4';

CREATE FUNCTION uint4_div_int4(uint4, int4) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_div_int4';

CREATE FUNCTION int4_div_uint4(int4, uint4) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_div_uint4';

CREATE FUNCTION uint4_div_int8(uint4, int8) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_div_int8';

CREATE FUNCTION int8_div_uint4(int8, uint4) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_div_uint4';


CREATE FUNCTION uint4_mod_uint4(uint4, uint4) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_mod_uint4';

CREATE FUNCTION uint4_mod_int2(uint4, int2) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_mod_int2';

CREATE FUNCTION int2_mod_uint4(int2, uint4) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_mod_uint4';

CREATE FUNCTION uint4_mod_int4(uint4, int4) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_mod_int4';

CREATE FUNCTION int4_mod_uint4(int4, uint4) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_mod_uint4';

CREATE FUNCTION uint4_mod_int8(uint4, int8) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_mod_int8';

CREATE FUNCTION int8_mod_uint4(int8, uint4) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_mod_uint4';


CREATE FUNCTION uint4_xor(uint4, uint4) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_xor';


CREATE FUNCTION uint4_and(uint4, uint4) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_and';


CREATE FUNCTION uint4_or(uint4, uint4) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_or';


CREATE FUNCTION uint4_not(uint4) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_not';

CREATE FUNCTION uint4_shl(uint4, int4) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_shl';


CREATE FUNCTION uint4_shr(uint4, int4) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_shr';


CREATE OPERATOR = (
    LEFTARG=uint4,
    RIGHTARG=uint4,
    PROCEDURE=uint4_eq_uint4,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint4,
    RIGHTARG=int2,
    PROCEDURE=uint4_eq_int2,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int2,
    RIGHTARG=uint4,
    PROCEDURE=int2_eq_uint4,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint4,
    RIGHTARG=int4,
    PROCEDURE=uint4_eq_int4,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int4,
    RIGHTARG=uint4,
    PROCEDURE=int4_eq_uint4,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint4,
    RIGHTARG=int8,
    PROCEDURE=uint4_eq_int8,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int8,
    RIGHTARG=uint4,
    PROCEDURE=int8_eq_uint4,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR <> (
    LEFTARG=uint4,
    RIGHTARG=uint4,
    PROCEDURE=uint4_ne_uint4,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint4,
    RIGHTARG=int2,
    PROCEDURE=uint4_ne_int2,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int2,
    RIGHTARG=uint4,
    PROCEDURE=int2_ne_uint4,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint4,
    RIGHTARG=int4,
    PROCEDURE=uint4_ne_int4,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int4,
    RIGHTARG=uint4,
    PROCEDURE=int4_ne_uint4,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint4,
    RIGHTARG=int8,
    PROCEDURE=uint4_ne_int8,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int8,
    RIGHTARG=uint4,
    PROCEDURE=int8_ne_uint4,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR > (
    LEFTARG=uint4,
    RIGHTARG=uint4,
    PROCEDURE=uint4_gt_uint4,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint4,
    RIGHTARG=int2,
    PROCEDURE=uint4_gt_int2,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int2,
    RIGHTARG=uint4,
    PROCEDURE=int2_gt_uint4,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint4,
    RIGHTARG=int4,
    PROCEDURE=uint4_gt_int4,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int4,
    RIGHTARG=uint4,
    PROCEDURE=int4_gt_uint4,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint4,
    RIGHTARG=int8,
    PROCEDURE=uint4_gt_int8,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int8,
    RIGHTARG=uint4,
    PROCEDURE=int8_gt_uint4,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR < (
    LEFTARG=uint4,
    RIGHTARG=uint4,
    PROCEDURE=uint4_lt_uint4,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint4,
    RIGHTARG=int2,
    PROCEDURE=uint4_lt_int2,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int2,
    RIGHTARG=uint4,
    PROCEDURE=int2_lt_uint4,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint4,
    RIGHTARG=int4,
    PROCEDURE=uint4_lt_int4,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int4,
    RIGHTARG=uint4,
    PROCEDURE=int4_lt_uint4,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint4,
    RIGHTARG=int8,
    PROCEDURE=uint4_lt_int8,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int8,
    RIGHTARG=uint4,
    PROCEDURE=int8_lt_uint4,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR >= (
    LEFTARG=uint4,
    RIGHTARG=uint4,
    PROCEDURE=uint4_ge_uint4,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint4,
    RIGHTARG=int2,
    PROCEDURE=uint4_ge_int2,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int2,
    RIGHTARG=uint4,
    PROCEDURE=int2_ge_uint4,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint4,
    RIGHTARG=int4,
    PROCEDURE=uint4_ge_int4,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int4,
    RIGHTARG=uint4,
    PROCEDURE=int4_ge_uint4,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint4,
    RIGHTARG=int8,
    PROCEDURE=uint4_ge_int8,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int8,
    RIGHTARG=uint4,
    PROCEDURE=int8_ge_uint4,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR <= (
    LEFTARG=uint4,
    RIGHTARG=uint4,
    PROCEDURE=uint4_le_uint4,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint4,
    RIGHTARG=int2,
    PROCEDURE=uint4_le_int2,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int2,
    RIGHTARG=uint4,
    PROCEDURE=int2_le_uint4,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint4,
    RIGHTARG=int4,
    PROCEDURE=uint4_le_int4,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int4,
    RIGHTARG=uint4,
    PROCEDURE=int4_le_uint4,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint4,
    RIGHTARG=int8,
    PROCEDURE=uint4_le_int8,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int8,
    RIGHTARG=uint4,
    PROCEDURE=int8_le_uint4,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR + (
    LEFTARG=uint4,
    RIGHTARG=uint4,
    PROCEDURE=uint4_add_uint4,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint4,
    RIGHTARG=int2,
    PROCEDURE=uint4_add_int2,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int2,
    RIGHTARG=uint4,
    PROCEDURE=int2_add_uint4,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint4,
    RIGHTARG=int4,
    PROCEDURE=uint4_add_int4,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int4,
    RIGHTARG=uint4,
    PROCEDURE=int4_add_uint4,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint4,
    RIGHTARG=int8,
    PROCEDURE=uint4_add_int8,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int8,
    RIGHTARG=uint4,
    PROCEDURE=int8_add_uint4,
    COMMUTATOR = +
);


CREATE OPERATOR - (
    LEFTARG=uint4,
    RIGHTARG=uint4,
    PROCEDURE=uint4_sub_uint4,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint4,
    RIGHTARG=int2,
    PROCEDURE=uint4_sub_int2,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int2,
    RIGHTARG=uint4,
    PROCEDURE=int2_sub_uint4,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint4,
    RIGHTARG=int4,
    PROCEDURE=uint4_sub_int4,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int4,
    RIGHTARG=uint4,
    PROCEDURE=int4_sub_uint4,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint4,
    RIGHTARG=int8,
    PROCEDURE=uint4_sub_int8,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int8,
    RIGHTARG=uint4,
    PROCEDURE=int8_sub_uint4,
    COMMUTATOR = -
);


CREATE OPERATOR * (
    LEFTARG=uint4,
    RIGHTARG=uint4,
    PROCEDURE=uint4_mul_uint4
);

CREATE OPERATOR * (
    LEFTARG=uint4,
    RIGHTARG=int2,
    PROCEDURE=uint4_mul_int2
);

CREATE OPERATOR * (
    LEFTARG=int2,
    RIGHTARG=uint4,
    PROCEDURE=int2_mul_uint4
);

CREATE OPERATOR * (
    LEFTARG=uint4,
    RIGHTARG=int4,
    PROCEDURE=uint4_mul_int4
);

CREATE OPERATOR * (
    LEFTARG=int4,
    RIGHTARG=uint4,
    PROCEDURE=int4_mul_uint4
);

CREATE OPERATOR * (
    LEFTARG=uint4,
    RIGHTARG=int8,
    PROCEDURE=uint4_mul_int8
);

CREATE OPERATOR * (
    LEFTARG=int8,
    RIGHTARG=uint4,
    PROCEDURE=int8_mul_uint4
);


CREATE OPERATOR / (
    LEFTARG=uint4,
    RIGHTARG=uint4,
    PROCEDURE=uint4_div_uint4
);

CREATE OPERATOR / (
    LEFTARG=uint4,
    RIGHTARG=int2,
    PROCEDURE=uint4_div_int2
);

CREATE OPERATOR / (
    LEFTARG=int2,
    RIGHTARG=uint4,
    PROCEDURE=int2_div_uint4
);

CREATE OPERATOR / (
    LEFTARG=uint4,
    RIGHTARG=int4,
    PROCEDURE=uint4_div_int4
);

CREATE OPERATOR / (
    LEFTARG=int4,
    RIGHTARG=uint4,
    PROCEDURE=int4_div_uint4
);

CREATE OPERATOR / (
    LEFTARG=uint4,
    RIGHTARG=int8,
    PROCEDURE=uint4_div_int8
);

CREATE OPERATOR / (
    LEFTARG=int8,
    RIGHTARG=uint4,
    PROCEDURE=int8_div_uint4
);


CREATE OPERATOR % (
    LEFTARG=uint4,
    RIGHTARG=uint4,
    PROCEDURE=uint4_mod_uint4
);

CREATE OPERATOR % (
    LEFTARG=uint4,
    RIGHTARG=int2,
    PROCEDURE=uint4_mod_int2
);

CREATE OPERATOR % (
    LEFTARG=int2,
    RIGHTARG=uint4,
    PROCEDURE=int2_mod_uint4
);

CREATE OPERATOR % (
    LEFTARG=uint4,
    RIGHTARG=int4,
    PROCEDURE=uint4_mod_int4
);

CREATE OPERATOR % (
    LEFTARG=int4,
    RIGHTARG=uint4,
    PROCEDURE=int4_mod_uint4
);

CREATE OPERATOR % (
    LEFTARG=uint4,
    RIGHTARG=int8,
    PROCEDURE=uint4_mod_int8
);

CREATE OPERATOR % (
    LEFTARG=int8,
    RIGHTARG=uint4,
    PROCEDURE=int8_mod_uint4
);


CREATE OPERATOR # (
    LEFTARG=uint4,
    RIGHTARG=uint4,
    PROCEDURE=uint4_xor,
    COMMUTATOR = #
);


CREATE OPERATOR & (
    LEFTARG=uint4,
    RIGHTARG=uint4,
    PROCEDURE=uint4_and,
    COMMUTATOR = &
);


CREATE OPERATOR | (
    LEFTARG=uint4,
    RIGHTARG=uint4,
    PROCEDURE=uint4_or,
    COMMUTATOR = |
);


CREATE OPERATOR ~ (
    RIGHTARG=uint4,
    PROCEDURE=uint4_not
);


CREATE OPERATOR << (
    LEFTARG=uint4,
    RIGHTARG=int4,
    PROCEDURE=uint4_shl
);


CREATE OPERATOR >> (
    LEFTARG=uint4,
    RIGHTARG=int4,
    PROCEDURE=uint4_shr
);



-- Index ops block

CREATE FUNCTION uint4_cmp(uint4, uint4) RETURNS int
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_cmp';

CREATE FUNCTION uint4_hash(uint4) RETURNS integer
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_hash';


CREATE OPERATOR CLASS uint4_ops
DEFAULT FOR TYPE uint4 USING btree FAMILY integer_ops AS
    OPERATOR 1 <,
    OPERATOR 2 <=,
    OPERATOR 3 =,
    OPERATOR 4 >=,
    OPERATOR 5 >,
    FUNCTION 1 uint4_cmp(uint4, uint4)
;

CREATE OPERATOR CLASS uint4_ops
DEFAULT FOR TYPE uint4 USING hash FAMILY integer_ops AS
    OPERATOR        1       = ,
    FUNCTION        1       uint4_hash(uint4);

-- Agg ops block

-- Transition function for accumulating uint4
CREATE FUNCTION uint4_avg_accum(internal, uint4)
RETURNS internal
AS '$libdir/uint128', 'uint4_avg_accum'
LANGUAGE C IMMUTABLE PARALLEL SAFE;

-- Inverse transition function for accumulating uint4
CREATE FUNCTION uint4_avg_accum_inv(internal, uint4)
RETURNS internal
AS '$libdir/uint128', 'uint4_avg_accum_inv'
LANGUAGE C IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE sum(uint4) (
    -- Transition function
    SFUNC = uint4_avg_accum,
    -- Internal state type
    STYPE = internal,
    -- Internal state size
    SSPACE = 128,
    -- Final function to return the sum
    FINALFUNC = numeric_sum,
    -- Combine function for parallel aggregation
    COMBINEFUNC = numeric_avg_combine,
    -- Moving transition function
    MSFUNC = uint4_avg_accum,
    -- Moving state type (same as STYPE)
    MSTYPE = internal,
    -- Moving inverse transition function
    MINVFUNC = uint4_avg_accum_inv,
    -- Moving final function for windows
    MFINALFUNC = numeric_sum,
    -- Serialize function
    SERIALFUNC = numeric_avg_serialize,
    -- Deserialize function
    DESERIALFUNC = numeric_avg_deserialize,
    -- Aggregate is parallel safe
    PARALLEL = SAFE
);

CREATE AGGREGATE avg(uint4) (
    -- Transition function
    SFUNC = uint4_avg_accum,
    -- Internal state type
    STYPE = internal,
    -- Internal state size
    SSPACE = 128,
    -- Final function to return the sum
    FINALFUNC = numeric_avg,
    -- Combine function for parallel aggregation
    COMBINEFUNC = numeric_avg_combine,
    -- Moving transition function
    MSFUNC = uint4_avg_accum,
    -- Moving state type (same as STYPE)
    MSTYPE = internal,
    -- Moving inverse transition function
    MINVFUNC = uint4_avg_accum_inv,
    -- Moving final function for windows
    MFINALFUNC = numeric_avg,
    -- Serialize function
    SERIALFUNC = numeric_avg_serialize,
    -- Deserialize function
    DESERIALFUNC = numeric_avg_deserialize,
    -- Aggregate is parallel safe
    PARALLEL = SAFE
);

CREATE FUNCTION uint4_smaller(uint4, uint4)
RETURNS uint4
AS '$libdir/uint128', 'uint4_smaller'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

CREATE AGGREGATE min(uint4) (
    -- Transition function
    SFUNC = uint4_smaller,         
	STYPE = uint4,
	COMBINEFUNC = uint4_smaller,
    SORTOP = <,
    PARALLEL = SAFE
);

CREATE FUNCTION uint4_larger(uint4, uint4)
RETURNS uint4
AS '$libdir/uint128', 'uint4_larger'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

CREATE AGGREGATE max(uint4) (
    -- Transition function
    SFUNC = uint4_larger,         
	STYPE = uint4,
	COMBINEFUNC = uint4_larger,
    SORTOP = >,
    PARALLEL = SAFE
);


-- Generate series block

CREATE FUNCTION generate_series_uint4_support(internal)
RETURNS internal
AS '$libdir/uint128', 'generate_series_uint4_support'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

CREATE FUNCTION generate_series(uint4, uint4)
RETURNS SETOF uint4
AS '$libdir/uint128', 'generate_series_uint4'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT SUPPORT generate_series_uint4_support;

CREATE FUNCTION generate_series(uint4, uint4, uint4)
RETURNS SETOF uint4
AS '$libdir/uint128', 'generate_series_step_uint4'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT SUPPORT generate_series_uint4_support;


-- Type uint2 block

CREATE FUNCTION uint2_in(cstring) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_in';

CREATE FUNCTION uint2_out(uint2) RETURNS cstring
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_out';

CREATE FUNCTION uint2_recv(internal) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_recv';

CREATE FUNCTION uint2_send(uint2) RETURNS bytea
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_send';

CREATE TYPE uint2 (
    INPUT = uint2_in,
    OUTPUT = uint2_out,
    RECEIVE = uint2_recv,
    SEND = uint2_send,
    INTERNALLENGTH = 2,
    PASSEDBYVALUE,
    ALIGNMENT = int2
);


-- Inout casts block

CREATE CAST (double precision AS uint2) WITH INOUT AS ASSIGNMENT;
CREATE CAST (uint2 AS double precision) WITH INOUT AS IMPLICIT;

CREATE CAST (numeric AS uint2) WITH INOUT AS ASSIGNMENT;
CREATE CAST (uint2 AS numeric) WITH INOUT AS IMPLICIT;

CREATE CAST (real AS uint2) WITH INOUT AS ASSIGNMENT;
CREATE CAST (uint2 AS real) WITH INOUT AS IMPLICIT;


-- Casts block

CREATE FUNCTION uint2_from_int2(int2) RETURNS uint2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_from_int2';

CREATE FUNCTION uint2_to_int2(uint2) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_to_int2';

CREATE CAST (int2 AS uint2) WITH FUNCTION uint2_from_int2(int2) AS IMPLICIT;
CREATE CAST (uint2 AS int2) WITH FUNCTION uint2_to_int2(uint2) AS IMPLICIT;


CREATE FUNCTION uint2_from_int4(int4) RETURNS uint2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_from_int4';

CREATE FUNCTION uint2_to_int4(uint2) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_to_int4';

CREATE CAST (int4 AS uint2) WITH FUNCTION uint2_from_int4(int4) AS IMPLICIT;
CREATE CAST (uint2 AS int4) WITH FUNCTION uint2_to_int4(uint2) AS IMPLICIT;


CREATE FUNCTION uint2_from_int8(int8) RETURNS uint2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_from_int8';

CREATE FUNCTION uint2_to_int8(uint2) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_to_int8';

CREATE CAST (int8 AS uint2) WITH FUNCTION uint2_from_int8(int8) AS IMPLICIT;
CREATE CAST (uint2 AS int8) WITH FUNCTION uint2_to_int8(uint2) AS IMPLICIT;

-- Ops block

CREATE FUNCTION uint2_eq_uint2(uint2, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_eq_uint2';

CREATE FUNCTION uint2_eq_int2(uint2, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_eq_int2';

CREATE FUNCTION int2_eq_uint2(int2, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_eq_uint2';

CREATE FUNCTION uint2_eq_int4(uint2, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_eq_int4';

CREATE FUNCTION int4_eq_uint2(int4, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_eq_uint2';

CREATE FUNCTION uint2_eq_int8(uint2, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_eq_int8';

CREATE FUNCTION int8_eq_uint2(int8, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_eq_uint2';


CREATE FUNCTION uint2_ne_uint2(uint2, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_ne_uint2';

CREATE FUNCTION uint2_ne_int2(uint2, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_ne_int2';

CREATE FUNCTION int2_ne_uint2(int2, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_ne_uint2';

CREATE FUNCTION uint2_ne_int4(uint2, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_ne_int4';

CREATE FUNCTION int4_ne_uint2(int4, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_ne_uint2';

CREATE FUNCTION uint2_ne_int8(uint2, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_ne_int8';

CREATE FUNCTION int8_ne_uint2(int8, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_ne_uint2';


CREATE FUNCTION uint2_gt_uint2(uint2, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_gt_uint2';

CREATE FUNCTION uint2_gt_int2(uint2, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_gt_int2';

CREATE FUNCTION int2_gt_uint2(int2, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_gt_uint2';

CREATE FUNCTION uint2_gt_int4(uint2, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_gt_int4';

CREATE FUNCTION int4_gt_uint2(int4, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_gt_uint2';

CREATE FUNCTION uint2_gt_int8(uint2, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_gt_int8';

CREATE FUNCTION int8_gt_uint2(int8, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_gt_uint2';


CREATE FUNCTION uint2_lt_uint2(uint2, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_lt_uint2';

CREATE FUNCTION uint2_lt_int2(uint2, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_lt_int2';

CREATE FUNCTION int2_lt_uint2(int2, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_lt_uint2';

CREATE FUNCTION uint2_lt_int4(uint2, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_lt_int4';

CREATE FUNCTION int4_lt_uint2(int4, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_lt_uint2';

CREATE FUNCTION uint2_lt_int8(uint2, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_lt_int8';

CREATE FUNCTION int8_lt_uint2(int8, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_lt_uint2';


CREATE FUNCTION uint2_ge_uint2(uint2, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_ge_uint2';

CREATE FUNCTION uint2_ge_int2(uint2, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_ge_int2';

CREATE FUNCTION int2_ge_uint2(int2, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_ge_uint2';

CREATE FUNCTION uint2_ge_int4(uint2, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_ge_int4';

CREATE FUNCTION int4_ge_uint2(int4, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_ge_uint2';

CREATE FUNCTION uint2_ge_int8(uint2, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_ge_int8';

CREATE FUNCTION int8_ge_uint2(int8, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_ge_uint2';


CREATE FUNCTION uint2_le_uint2(uint2, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_le_uint2';

CREATE FUNCTION uint2_le_int2(uint2, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_le_int2';

CREATE FUNCTION int2_le_uint2(int2, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_le_uint2';

CREATE FUNCTION uint2_le_int4(uint2, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_le_int4';

CREATE FUNCTION int4_le_uint2(int4, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_le_uint2';

CREATE FUNCTION uint2_le_int8(uint2, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_le_int8';

CREATE FUNCTION int8_le_uint2(int8, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_le_uint2';


CREATE FUNCTION uint2_add_uint2(uint2, uint2) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_add_uint2';

CREATE FUNCTION uint2_add_int2(uint2, int2) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_add_int2';

CREATE FUNCTION int2_add_uint2(int2, uint2) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_add_uint2';

CREATE FUNCTION uint2_add_int4(uint2, int4) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_add_int4';

CREATE FUNCTION int4_add_uint2(int4, uint2) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_add_uint2';

CREATE FUNCTION uint2_add_int8(uint2, int8) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_add_int8';

CREATE FUNCTION int8_add_uint2(int8, uint2) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_add_uint2';


CREATE FUNCTION uint2_sub_uint2(uint2, uint2) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_sub_uint2';

CREATE FUNCTION uint2_sub_int2(uint2, int2) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_sub_int2';

CREATE FUNCTION int2_sub_uint2(int2, uint2) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_sub_uint2';

CREATE FUNCTION uint2_sub_int4(uint2, int4) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_sub_int4';

CREATE FUNCTION int4_sub_uint2(int4, uint2) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_sub_uint2';

CREATE FUNCTION uint2_sub_int8(uint2, int8) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_sub_int8';

CREATE FUNCTION int8_sub_uint2(int8, uint2) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_sub_uint2';


CREATE FUNCTION uint2_mul_uint2(uint2, uint2) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_mul_uint2';

CREATE FUNCTION uint2_mul_int2(uint2, int2) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_mul_int2';

CREATE FUNCTION int2_mul_uint2(int2, uint2) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_mul_uint2';

CREATE FUNCTION uint2_mul_int4(uint2, int4) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_mul_int4';

CREATE FUNCTION int4_mul_uint2(int4, uint2) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_mul_uint2';

CREATE FUNCTION uint2_mul_int8(uint2, int8) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_mul_int8';

CREATE FUNCTION int8_mul_uint2(int8, uint2) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_mul_uint2';


CREATE FUNCTION uint2_div_uint2(uint2, uint2) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_div_uint2';

CREATE FUNCTION uint2_div_int2(uint2, int2) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_div_int2';

CREATE FUNCTION int2_div_uint2(int2, uint2) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_div_uint2';

CREATE FUNCTION uint2_div_int4(uint2, int4) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_div_int4';

CREATE FUNCTION int4_div_uint2(int4, uint2) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_div_uint2';

CREATE FUNCTION uint2_div_int8(uint2, int8) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_div_int8';

CREATE FUNCTION int8_div_uint2(int8, uint2) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_div_uint2';


CREATE FUNCTION uint2_mod_uint2(uint2, uint2) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_mod_uint2';

CREATE FUNCTION uint2_mod_int2(uint2, int2) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_mod_int2';

CREATE FUNCTION int2_mod_uint2(int2, uint2) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_mod_uint2';

CREATE FUNCTION uint2_mod_int4(uint2, int4) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_mod_int4';

CREATE FUNCTION int4_mod_uint2(int4, uint2) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_mod_uint2';

CREATE FUNCTION uint2_mod_int8(uint2, int8) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_mod_int8';

CREATE FUNCTION int8_mod_uint2(int8, uint2) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_mod_uint2';


CREATE FUNCTION uint2_xor(uint2, uint2) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_xor';


CREATE FUNCTION uint2_and(uint2, uint2) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_and';


CREATE FUNCTION uint2_or(uint2, uint2) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_or';


CREATE FUNCTION uint2_not(uint2) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_not';

CREATE FUNCTION uint2_shl(uint2, int4) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_shl';


CREATE FUNCTION uint2_shr(uint2, int4) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_shr';


CREATE OPERATOR = (
    LEFTARG=uint2,
    RIGHTARG=uint2,
    PROCEDURE=uint2_eq_uint2,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint2,
    RIGHTARG=int2,
    PROCEDURE=uint2_eq_int2,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int2,
    RIGHTARG=uint2,
    PROCEDURE=int2_eq_uint2,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint2,
    RIGHTARG=int4,
    PROCEDURE=uint2_eq_int4,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int4,
    RIGHTARG=uint2,
    PROCEDURE=int4_eq_uint2,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint2,
    RIGHTARG=int8,
    PROCEDURE=uint2_eq_int8,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int8,
    RIGHTARG=uint2,
    PROCEDURE=int8_eq_uint2,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR <> (
    LEFTARG=uint2,
    RIGHTARG=uint2,
    PROCEDURE=uint2_ne_uint2,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint2,
    RIGHTARG=int2,
    PROCEDURE=uint2_ne_int2,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int2,
    RIGHTARG=uint2,
    PROCEDURE=int2_ne_uint2,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint2,
    RIGHTARG=int4,
    PROCEDURE=uint2_ne_int4,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int4,
    RIGHTARG=uint2,
    PROCEDURE=int4_ne_uint2,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint2,
    RIGHTARG=int8,
    PROCEDURE=uint2_ne_int8,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int8,
    RIGHTARG=uint2,
    PROCEDURE=int8_ne_uint2,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR > (
    LEFTARG=uint2,
    RIGHTARG=uint2,
    PROCEDURE=uint2_gt_uint2,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint2,
    RIGHTARG=int2,
    PROCEDURE=uint2_gt_int2,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int2,
    RIGHTARG=uint2,
    PROCEDURE=int2_gt_uint2,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint2,
    RIGHTARG=int4,
    PROCEDURE=uint2_gt_int4,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int4,
    RIGHTARG=uint2,
    PROCEDURE=int4_gt_uint2,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint2,
    RIGHTARG=int8,
    PROCEDURE=uint2_gt_int8,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int8,
    RIGHTARG=uint2,
    PROCEDURE=int8_gt_uint2,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR < (
    LEFTARG=uint2,
    RIGHTARG=uint2,
    PROCEDURE=uint2_lt_uint2,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint2,
    RIGHTARG=int2,
    PROCEDURE=uint2_lt_int2,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int2,
    RIGHTARG=uint2,
    PROCEDURE=int2_lt_uint2,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint2,
    RIGHTARG=int4,
    PROCEDURE=uint2_lt_int4,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int4,
    RIGHTARG=uint2,
    PROCEDURE=int4_lt_uint2,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint2,
    RIGHTARG=int8,
    PROCEDURE=uint2_lt_int8,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int8,
    RIGHTARG=uint2,
    PROCEDURE=int8_lt_uint2,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR >= (
    LEFTARG=uint2,
    RIGHTARG=uint2,
    PROCEDURE=uint2_ge_uint2,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint2,
    RIGHTARG=int2,
    PROCEDURE=uint2_ge_int2,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int2,
    RIGHTARG=uint2,
    PROCEDURE=int2_ge_uint2,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint2,
    RIGHTARG=int4,
    PROCEDURE=uint2_ge_int4,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int4,
    RIGHTARG=uint2,
    PROCEDURE=int4_ge_uint2,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint2,
    RIGHTARG=int8,
    PROCEDURE=uint2_ge_int8,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int8,
    RIGHTARG=uint2,
    PROCEDURE=int8_ge_uint2,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR <= (
    LEFTARG=uint2,
    RIGHTARG=uint2,
    PROCEDURE=uint2_le_uint2,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint2,
    RIGHTARG=int2,
    PROCEDURE=uint2_le_int2,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int2,
    RIGHTARG=uint2,
    PROCEDURE=int2_le_uint2,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint2,
    RIGHTARG=int4,
    PROCEDURE=uint2_le_int4,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int4,
    RIGHTARG=uint2,
    PROCEDURE=int4_le_uint2,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint2,
    RIGHTARG=int8,
    PROCEDURE=uint2_le_int8,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int8,
    RIGHTARG=uint2,
    PROCEDURE=int8_le_uint2,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR + (
    LEFTARG=uint2,
    RIGHTARG=uint2,
    PROCEDURE=uint2_add_uint2,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint2,
    RIGHTARG=int2,
    PROCEDURE=uint2_add_int2,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int2,
    RIGHTARG=uint2,
    PROCEDURE=int2_add_uint2,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint2,
    RIGHTARG=int4,
    PROCEDURE=uint2_add_int4,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int4,
    RIGHTARG=uint2,
    PROCEDURE=int4_add_uint2,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint2,
    RIGHTARG=int8,
    PROCEDURE=uint2_add_int8,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int8,
    RIGHTARG=uint2,
    PROCEDURE=int8_add_uint2,
    COMMUTATOR = +
);


CREATE OPERATOR - (
    LEFTARG=uint2,
    RIGHTARG=uint2,
    PROCEDURE=uint2_sub_uint2,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint2,
    RIGHTARG=int2,
    PROCEDURE=uint2_sub_int2,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int2,
    RIGHTARG=uint2,
    PROCEDURE=int2_sub_uint2,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint2,
    RIGHTARG=int4,
    PROCEDURE=uint2_sub_int4,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int4,
    RIGHTARG=uint2,
    PROCEDURE=int4_sub_uint2,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint2,
    RIGHTARG=int8,
    PROCEDURE=uint2_sub_int8,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int8,
    RIGHTARG=uint2,
    PROCEDURE=int8_sub_uint2,
    COMMUTATOR = -
);


CREATE OPERATOR * (
    LEFTARG=uint2,
    RIGHTARG=uint2,
    PROCEDURE=uint2_mul_uint2
);

CREATE OPERATOR * (
    LEFTARG=uint2,
    RIGHTARG=int2,
    PROCEDURE=uint2_mul_int2
);

CREATE OPERATOR * (
    LEFTARG=int2,
    RIGHTARG=uint2,
    PROCEDURE=int2_mul_uint2
);

CREATE OPERATOR * (
    LEFTARG=uint2,
    RIGHTARG=int4,
    PROCEDURE=uint2_mul_int4
);

CREATE OPERATOR * (
    LEFTARG=int4,
    RIGHTARG=uint2,
    PROCEDURE=int4_mul_uint2
);

CREATE OPERATOR * (
    LEFTARG=uint2,
    RIGHTARG=int8,
    PROCEDURE=uint2_mul_int8
);

CREATE OPERATOR * (
    LEFTARG=int8,
    RIGHTARG=uint2,
    PROCEDURE=int8_mul_uint2
);


CREATE OPERATOR / (
    LEFTARG=uint2,
    RIGHTARG=uint2,
    PROCEDURE=uint2_div_uint2
);

CREATE OPERATOR / (
    LEFTARG=uint2,
    RIGHTARG=int2,
    PROCEDURE=uint2_div_int2
);

CREATE OPERATOR / (
    LEFTARG=int2,
    RIGHTARG=uint2,
    PROCEDURE=int2_div_uint2
);

CREATE OPERATOR / (
    LEFTARG=uint2,
    RIGHTARG=int4,
    PROCEDURE=uint2_div_int4
);

CREATE OPERATOR / (
    LEFTARG=int4,
    RIGHTARG=uint2,
    PROCEDURE=int4_div_uint2
);

CREATE OPERATOR / (
    LEFTARG=uint2,
    RIGHTARG=int8,
    PROCEDURE=uint2_div_int8
);

CREATE OPERATOR / (
    LEFTARG=int8,
    RIGHTARG=uint2,
    PROCEDURE=int8_div_uint2
);


CREATE OPERATOR % (
    LEFTARG=uint2,
    RIGHTARG=uint2,
    PROCEDURE=uint2_mod_uint2
);

CREATE OPERATOR % (
    LEFTARG=uint2,
    RIGHTARG=int2,
    PROCEDURE=uint2_mod_int2
);

CREATE OPERATOR % (
    LEFTARG=int2,
    RIGHTARG=uint2,
    PROCEDURE=int2_mod_uint2
);

CREATE OPERATOR % (
    LEFTARG=uint2,
    RIGHTARG=int4,
    PROCEDURE=uint2_mod_int4
);

CREATE OPERATOR % (
    LEFTARG=int4,
    RIGHTARG=uint2,
    PROCEDURE=int4_mod_uint2
);

CREATE OPERATOR % (
    LEFTARG=uint2,
    RIGHTARG=int8,
    PROCEDURE=uint2_mod_int8
);

CREATE OPERATOR % (
    LEFTARG=int8,
    RIGHTARG=uint2,
    PROCEDURE=int8_mod_uint2
);


CREATE OPERATOR # (
    LEFTARG=uint2,
    RIGHTARG=uint2,
    PROCEDURE=uint2_xor,
    COMMUTATOR = #
);


CREATE OPERATOR & (
    LEFTARG=uint2,
    RIGHTARG=uint2,
    PROCEDURE=uint2_and,
    COMMUTATOR = &
);


CREATE OPERATOR | (
    LEFTARG=uint2,
    RIGHTARG=uint2,
    PROCEDURE=uint2_or,
    COMMUTATOR = |
);


CREATE OPERATOR ~ (
    RIGHTARG=uint2,
    PROCEDURE=uint2_not
);


CREATE OPERATOR << (
    LEFTARG=uint2,
    RIGHTARG=int4,
    PROCEDURE=uint2_shl
);


CREATE OPERATOR >> (
    LEFTARG=uint2,
    RIGHTARG=int4,
    PROCEDURE=uint2_shr
);



-- Index ops block

CREATE FUNCTION uint2_cmp(uint2, uint2) RETURNS int
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_cmp';

CREATE FUNCTION uint2_hash(uint2) RETURNS integer
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_hash';


CREATE OPERATOR CLASS uint2_ops
DEFAULT FOR TYPE uint2 USING btree FAMILY integer_ops AS
    OPERATOR 1 <,
    OPERATOR 2 <=,
    OPERATOR 3 =,
    OPERATOR 4 >=,
    OPERATOR 5 >,
    FUNCTION 1 uint2_cmp(uint2, uint2)
;

CREATE OPERATOR CLASS uint2_ops
DEFAULT FOR TYPE uint2 USING hash FAMILY integer_ops AS
    OPERATOR        1       = ,
    FUNCTION        1       uint2_hash(uint2);

-- Agg ops block

-- Transition function for accumulating uint2
CREATE FUNCTION uint2_avg_accum(internal, uint2)
RETURNS internal
AS '$libdir/uint128', 'uint2_avg_accum'
LANGUAGE C IMMUTABLE PARALLEL SAFE;

-- Inverse transition function for accumulating uint2
CREATE FUNCTION uint2_avg_accum_inv(internal, uint2)
RETURNS internal
AS '$libdir/uint128', 'uint2_avg_accum_inv'
LANGUAGE C IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE sum(uint2) (
    -- Transition function
    SFUNC = uint2_avg_accum,
    -- Internal state type
    STYPE = internal,
    -- Internal state size
    SSPACE = 128,
    -- Final function to return the sum
    FINALFUNC = numeric_sum,
    -- Combine function for parallel aggregation
    COMBINEFUNC = numeric_avg_combine,
    -- Moving transition function
    MSFUNC = uint2_avg_accum,
    -- Moving state type (same as STYPE)
    MSTYPE = internal,
    -- Moving inverse transition function
    MINVFUNC = uint2_avg_accum_inv,
    -- Moving final function for windows
    MFINALFUNC = numeric_sum,
    -- Serialize function
    SERIALFUNC = numeric_avg_serialize,
    -- Deserialize function
    DESERIALFUNC = numeric_avg_deserialize,
    -- Aggregate is parallel safe
    PARALLEL = SAFE
);

CREATE AGGREGATE avg(uint2) (
    -- Transition function
    SFUNC = uint2_avg_accum,
    -- Internal state type
    STYPE = internal,
    -- Internal state size
    SSPACE = 128,
    -- Final function to return the sum
    FINALFUNC = numeric_avg,
    -- Combine function for parallel aggregation
    COMBINEFUNC = numeric_avg_combine,
    -- Moving transition function
    MSFUNC = uint2_avg_accum,
    -- Moving state type (same as STYPE)
    MSTYPE = internal,
    -- Moving inverse transition function
    MINVFUNC = uint2_avg_accum_inv,
    -- Moving final function for windows
    MFINALFUNC = numeric_avg,
    -- Serialize function
    SERIALFUNC = numeric_avg_serialize,
    -- Deserialize function
    DESERIALFUNC = numeric_avg_deserialize,
    -- Aggregate is parallel safe
    PARALLEL = SAFE
);

CREATE FUNCTION uint2_smaller(uint2, uint2)
RETURNS uint2
AS '$libdir/uint128', 'uint2_smaller'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

CREATE AGGREGATE min(uint2) (
    -- Transition function
    SFUNC = uint2_smaller,         
	STYPE = uint2,
	COMBINEFUNC = uint2_smaller,
    SORTOP = <,
    PARALLEL = SAFE
);

CREATE FUNCTION uint2_larger(uint2, uint2)
RETURNS uint2
AS '$libdir/uint128', 'uint2_larger'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

CREATE AGGREGATE max(uint2) (
    -- Transition function
    SFUNC = uint2_larger,         
	STYPE = uint2,
	COMBINEFUNC = uint2_larger,
    SORTOP = >,
    PARALLEL = SAFE
);


-- Generate series block

CREATE FUNCTION generate_series_uint2_support(internal)
RETURNS internal
AS '$libdir/uint128', 'generate_series_uint2_support'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

CREATE FUNCTION generate_series(uint2, uint2)
RETURNS SETOF uint2
AS '$libdir/uint128', 'generate_series_uint2'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT SUPPORT generate_series_uint2_support;

CREATE FUNCTION generate_series(uint2, uint2, uint2)
RETURNS SETOF uint2
AS '$libdir/uint128', 'generate_series_step_uint2'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT SUPPORT generate_series_uint2_support;


-- Type int16 block

CREATE FUNCTION int16_in(cstring) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_in';

CREATE FUNCTION int16_out(int16) RETURNS cstring
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_out';

CREATE FUNCTION int16_recv(internal) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_recv';

CREATE FUNCTION int16_send(int16) RETURNS bytea
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_send';

CREATE TYPE int16 (
    INPUT = int16_in,
    OUTPUT = int16_out,
    RECEIVE = int16_recv,
    SEND = int16_send,
    INTERNALLENGTH = 16,
    --PASSEDBYVALUE,
    ALIGNMENT = char
);


-- Inout casts block

CREATE CAST (double precision AS int16) WITH INOUT AS ASSIGNMENT;
CREATE CAST (int16 AS double precision) WITH INOUT AS IMPLICIT;

CREATE CAST (numeric AS int16) WITH INOUT AS ASSIGNMENT;
CREATE CAST (int16 AS numeric) WITH INOUT AS IMPLICIT;

CREATE CAST (real AS int16) WITH INOUT AS ASSIGNMENT;
CREATE CAST (int16 AS real) WITH INOUT AS IMPLICIT;


-- Casts block

CREATE FUNCTION int16_from_int2(int2) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_from_int2';

CREATE FUNCTION int16_to_int2(int16) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_to_int2';

CREATE CAST (int2 AS int16) WITH FUNCTION int16_from_int2(int2) AS IMPLICIT;
CREATE CAST (int16 AS int2) WITH FUNCTION int16_to_int2(int16) AS IMPLICIT;


CREATE FUNCTION int16_from_int4(int4) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_from_int4';

CREATE FUNCTION int16_to_int4(int16) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_to_int4';

CREATE CAST (int4 AS int16) WITH FUNCTION int16_from_int4(int4) AS IMPLICIT;
CREATE CAST (int16 AS int4) WITH FUNCTION int16_to_int4(int16) AS IMPLICIT;


CREATE FUNCTION int16_from_int8(int8) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_from_int8';

CREATE FUNCTION int16_to_int8(int16) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_to_int8';

CREATE CAST (int8 AS int16) WITH FUNCTION int16_from_int8(int8) AS IMPLICIT;
CREATE CAST (int16 AS int8) WITH FUNCTION int16_to_int8(int16) AS IMPLICIT;

-- Ops block

CREATE FUNCTION int16_eq_int16(int16, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_eq_int16';

CREATE FUNCTION int16_eq_int2(int16, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_eq_int2';

CREATE FUNCTION int2_eq_int16(int2, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_eq_int16';

CREATE FUNCTION int16_eq_int4(int16, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_eq_int4';

CREATE FUNCTION int4_eq_int16(int4, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_eq_int16';

CREATE FUNCTION int16_eq_int8(int16, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_eq_int8';

CREATE FUNCTION int8_eq_int16(int8, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_eq_int16';


CREATE FUNCTION int16_ne_int16(int16, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ne_int16';

CREATE FUNCTION int16_ne_int2(int16, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ne_int2';

CREATE FUNCTION int2_ne_int16(int2, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_ne_int16';

CREATE FUNCTION int16_ne_int4(int16, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ne_int4';

CREATE FUNCTION int4_ne_int16(int4, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_ne_int16';

CREATE FUNCTION int16_ne_int8(int16, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ne_int8';

CREATE FUNCTION int8_ne_int16(int8, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_ne_int16';


CREATE FUNCTION int16_gt_int16(int16, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_gt_int16';

CREATE FUNCTION int16_gt_int2(int16, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_gt_int2';

CREATE FUNCTION int2_gt_int16(int2, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_gt_int16';

CREATE FUNCTION int16_gt_int4(int16, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_gt_int4';

CREATE FUNCTION int4_gt_int16(int4, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_gt_int16';

CREATE FUNCTION int16_gt_int8(int16, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_gt_int8';

CREATE FUNCTION int8_gt_int16(int8, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_gt_int16';


CREATE FUNCTION int16_lt_int16(int16, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_lt_int16';

CREATE FUNCTION int16_lt_int2(int16, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_lt_int2';

CREATE FUNCTION int2_lt_int16(int2, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_lt_int16';

CREATE FUNCTION int16_lt_int4(int16, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_lt_int4';

CREATE FUNCTION int4_lt_int16(int4, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_lt_int16';

CREATE FUNCTION int16_lt_int8(int16, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_lt_int8';

CREATE FUNCTION int8_lt_int16(int8, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_lt_int16';


CREATE FUNCTION int16_ge_int16(int16, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ge_int16';

CREATE FUNCTION int16_ge_int2(int16, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ge_int2';

CREATE FUNCTION int2_ge_int16(int2, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_ge_int16';

CREATE FUNCTION int16_ge_int4(int16, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ge_int4';

CREATE FUNCTION int4_ge_int16(int4, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_ge_int16';

CREATE FUNCTION int16_ge_int8(int16, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ge_int8';

CREATE FUNCTION int8_ge_int16(int8, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_ge_int16';


CREATE FUNCTION int16_le_int16(int16, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_le_int16';

CREATE FUNCTION int16_le_int2(int16, int2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_le_int2';

CREATE FUNCTION int2_le_int16(int2, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int2_le_int16';

CREATE FUNCTION int16_le_int4(int16, int4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_le_int4';

CREATE FUNCTION int4_le_int16(int4, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int4_le_int16';

CREATE FUNCTION int16_le_int8(int16, int8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_le_int8';

CREATE FUNCTION int8_le_int16(int8, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int8_le_int16';


CREATE FUNCTION int16_add_int16(int16, int16) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_add_int16';

CREATE FUNCTION int16_add_int2(int16, int2) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_add_int2';

CREATE FUNCTION int2_add_int16(int2, int16) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_add_int16';

CREATE FUNCTION int16_add_int4(int16, int4) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_add_int4';

CREATE FUNCTION int4_add_int16(int4, int16) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_add_int16';

CREATE FUNCTION int16_add_int8(int16, int8) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_add_int8';

CREATE FUNCTION int8_add_int16(int8, int16) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_add_int16';


CREATE FUNCTION int16_sub_int16(int16, int16) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_sub_int16';

CREATE FUNCTION int16_sub_int2(int16, int2) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_sub_int2';

CREATE FUNCTION int2_sub_int16(int2, int16) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_sub_int16';

CREATE FUNCTION int16_sub_int4(int16, int4) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_sub_int4';

CREATE FUNCTION int4_sub_int16(int4, int16) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_sub_int16';

CREATE FUNCTION int16_sub_int8(int16, int8) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_sub_int8';

CREATE FUNCTION int8_sub_int16(int8, int16) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_sub_int16';


CREATE FUNCTION int16_mul_int16(int16, int16) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mul_int16';

CREATE FUNCTION int16_mul_int2(int16, int2) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mul_int2';

CREATE FUNCTION int2_mul_int16(int2, int16) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_mul_int16';

CREATE FUNCTION int16_mul_int4(int16, int4) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mul_int4';

CREATE FUNCTION int4_mul_int16(int4, int16) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_mul_int16';

CREATE FUNCTION int16_mul_int8(int16, int8) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mul_int8';

CREATE FUNCTION int8_mul_int16(int8, int16) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_mul_int16';


CREATE FUNCTION int16_div_int16(int16, int16) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_div_int16';

CREATE FUNCTION int16_div_int2(int16, int2) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_div_int2';

CREATE FUNCTION int2_div_int16(int2, int16) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_div_int16';

CREATE FUNCTION int16_div_int4(int16, int4) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_div_int4';

CREATE FUNCTION int4_div_int16(int4, int16) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_div_int16';

CREATE FUNCTION int16_div_int8(int16, int8) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_div_int8';

CREATE FUNCTION int8_div_int16(int8, int16) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_div_int16';


CREATE FUNCTION int16_mod_int16(int16, int16) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mod_int16';

CREATE FUNCTION int16_mod_int2(int16, int2) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mod_int2';

CREATE FUNCTION int2_mod_int16(int2, int16) RETURNS int2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_mod_int16';

CREATE FUNCTION int16_mod_int4(int16, int4) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mod_int4';

CREATE FUNCTION int4_mod_int16(int4, int16) RETURNS int4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_mod_int16';

CREATE FUNCTION int16_mod_int8(int16, int8) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mod_int8';

CREATE FUNCTION int8_mod_int16(int8, int16) RETURNS int8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_mod_int16';


CREATE FUNCTION int16_xor(int16, int16) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_xor';


CREATE FUNCTION int16_and(int16, int16) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_and';


CREATE FUNCTION int16_or(int16, int16) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_or';


CREATE FUNCTION int16_not(int16) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_not';

CREATE FUNCTION int16_shl(int16, int4) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_shl';


CREATE FUNCTION int16_shr(int16, int4) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_shr';


CREATE OPERATOR = (
    LEFTARG=int16,
    RIGHTARG=int16,
    PROCEDURE=int16_eq_int16,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int16,
    RIGHTARG=int2,
    PROCEDURE=int16_eq_int2,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int2,
    RIGHTARG=int16,
    PROCEDURE=int2_eq_int16,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int16,
    RIGHTARG=int4,
    PROCEDURE=int16_eq_int4,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int4,
    RIGHTARG=int16,
    PROCEDURE=int4_eq_int16,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int16,
    RIGHTARG=int8,
    PROCEDURE=int16_eq_int8,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int8,
    RIGHTARG=int16,
    PROCEDURE=int8_eq_int16,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR <> (
    LEFTARG=int16,
    RIGHTARG=int16,
    PROCEDURE=int16_ne_int16,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int16,
    RIGHTARG=int2,
    PROCEDURE=int16_ne_int2,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int2,
    RIGHTARG=int16,
    PROCEDURE=int2_ne_int16,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int16,
    RIGHTARG=int4,
    PROCEDURE=int16_ne_int4,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int4,
    RIGHTARG=int16,
    PROCEDURE=int4_ne_int16,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int16,
    RIGHTARG=int8,
    PROCEDURE=int16_ne_int8,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int8,
    RIGHTARG=int16,
    PROCEDURE=int8_ne_int16,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR > (
    LEFTARG=int16,
    RIGHTARG=int16,
    PROCEDURE=int16_gt_int16,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int16,
    RIGHTARG=int2,
    PROCEDURE=int16_gt_int2,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int2,
    RIGHTARG=int16,
    PROCEDURE=int2_gt_int16,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int16,
    RIGHTARG=int4,
    PROCEDURE=int16_gt_int4,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int4,
    RIGHTARG=int16,
    PROCEDURE=int4_gt_int16,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int16,
    RIGHTARG=int8,
    PROCEDURE=int16_gt_int8,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int8,
    RIGHTARG=int16,
    PROCEDURE=int8_gt_int16,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR < (
    LEFTARG=int16,
    RIGHTARG=int16,
    PROCEDURE=int16_lt_int16,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int16,
    RIGHTARG=int2,
    PROCEDURE=int16_lt_int2,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int2,
    RIGHTARG=int16,
    PROCEDURE=int2_lt_int16,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int16,
    RIGHTARG=int4,
    PROCEDURE=int16_lt_int4,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int4,
    RIGHTARG=int16,
    PROCEDURE=int4_lt_int16,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int16,
    RIGHTARG=int8,
    PROCEDURE=int16_lt_int8,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int8,
    RIGHTARG=int16,
    PROCEDURE=int8_lt_int16,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR >= (
    LEFTARG=int16,
    RIGHTARG=int16,
    PROCEDURE=int16_ge_int16,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int16,
    RIGHTARG=int2,
    PROCEDURE=int16_ge_int2,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int2,
    RIGHTARG=int16,
    PROCEDURE=int2_ge_int16,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int16,
    RIGHTARG=int4,
    PROCEDURE=int16_ge_int4,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int4,
    RIGHTARG=int16,
    PROCEDURE=int4_ge_int16,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int16,
    RIGHTARG=int8,
    PROCEDURE=int16_ge_int8,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int8,
    RIGHTARG=int16,
    PROCEDURE=int8_ge_int16,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR <= (
    LEFTARG=int16,
    RIGHTARG=int16,
    PROCEDURE=int16_le_int16,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int16,
    RIGHTARG=int2,
    PROCEDURE=int16_le_int2,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int2,
    RIGHTARG=int16,
    PROCEDURE=int2_le_int16,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int16,
    RIGHTARG=int4,
    PROCEDURE=int16_le_int4,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int4,
    RIGHTARG=int16,
    PROCEDURE=int4_le_int16,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int16,
    RIGHTARG=int8,
    PROCEDURE=int16_le_int8,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int8,
    RIGHTARG=int16,
    PROCEDURE=int8_le_int16,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR + (
    LEFTARG=int16,
    RIGHTARG=int16,
    PROCEDURE=int16_add_int16,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int16,
    RIGHTARG=int2,
    PROCEDURE=int16_add_int2,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int2,
    RIGHTARG=int16,
    PROCEDURE=int2_add_int16,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int16,
    RIGHTARG=int4,
    PROCEDURE=int16_add_int4,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int4,
    RIGHTARG=int16,
    PROCEDURE=int4_add_int16,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int16,
    RIGHTARG=int8,
    PROCEDURE=int16_add_int8,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int8,
    RIGHTARG=int16,
    PROCEDURE=int8_add_int16,
    COMMUTATOR = +
);


CREATE OPERATOR - (
    LEFTARG=int16,
    RIGHTARG=int16,
    PROCEDURE=int16_sub_int16,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int16,
    RIGHTARG=int2,
    PROCEDURE=int16_sub_int2,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int2,
    RIGHTARG=int16,
    PROCEDURE=int2_sub_int16,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int16,
    RIGHTARG=int4,
    PROCEDURE=int16_sub_int4,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int4,
    RIGHTARG=int16,
    PROCEDURE=int4_sub_int16,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int16,
    RIGHTARG=int8,
    PROCEDURE=int16_sub_int8,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int8,
    RIGHTARG=int16,
    PROCEDURE=int8_sub_int16,
    COMMUTATOR = -
);


CREATE OPERATOR * (
    LEFTARG=int16,
    RIGHTARG=int16,
    PROCEDURE=int16_mul_int16
);

CREATE OPERATOR * (
    LEFTARG=int16,
    RIGHTARG=int2,
    PROCEDURE=int16_mul_int2
);

CREATE OPERATOR * (
    LEFTARG=int2,
    RIGHTARG=int16,
    PROCEDURE=int2_mul_int16
);

CREATE OPERATOR * (
    LEFTARG=int16,
    RIGHTARG=int4,
    PROCEDURE=int16_mul_int4
);

CREATE OPERATOR * (
    LEFTARG=int4,
    RIGHTARG=int16,
    PROCEDURE=int4_mul_int16
);

CREATE OPERATOR * (
    LEFTARG=int16,
    RIGHTARG=int8,
    PROCEDURE=int16_mul_int8
);

CREATE OPERATOR * (
    LEFTARG=int8,
    RIGHTARG=int16,
    PROCEDURE=int8_mul_int16
);


CREATE OPERATOR / (
    LEFTARG=int16,
    RIGHTARG=int16,
    PROCEDURE=int16_div_int16
);

CREATE OPERATOR / (
    LEFTARG=int16,
    RIGHTARG=int2,
    PROCEDURE=int16_div_int2
);

CREATE OPERATOR / (
    LEFTARG=int2,
    RIGHTARG=int16,
    PROCEDURE=int2_div_int16
);

CREATE OPERATOR / (
    LEFTARG=int16,
    RIGHTARG=int4,
    PROCEDURE=int16_div_int4
);

CREATE OPERATOR / (
    LEFTARG=int4,
    RIGHTARG=int16,
    PROCEDURE=int4_div_int16
);

CREATE OPERATOR / (
    LEFTARG=int16,
    RIGHTARG=int8,
    PROCEDURE=int16_div_int8
);

CREATE OPERATOR / (
    LEFTARG=int8,
    RIGHTARG=int16,
    PROCEDURE=int8_div_int16
);


CREATE OPERATOR % (
    LEFTARG=int16,
    RIGHTARG=int16,
    PROCEDURE=int16_mod_int16
);

CREATE OPERATOR % (
    LEFTARG=int16,
    RIGHTARG=int2,
    PROCEDURE=int16_mod_int2
);

CREATE OPERATOR % (
    LEFTARG=int2,
    RIGHTARG=int16,
    PROCEDURE=int2_mod_int16
);

CREATE OPERATOR % (
    LEFTARG=int16,
    RIGHTARG=int4,
    PROCEDURE=int16_mod_int4
);

CREATE OPERATOR % (
    LEFTARG=int4,
    RIGHTARG=int16,
    PROCEDURE=int4_mod_int16
);

CREATE OPERATOR % (
    LEFTARG=int16,
    RIGHTARG=int8,
    PROCEDURE=int16_mod_int8
);

CREATE OPERATOR % (
    LEFTARG=int8,
    RIGHTARG=int16,
    PROCEDURE=int8_mod_int16
);


CREATE OPERATOR # (
    LEFTARG=int16,
    RIGHTARG=int16,
    PROCEDURE=int16_xor,
    COMMUTATOR = #
);


CREATE OPERATOR & (
    LEFTARG=int16,
    RIGHTARG=int16,
    PROCEDURE=int16_and,
    COMMUTATOR = &
);


CREATE OPERATOR | (
    LEFTARG=int16,
    RIGHTARG=int16,
    PROCEDURE=int16_or,
    COMMUTATOR = |
);


CREATE OPERATOR ~ (
    RIGHTARG=int16,
    PROCEDURE=int16_not
);


CREATE OPERATOR << (
    LEFTARG=int16,
    RIGHTARG=int4,
    PROCEDURE=int16_shl
);


CREATE OPERATOR >> (
    LEFTARG=int16,
    RIGHTARG=int4,
    PROCEDURE=int16_shr
);



-- Index ops block

CREATE FUNCTION int16_cmp(int16, int16) RETURNS int
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_cmp';

CREATE FUNCTION int16_hash(int16) RETURNS integer
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_hash';


CREATE OPERATOR CLASS int16_ops
DEFAULT FOR TYPE int16 USING btree FAMILY integer_ops AS
    OPERATOR 1 <,
    OPERATOR 2 <=,
    OPERATOR 3 =,
    OPERATOR 4 >=,
    OPERATOR 5 >,
    FUNCTION 1 int16_cmp(int16, int16)
;

CREATE OPERATOR CLASS int16_ops
DEFAULT FOR TYPE int16 USING hash FAMILY integer_ops AS
    OPERATOR        1       = ,
    FUNCTION        1       int16_hash(int16);

-- Agg ops block

-- Transition function for accumulating int16
CREATE FUNCTION int16_avg_accum(internal, int16)
RETURNS internal
AS '$libdir/uint128', 'int16_avg_accum'
LANGUAGE C IMMUTABLE PARALLEL SAFE;

-- Inverse transition function for accumulating int16
CREATE FUNCTION int16_avg_accum_inv(internal, int16)
RETURNS internal
AS '$libdir/uint128', 'int16_avg_accum_inv'
LANGUAGE C IMMUTABLE PARALLEL SAFE;

CREATE AGGREGATE sum(int16) (
    -- Transition function
    SFUNC = int16_avg_accum,
    -- Internal state type
    STYPE = internal,
    -- Internal state size
    SSPACE = 128,
    -- Final function to return the sum
    FINALFUNC = numeric_sum,
    -- Combine function for parallel aggregation
    COMBINEFUNC = numeric_avg_combine,
    -- Moving transition function
    MSFUNC = int16_avg_accum,
    -- Moving state type (same as STYPE)
    MSTYPE = internal,
    -- Moving inverse transition function
    MINVFUNC = int16_avg_accum_inv,
    -- Moving final function for windows
    MFINALFUNC = numeric_sum,
    -- Serialize function
    SERIALFUNC = numeric_avg_serialize,
    -- Deserialize function
    DESERIALFUNC = numeric_avg_deserialize,
    -- Aggregate is parallel safe
    PARALLEL = SAFE
);

CREATE AGGREGATE avg(int16) (
    -- Transition function
    SFUNC = int16_avg_accum,
    -- Internal state type
    STYPE = internal,
    -- Internal state size
    SSPACE = 128,
    -- Final function to return the sum
    FINALFUNC = numeric_avg,
    -- Combine function for parallel aggregation
    COMBINEFUNC = numeric_avg_combine,
    -- Moving transition function
    MSFUNC = int16_avg_accum,
    -- Moving state type (same as STYPE)
    MSTYPE = internal,
    -- Moving inverse transition function
    MINVFUNC = int16_avg_accum_inv,
    -- Moving final function for windows
    MFINALFUNC = numeric_avg,
    -- Serialize function
    SERIALFUNC = numeric_avg_serialize,
    -- Deserialize function
    DESERIALFUNC = numeric_avg_deserialize,
    -- Aggregate is parallel safe
    PARALLEL = SAFE
);

CREATE FUNCTION int16_smaller(int16, int16)
RETURNS int16
AS '$libdir/uint128', 'int16_smaller'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

CREATE AGGREGATE min(int16) (
    -- Transition function
    SFUNC = int16_smaller,         
	STYPE = int16,
	COMBINEFUNC = int16_smaller,
    SORTOP = <,
    PARALLEL = SAFE
);

CREATE FUNCTION int16_larger(int16, int16)
RETURNS int16
AS '$libdir/uint128', 'int16_larger'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

CREATE AGGREGATE max(int16) (
    -- Transition function
    SFUNC = int16_larger,         
	STYPE = int16,
	COMBINEFUNC = int16_larger,
    SORTOP = >,
    PARALLEL = SAFE
);


-- Generate series block

CREATE FUNCTION generate_series_int16_support(internal)
RETURNS internal
AS '$libdir/uint128', 'generate_series_int16_support'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT;

CREATE FUNCTION generate_series(int16, int16)
RETURNS SETOF int16
AS '$libdir/uint128', 'generate_series_int16'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT SUPPORT generate_series_int16_support;

CREATE FUNCTION generate_series(int16, int16, int16)
RETURNS SETOF int16
AS '$libdir/uint128', 'generate_series_step_int16'
LANGUAGE C IMMUTABLE PARALLEL SAFE STRICT SUPPORT generate_series_int16_support;




-- Cross types ops

-- Casts block

CREATE FUNCTION uint16_from_uint2(uint2) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_from_uint2';

CREATE FUNCTION uint16_to_uint2(uint16) RETURNS uint2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_to_uint2';

CREATE CAST (uint2 AS uint16) WITH FUNCTION uint16_from_uint2(uint2) AS IMPLICIT;
CREATE CAST (uint16 AS uint2) WITH FUNCTION uint16_to_uint2(uint16) AS IMPLICIT;


CREATE FUNCTION uint16_from_uint4(uint4) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_from_uint4';

CREATE FUNCTION uint16_to_uint4(uint16) RETURNS uint4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_to_uint4';

CREATE CAST (uint4 AS uint16) WITH FUNCTION uint16_from_uint4(uint4) AS IMPLICIT;
CREATE CAST (uint16 AS uint4) WITH FUNCTION uint16_to_uint4(uint16) AS IMPLICIT;


CREATE FUNCTION uint16_from_uint8(uint8) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_from_uint8';

CREATE FUNCTION uint16_to_uint8(uint16) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_to_uint8';

CREATE CAST (uint8 AS uint16) WITH FUNCTION uint16_from_uint8(uint8) AS IMPLICIT;
CREATE CAST (uint16 AS uint8) WITH FUNCTION uint16_to_uint8(uint16) AS IMPLICIT;


CREATE FUNCTION uint16_from_int16(int16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_from_int16';

CREATE FUNCTION uint16_to_int16(uint16) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_to_int16';

CREATE CAST (int16 AS uint16) WITH FUNCTION uint16_from_int16(int16) AS IMPLICIT;
CREATE CAST (uint16 AS int16) WITH FUNCTION uint16_to_int16(uint16) AS IMPLICIT;

-- Ops block

CREATE FUNCTION uint16_eq_uint2(uint16, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_eq_uint2';

CREATE FUNCTION uint16_eq_uint4(uint16, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_eq_uint4';

CREATE FUNCTION uint16_eq_uint8(uint16, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_eq_uint8';

CREATE FUNCTION uint16_eq_int16(uint16, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_eq_int16';


CREATE FUNCTION uint16_ne_uint2(uint16, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ne_uint2';

CREATE FUNCTION uint16_ne_uint4(uint16, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ne_uint4';

CREATE FUNCTION uint16_ne_uint8(uint16, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ne_uint8';

CREATE FUNCTION uint16_ne_int16(uint16, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ne_int16';


CREATE FUNCTION uint16_gt_uint2(uint16, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_gt_uint2';

CREATE FUNCTION uint16_gt_uint4(uint16, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_gt_uint4';

CREATE FUNCTION uint16_gt_uint8(uint16, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_gt_uint8';

CREATE FUNCTION uint16_gt_int16(uint16, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_gt_int16';


CREATE FUNCTION uint16_lt_uint2(uint16, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_lt_uint2';

CREATE FUNCTION uint16_lt_uint4(uint16, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_lt_uint4';

CREATE FUNCTION uint16_lt_uint8(uint16, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_lt_uint8';

CREATE FUNCTION uint16_lt_int16(uint16, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_lt_int16';


CREATE FUNCTION uint16_ge_uint2(uint16, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ge_uint2';

CREATE FUNCTION uint16_ge_uint4(uint16, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ge_uint4';

CREATE FUNCTION uint16_ge_uint8(uint16, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ge_uint8';

CREATE FUNCTION uint16_ge_int16(uint16, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ge_int16';


CREATE FUNCTION uint16_le_uint2(uint16, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_le_uint2';

CREATE FUNCTION uint16_le_uint4(uint16, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_le_uint4';

CREATE FUNCTION uint16_le_uint8(uint16, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_le_uint8';

CREATE FUNCTION uint16_le_int16(uint16, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_le_int16';


CREATE FUNCTION uint16_add_uint2(uint16, uint2) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_add_uint2';

CREATE FUNCTION uint16_add_uint4(uint16, uint4) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_add_uint4';

CREATE FUNCTION uint16_add_uint8(uint16, uint8) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_add_uint8';

CREATE FUNCTION uint16_add_int16(uint16, int16) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_add_int16';


CREATE FUNCTION uint16_sub_uint2(uint16, uint2) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_sub_uint2';

CREATE FUNCTION uint16_sub_uint4(uint16, uint4) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_sub_uint4';

CREATE FUNCTION uint16_sub_uint8(uint16, uint8) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_sub_uint8';

CREATE FUNCTION uint16_sub_int16(uint16, int16) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_sub_int16';


CREATE FUNCTION uint16_mul_uint2(uint16, uint2) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mul_uint2';

CREATE FUNCTION uint16_mul_uint4(uint16, uint4) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mul_uint4';

CREATE FUNCTION uint16_mul_uint8(uint16, uint8) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mul_uint8';

CREATE FUNCTION uint16_mul_int16(uint16, int16) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mul_int16';


CREATE FUNCTION uint16_div_uint2(uint16, uint2) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_div_uint2';

CREATE FUNCTION uint16_div_uint4(uint16, uint4) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_div_uint4';

CREATE FUNCTION uint16_div_uint8(uint16, uint8) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_div_uint8';

CREATE FUNCTION uint16_div_int16(uint16, int16) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_div_int16';


CREATE FUNCTION uint16_mod_uint2(uint16, uint2) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mod_uint2';

CREATE FUNCTION uint16_mod_uint4(uint16, uint4) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mod_uint4';

CREATE FUNCTION uint16_mod_uint8(uint16, uint8) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mod_uint8';

CREATE FUNCTION uint16_mod_int16(uint16, int16) RETURNS uint16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mod_int16';


CREATE OPERATOR = (
    LEFTARG=uint16,
    RIGHTARG=uint2,
    PROCEDURE=uint16_eq_uint2,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint16,
    RIGHTARG=uint4,
    PROCEDURE=uint16_eq_uint4,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint16,
    RIGHTARG=uint8,
    PROCEDURE=uint16_eq_uint8,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint16,
    RIGHTARG=int16,
    PROCEDURE=uint16_eq_int16,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR <> (
    LEFTARG=uint16,
    RIGHTARG=uint2,
    PROCEDURE=uint16_ne_uint2,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint16,
    RIGHTARG=uint4,
    PROCEDURE=uint16_ne_uint4,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint16,
    RIGHTARG=uint8,
    PROCEDURE=uint16_ne_uint8,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint16,
    RIGHTARG=int16,
    PROCEDURE=uint16_ne_int16,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR > (
    LEFTARG=uint16,
    RIGHTARG=uint2,
    PROCEDURE=uint16_gt_uint2,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint16,
    RIGHTARG=uint4,
    PROCEDURE=uint16_gt_uint4,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint16,
    RIGHTARG=uint8,
    PROCEDURE=uint16_gt_uint8,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint16,
    RIGHTARG=int16,
    PROCEDURE=uint16_gt_int16,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR < (
    LEFTARG=uint16,
    RIGHTARG=uint2,
    PROCEDURE=uint16_lt_uint2,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint16,
    RIGHTARG=uint4,
    PROCEDURE=uint16_lt_uint4,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint16,
    RIGHTARG=uint8,
    PROCEDURE=uint16_lt_uint8,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint16,
    RIGHTARG=int16,
    PROCEDURE=uint16_lt_int16,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR >= (
    LEFTARG=uint16,
    RIGHTARG=uint2,
    PROCEDURE=uint16_ge_uint2,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint16,
    RIGHTARG=uint4,
    PROCEDURE=uint16_ge_uint4,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint16,
    RIGHTARG=uint8,
    PROCEDURE=uint16_ge_uint8,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint16,
    RIGHTARG=int16,
    PROCEDURE=uint16_ge_int16,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR <= (
    LEFTARG=uint16,
    RIGHTARG=uint2,
    PROCEDURE=uint16_le_uint2,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint16,
    RIGHTARG=uint4,
    PROCEDURE=uint16_le_uint4,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint16,
    RIGHTARG=uint8,
    PROCEDURE=uint16_le_uint8,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint16,
    RIGHTARG=int16,
    PROCEDURE=uint16_le_int16,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR + (
    LEFTARG=uint16,
    RIGHTARG=uint2,
    PROCEDURE=uint16_add_uint2,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint16,
    RIGHTARG=uint4,
    PROCEDURE=uint16_add_uint4,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint16,
    RIGHTARG=uint8,
    PROCEDURE=uint16_add_uint8,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint16,
    RIGHTARG=int16,
    PROCEDURE=uint16_add_int16,
    COMMUTATOR = +
);


CREATE OPERATOR - (
    LEFTARG=uint16,
    RIGHTARG=uint2,
    PROCEDURE=uint16_sub_uint2,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint16,
    RIGHTARG=uint4,
    PROCEDURE=uint16_sub_uint4,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint16,
    RIGHTARG=uint8,
    PROCEDURE=uint16_sub_uint8,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint16,
    RIGHTARG=int16,
    PROCEDURE=uint16_sub_int16,
    COMMUTATOR = -
);


CREATE OPERATOR * (
    LEFTARG=uint16,
    RIGHTARG=uint2,
    PROCEDURE=uint16_mul_uint2
);

CREATE OPERATOR * (
    LEFTARG=uint16,
    RIGHTARG=uint4,
    PROCEDURE=uint16_mul_uint4
);

CREATE OPERATOR * (
    LEFTARG=uint16,
    RIGHTARG=uint8,
    PROCEDURE=uint16_mul_uint8
);

CREATE OPERATOR * (
    LEFTARG=uint16,
    RIGHTARG=int16,
    PROCEDURE=uint16_mul_int16
);


CREATE OPERATOR / (
    LEFTARG=uint16,
    RIGHTARG=uint2,
    PROCEDURE=uint16_div_uint2
);

CREATE OPERATOR / (
    LEFTARG=uint16,
    RIGHTARG=uint4,
    PROCEDURE=uint16_div_uint4
);

CREATE OPERATOR / (
    LEFTARG=uint16,
    RIGHTARG=uint8,
    PROCEDURE=uint16_div_uint8
);

CREATE OPERATOR / (
    LEFTARG=uint16,
    RIGHTARG=int16,
    PROCEDURE=uint16_div_int16
);


CREATE OPERATOR % (
    LEFTARG=uint16,
    RIGHTARG=uint2,
    PROCEDURE=uint16_mod_uint2
);

CREATE OPERATOR % (
    LEFTARG=uint16,
    RIGHTARG=uint4,
    PROCEDURE=uint16_mod_uint4
);

CREATE OPERATOR % (
    LEFTARG=uint16,
    RIGHTARG=uint8,
    PROCEDURE=uint16_mod_uint8
);

CREATE OPERATOR % (
    LEFTARG=uint16,
    RIGHTARG=int16,
    PROCEDURE=uint16_mod_int16
);






-- Casts block

CREATE FUNCTION uint8_from_uint2(uint2) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_from_uint2';

CREATE FUNCTION uint8_to_uint2(uint8) RETURNS uint2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_to_uint2';

CREATE CAST (uint2 AS uint8) WITH FUNCTION uint8_from_uint2(uint2) AS IMPLICIT;
CREATE CAST (uint8 AS uint2) WITH FUNCTION uint8_to_uint2(uint8) AS IMPLICIT;


CREATE FUNCTION uint8_from_uint4(uint4) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_from_uint4';

CREATE FUNCTION uint8_to_uint4(uint8) RETURNS uint4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_to_uint4';

CREATE CAST (uint4 AS uint8) WITH FUNCTION uint8_from_uint4(uint4) AS IMPLICIT;
CREATE CAST (uint8 AS uint4) WITH FUNCTION uint8_to_uint4(uint8) AS IMPLICIT;


CREATE FUNCTION uint8_from_int16(int16) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_from_int16';

CREATE FUNCTION uint8_to_int16(uint8) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_to_int16';

CREATE CAST (int16 AS uint8) WITH FUNCTION uint8_from_int16(int16) AS IMPLICIT;
CREATE CAST (uint8 AS int16) WITH FUNCTION uint8_to_int16(uint8) AS IMPLICIT;

-- Ops block

CREATE FUNCTION uint8_eq_uint2(uint8, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_eq_uint2';

CREATE FUNCTION uint8_eq_uint4(uint8, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_eq_uint4';

CREATE FUNCTION uint8_eq_uint16(uint8, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_eq_uint16';

CREATE FUNCTION uint8_eq_int16(uint8, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_eq_int16';


CREATE FUNCTION uint8_ne_uint2(uint8, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ne_uint2';

CREATE FUNCTION uint8_ne_uint4(uint8, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ne_uint4';

CREATE FUNCTION uint8_ne_uint16(uint8, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ne_uint16';

CREATE FUNCTION uint8_ne_int16(uint8, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ne_int16';


CREATE FUNCTION uint8_gt_uint2(uint8, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_gt_uint2';

CREATE FUNCTION uint8_gt_uint4(uint8, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_gt_uint4';

CREATE FUNCTION uint8_gt_uint16(uint8, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_gt_uint16';

CREATE FUNCTION uint8_gt_int16(uint8, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_gt_int16';


CREATE FUNCTION uint8_lt_uint2(uint8, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_lt_uint2';

CREATE FUNCTION uint8_lt_uint4(uint8, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_lt_uint4';

CREATE FUNCTION uint8_lt_uint16(uint8, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_lt_uint16';

CREATE FUNCTION uint8_lt_int16(uint8, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_lt_int16';


CREATE FUNCTION uint8_ge_uint2(uint8, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ge_uint2';

CREATE FUNCTION uint8_ge_uint4(uint8, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ge_uint4';

CREATE FUNCTION uint8_ge_uint16(uint8, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ge_uint16';

CREATE FUNCTION uint8_ge_int16(uint8, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ge_int16';


CREATE FUNCTION uint8_le_uint2(uint8, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_le_uint2';

CREATE FUNCTION uint8_le_uint4(uint8, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_le_uint4';

CREATE FUNCTION uint8_le_uint16(uint8, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_le_uint16';

CREATE FUNCTION uint8_le_int16(uint8, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_le_int16';


CREATE FUNCTION uint8_add_uint2(uint8, uint2) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_add_uint2';

CREATE FUNCTION uint8_add_uint4(uint8, uint4) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_add_uint4';

CREATE FUNCTION uint8_add_uint16(uint8, uint16) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_add_uint16';

CREATE FUNCTION uint8_add_int16(uint8, int16) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_add_int16';


CREATE FUNCTION uint8_sub_uint2(uint8, uint2) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_sub_uint2';

CREATE FUNCTION uint8_sub_uint4(uint8, uint4) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_sub_uint4';

CREATE FUNCTION uint8_sub_uint16(uint8, uint16) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_sub_uint16';

CREATE FUNCTION uint8_sub_int16(uint8, int16) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_sub_int16';


CREATE FUNCTION uint8_mul_uint2(uint8, uint2) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mul_uint2';

CREATE FUNCTION uint8_mul_uint4(uint8, uint4) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mul_uint4';

CREATE FUNCTION uint8_mul_uint16(uint8, uint16) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mul_uint16';

CREATE FUNCTION uint8_mul_int16(uint8, int16) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mul_int16';


CREATE FUNCTION uint8_div_uint2(uint8, uint2) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_div_uint2';

CREATE FUNCTION uint8_div_uint4(uint8, uint4) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_div_uint4';

CREATE FUNCTION uint8_div_uint16(uint8, uint16) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_div_uint16';

CREATE FUNCTION uint8_div_int16(uint8, int16) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_div_int16';


CREATE FUNCTION uint8_mod_uint2(uint8, uint2) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mod_uint2';

CREATE FUNCTION uint8_mod_uint4(uint8, uint4) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mod_uint4';

CREATE FUNCTION uint8_mod_uint16(uint8, uint16) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mod_uint16';

CREATE FUNCTION uint8_mod_int16(uint8, int16) RETURNS uint8
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mod_int16';


CREATE OPERATOR = (
    LEFTARG=uint8,
    RIGHTARG=uint2,
    PROCEDURE=uint8_eq_uint2,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint8,
    RIGHTARG=uint4,
    PROCEDURE=uint8_eq_uint4,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint8,
    RIGHTARG=uint16,
    PROCEDURE=uint8_eq_uint16,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint8,
    RIGHTARG=int16,
    PROCEDURE=uint8_eq_int16,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR <> (
    LEFTARG=uint8,
    RIGHTARG=uint2,
    PROCEDURE=uint8_ne_uint2,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint8,
    RIGHTARG=uint4,
    PROCEDURE=uint8_ne_uint4,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint8,
    RIGHTARG=uint16,
    PROCEDURE=uint8_ne_uint16,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint8,
    RIGHTARG=int16,
    PROCEDURE=uint8_ne_int16,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR > (
    LEFTARG=uint8,
    RIGHTARG=uint2,
    PROCEDURE=uint8_gt_uint2,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint8,
    RIGHTARG=uint4,
    PROCEDURE=uint8_gt_uint4,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint8,
    RIGHTARG=uint16,
    PROCEDURE=uint8_gt_uint16,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint8,
    RIGHTARG=int16,
    PROCEDURE=uint8_gt_int16,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR < (
    LEFTARG=uint8,
    RIGHTARG=uint2,
    PROCEDURE=uint8_lt_uint2,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint8,
    RIGHTARG=uint4,
    PROCEDURE=uint8_lt_uint4,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint8,
    RIGHTARG=uint16,
    PROCEDURE=uint8_lt_uint16,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint8,
    RIGHTARG=int16,
    PROCEDURE=uint8_lt_int16,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR >= (
    LEFTARG=uint8,
    RIGHTARG=uint2,
    PROCEDURE=uint8_ge_uint2,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint8,
    RIGHTARG=uint4,
    PROCEDURE=uint8_ge_uint4,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint8,
    RIGHTARG=uint16,
    PROCEDURE=uint8_ge_uint16,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint8,
    RIGHTARG=int16,
    PROCEDURE=uint8_ge_int16,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR <= (
    LEFTARG=uint8,
    RIGHTARG=uint2,
    PROCEDURE=uint8_le_uint2,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint8,
    RIGHTARG=uint4,
    PROCEDURE=uint8_le_uint4,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint8,
    RIGHTARG=uint16,
    PROCEDURE=uint8_le_uint16,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint8,
    RIGHTARG=int16,
    PROCEDURE=uint8_le_int16,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR + (
    LEFTARG=uint8,
    RIGHTARG=uint2,
    PROCEDURE=uint8_add_uint2,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint8,
    RIGHTARG=uint4,
    PROCEDURE=uint8_add_uint4,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint8,
    RIGHTARG=uint16,
    PROCEDURE=uint8_add_uint16,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint8,
    RIGHTARG=int16,
    PROCEDURE=uint8_add_int16,
    COMMUTATOR = +
);


CREATE OPERATOR - (
    LEFTARG=uint8,
    RIGHTARG=uint2,
    PROCEDURE=uint8_sub_uint2,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint8,
    RIGHTARG=uint4,
    PROCEDURE=uint8_sub_uint4,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint8,
    RIGHTARG=uint16,
    PROCEDURE=uint8_sub_uint16,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint8,
    RIGHTARG=int16,
    PROCEDURE=uint8_sub_int16,
    COMMUTATOR = -
);


CREATE OPERATOR * (
    LEFTARG=uint8,
    RIGHTARG=uint2,
    PROCEDURE=uint8_mul_uint2
);

CREATE OPERATOR * (
    LEFTARG=uint8,
    RIGHTARG=uint4,
    PROCEDURE=uint8_mul_uint4
);

CREATE OPERATOR * (
    LEFTARG=uint8,
    RIGHTARG=uint16,
    PROCEDURE=uint8_mul_uint16
);

CREATE OPERATOR * (
    LEFTARG=uint8,
    RIGHTARG=int16,
    PROCEDURE=uint8_mul_int16
);


CREATE OPERATOR / (
    LEFTARG=uint8,
    RIGHTARG=uint2,
    PROCEDURE=uint8_div_uint2
);

CREATE OPERATOR / (
    LEFTARG=uint8,
    RIGHTARG=uint4,
    PROCEDURE=uint8_div_uint4
);

CREATE OPERATOR / (
    LEFTARG=uint8,
    RIGHTARG=uint16,
    PROCEDURE=uint8_div_uint16
);

CREATE OPERATOR / (
    LEFTARG=uint8,
    RIGHTARG=int16,
    PROCEDURE=uint8_div_int16
);


CREATE OPERATOR % (
    LEFTARG=uint8,
    RIGHTARG=uint2,
    PROCEDURE=uint8_mod_uint2
);

CREATE OPERATOR % (
    LEFTARG=uint8,
    RIGHTARG=uint4,
    PROCEDURE=uint8_mod_uint4
);

CREATE OPERATOR % (
    LEFTARG=uint8,
    RIGHTARG=uint16,
    PROCEDURE=uint8_mod_uint16
);

CREATE OPERATOR % (
    LEFTARG=uint8,
    RIGHTARG=int16,
    PROCEDURE=uint8_mod_int16
);






-- Casts block

CREATE FUNCTION uint4_from_uint2(uint2) RETURNS uint4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_from_uint2';

CREATE FUNCTION uint4_to_uint2(uint4) RETURNS uint2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_to_uint2';

CREATE CAST (uint2 AS uint4) WITH FUNCTION uint4_from_uint2(uint2) AS IMPLICIT;
CREATE CAST (uint4 AS uint2) WITH FUNCTION uint4_to_uint2(uint4) AS IMPLICIT;


CREATE FUNCTION uint4_from_int16(int16) RETURNS uint4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_from_int16';

CREATE FUNCTION uint4_to_int16(uint4) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_to_int16';

CREATE CAST (int16 AS uint4) WITH FUNCTION uint4_from_int16(int16) AS IMPLICIT;
CREATE CAST (uint4 AS int16) WITH FUNCTION uint4_to_int16(uint4) AS IMPLICIT;

-- Ops block

CREATE FUNCTION uint4_eq_uint2(uint4, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_eq_uint2';

CREATE FUNCTION uint4_eq_uint8(uint4, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_eq_uint8';

CREATE FUNCTION uint4_eq_uint16(uint4, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_eq_uint16';

CREATE FUNCTION uint4_eq_int16(uint4, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_eq_int16';


CREATE FUNCTION uint4_ne_uint2(uint4, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_ne_uint2';

CREATE FUNCTION uint4_ne_uint8(uint4, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_ne_uint8';

CREATE FUNCTION uint4_ne_uint16(uint4, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_ne_uint16';

CREATE FUNCTION uint4_ne_int16(uint4, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_ne_int16';


CREATE FUNCTION uint4_gt_uint2(uint4, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_gt_uint2';

CREATE FUNCTION uint4_gt_uint8(uint4, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_gt_uint8';

CREATE FUNCTION uint4_gt_uint16(uint4, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_gt_uint16';

CREATE FUNCTION uint4_gt_int16(uint4, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_gt_int16';


CREATE FUNCTION uint4_lt_uint2(uint4, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_lt_uint2';

CREATE FUNCTION uint4_lt_uint8(uint4, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_lt_uint8';

CREATE FUNCTION uint4_lt_uint16(uint4, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_lt_uint16';

CREATE FUNCTION uint4_lt_int16(uint4, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_lt_int16';


CREATE FUNCTION uint4_ge_uint2(uint4, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_ge_uint2';

CREATE FUNCTION uint4_ge_uint8(uint4, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_ge_uint8';

CREATE FUNCTION uint4_ge_uint16(uint4, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_ge_uint16';

CREATE FUNCTION uint4_ge_int16(uint4, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_ge_int16';


CREATE FUNCTION uint4_le_uint2(uint4, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_le_uint2';

CREATE FUNCTION uint4_le_uint8(uint4, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_le_uint8';

CREATE FUNCTION uint4_le_uint16(uint4, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_le_uint16';

CREATE FUNCTION uint4_le_int16(uint4, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_le_int16';


CREATE FUNCTION uint4_add_uint2(uint4, uint2) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_add_uint2';

CREATE FUNCTION uint4_add_uint8(uint4, uint8) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_add_uint8';

CREATE FUNCTION uint4_add_uint16(uint4, uint16) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_add_uint16';

CREATE FUNCTION uint4_add_int16(uint4, int16) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_add_int16';


CREATE FUNCTION uint4_sub_uint2(uint4, uint2) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_sub_uint2';

CREATE FUNCTION uint4_sub_uint8(uint4, uint8) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_sub_uint8';

CREATE FUNCTION uint4_sub_uint16(uint4, uint16) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_sub_uint16';

CREATE FUNCTION uint4_sub_int16(uint4, int16) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_sub_int16';


CREATE FUNCTION uint4_mul_uint2(uint4, uint2) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_mul_uint2';

CREATE FUNCTION uint4_mul_uint8(uint4, uint8) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_mul_uint8';

CREATE FUNCTION uint4_mul_uint16(uint4, uint16) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_mul_uint16';

CREATE FUNCTION uint4_mul_int16(uint4, int16) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_mul_int16';


CREATE FUNCTION uint4_div_uint2(uint4, uint2) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_div_uint2';

CREATE FUNCTION uint4_div_uint8(uint4, uint8) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_div_uint8';

CREATE FUNCTION uint4_div_uint16(uint4, uint16) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_div_uint16';

CREATE FUNCTION uint4_div_int16(uint4, int16) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_div_int16';


CREATE FUNCTION uint4_mod_uint2(uint4, uint2) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_mod_uint2';

CREATE FUNCTION uint4_mod_uint8(uint4, uint8) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_mod_uint8';

CREATE FUNCTION uint4_mod_uint16(uint4, uint16) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_mod_uint16';

CREATE FUNCTION uint4_mod_int16(uint4, int16) RETURNS uint4
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint4_mod_int16';


CREATE OPERATOR = (
    LEFTARG=uint4,
    RIGHTARG=uint2,
    PROCEDURE=uint4_eq_uint2,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint4,
    RIGHTARG=uint8,
    PROCEDURE=uint4_eq_uint8,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint4,
    RIGHTARG=uint16,
    PROCEDURE=uint4_eq_uint16,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint4,
    RIGHTARG=int16,
    PROCEDURE=uint4_eq_int16,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR <> (
    LEFTARG=uint4,
    RIGHTARG=uint2,
    PROCEDURE=uint4_ne_uint2,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint4,
    RIGHTARG=uint8,
    PROCEDURE=uint4_ne_uint8,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint4,
    RIGHTARG=uint16,
    PROCEDURE=uint4_ne_uint16,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint4,
    RIGHTARG=int16,
    PROCEDURE=uint4_ne_int16,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR > (
    LEFTARG=uint4,
    RIGHTARG=uint2,
    PROCEDURE=uint4_gt_uint2,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint4,
    RIGHTARG=uint8,
    PROCEDURE=uint4_gt_uint8,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint4,
    RIGHTARG=uint16,
    PROCEDURE=uint4_gt_uint16,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint4,
    RIGHTARG=int16,
    PROCEDURE=uint4_gt_int16,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR < (
    LEFTARG=uint4,
    RIGHTARG=uint2,
    PROCEDURE=uint4_lt_uint2,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint4,
    RIGHTARG=uint8,
    PROCEDURE=uint4_lt_uint8,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint4,
    RIGHTARG=uint16,
    PROCEDURE=uint4_lt_uint16,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint4,
    RIGHTARG=int16,
    PROCEDURE=uint4_lt_int16,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR >= (
    LEFTARG=uint4,
    RIGHTARG=uint2,
    PROCEDURE=uint4_ge_uint2,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint4,
    RIGHTARG=uint8,
    PROCEDURE=uint4_ge_uint8,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint4,
    RIGHTARG=uint16,
    PROCEDURE=uint4_ge_uint16,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint4,
    RIGHTARG=int16,
    PROCEDURE=uint4_ge_int16,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR <= (
    LEFTARG=uint4,
    RIGHTARG=uint2,
    PROCEDURE=uint4_le_uint2,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint4,
    RIGHTARG=uint8,
    PROCEDURE=uint4_le_uint8,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint4,
    RIGHTARG=uint16,
    PROCEDURE=uint4_le_uint16,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint4,
    RIGHTARG=int16,
    PROCEDURE=uint4_le_int16,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR + (
    LEFTARG=uint4,
    RIGHTARG=uint2,
    PROCEDURE=uint4_add_uint2,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint4,
    RIGHTARG=uint8,
    PROCEDURE=uint4_add_uint8,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint4,
    RIGHTARG=uint16,
    PROCEDURE=uint4_add_uint16,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint4,
    RIGHTARG=int16,
    PROCEDURE=uint4_add_int16,
    COMMUTATOR = +
);


CREATE OPERATOR - (
    LEFTARG=uint4,
    RIGHTARG=uint2,
    PROCEDURE=uint4_sub_uint2,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint4,
    RIGHTARG=uint8,
    PROCEDURE=uint4_sub_uint8,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint4,
    RIGHTARG=uint16,
    PROCEDURE=uint4_sub_uint16,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint4,
    RIGHTARG=int16,
    PROCEDURE=uint4_sub_int16,
    COMMUTATOR = -
);


CREATE OPERATOR * (
    LEFTARG=uint4,
    RIGHTARG=uint2,
    PROCEDURE=uint4_mul_uint2
);

CREATE OPERATOR * (
    LEFTARG=uint4,
    RIGHTARG=uint8,
    PROCEDURE=uint4_mul_uint8
);

CREATE OPERATOR * (
    LEFTARG=uint4,
    RIGHTARG=uint16,
    PROCEDURE=uint4_mul_uint16
);

CREATE OPERATOR * (
    LEFTARG=uint4,
    RIGHTARG=int16,
    PROCEDURE=uint4_mul_int16
);


CREATE OPERATOR / (
    LEFTARG=uint4,
    RIGHTARG=uint2,
    PROCEDURE=uint4_div_uint2
);

CREATE OPERATOR / (
    LEFTARG=uint4,
    RIGHTARG=uint8,
    PROCEDURE=uint4_div_uint8
);

CREATE OPERATOR / (
    LEFTARG=uint4,
    RIGHTARG=uint16,
    PROCEDURE=uint4_div_uint16
);

CREATE OPERATOR / (
    LEFTARG=uint4,
    RIGHTARG=int16,
    PROCEDURE=uint4_div_int16
);


CREATE OPERATOR % (
    LEFTARG=uint4,
    RIGHTARG=uint2,
    PROCEDURE=uint4_mod_uint2
);

CREATE OPERATOR % (
    LEFTARG=uint4,
    RIGHTARG=uint8,
    PROCEDURE=uint4_mod_uint8
);

CREATE OPERATOR % (
    LEFTARG=uint4,
    RIGHTARG=uint16,
    PROCEDURE=uint4_mod_uint16
);

CREATE OPERATOR % (
    LEFTARG=uint4,
    RIGHTARG=int16,
    PROCEDURE=uint4_mod_int16
);






-- Casts block

CREATE FUNCTION uint2_from_int16(int16) RETURNS uint2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_from_int16';

CREATE FUNCTION uint2_to_int16(uint2) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_to_int16';

CREATE CAST (int16 AS uint2) WITH FUNCTION uint2_from_int16(int16) AS IMPLICIT;
CREATE CAST (uint2 AS int16) WITH FUNCTION uint2_to_int16(uint2) AS IMPLICIT;

-- Ops block

CREATE FUNCTION uint2_eq_uint4(uint2, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_eq_uint4';

CREATE FUNCTION uint2_eq_uint8(uint2, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_eq_uint8';

CREATE FUNCTION uint2_eq_uint16(uint2, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_eq_uint16';

CREATE FUNCTION uint2_eq_int16(uint2, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_eq_int16';


CREATE FUNCTION uint2_ne_uint4(uint2, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_ne_uint4';

CREATE FUNCTION uint2_ne_uint8(uint2, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_ne_uint8';

CREATE FUNCTION uint2_ne_uint16(uint2, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_ne_uint16';

CREATE FUNCTION uint2_ne_int16(uint2, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_ne_int16';


CREATE FUNCTION uint2_gt_uint4(uint2, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_gt_uint4';

CREATE FUNCTION uint2_gt_uint8(uint2, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_gt_uint8';

CREATE FUNCTION uint2_gt_uint16(uint2, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_gt_uint16';

CREATE FUNCTION uint2_gt_int16(uint2, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_gt_int16';


CREATE FUNCTION uint2_lt_uint4(uint2, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_lt_uint4';

CREATE FUNCTION uint2_lt_uint8(uint2, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_lt_uint8';

CREATE FUNCTION uint2_lt_uint16(uint2, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_lt_uint16';

CREATE FUNCTION uint2_lt_int16(uint2, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_lt_int16';


CREATE FUNCTION uint2_ge_uint4(uint2, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_ge_uint4';

CREATE FUNCTION uint2_ge_uint8(uint2, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_ge_uint8';

CREATE FUNCTION uint2_ge_uint16(uint2, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_ge_uint16';

CREATE FUNCTION uint2_ge_int16(uint2, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_ge_int16';


CREATE FUNCTION uint2_le_uint4(uint2, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_le_uint4';

CREATE FUNCTION uint2_le_uint8(uint2, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_le_uint8';

CREATE FUNCTION uint2_le_uint16(uint2, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_le_uint16';

CREATE FUNCTION uint2_le_int16(uint2, int16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_le_int16';


CREATE FUNCTION uint2_add_uint4(uint2, uint4) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_add_uint4';

CREATE FUNCTION uint2_add_uint8(uint2, uint8) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_add_uint8';

CREATE FUNCTION uint2_add_uint16(uint2, uint16) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_add_uint16';

CREATE FUNCTION uint2_add_int16(uint2, int16) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_add_int16';


CREATE FUNCTION uint2_sub_uint4(uint2, uint4) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_sub_uint4';

CREATE FUNCTION uint2_sub_uint8(uint2, uint8) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_sub_uint8';

CREATE FUNCTION uint2_sub_uint16(uint2, uint16) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_sub_uint16';

CREATE FUNCTION uint2_sub_int16(uint2, int16) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_sub_int16';


CREATE FUNCTION uint2_mul_uint4(uint2, uint4) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_mul_uint4';

CREATE FUNCTION uint2_mul_uint8(uint2, uint8) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_mul_uint8';

CREATE FUNCTION uint2_mul_uint16(uint2, uint16) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_mul_uint16';

CREATE FUNCTION uint2_mul_int16(uint2, int16) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_mul_int16';


CREATE FUNCTION uint2_div_uint4(uint2, uint4) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_div_uint4';

CREATE FUNCTION uint2_div_uint8(uint2, uint8) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_div_uint8';

CREATE FUNCTION uint2_div_uint16(uint2, uint16) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_div_uint16';

CREATE FUNCTION uint2_div_int16(uint2, int16) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_div_int16';


CREATE FUNCTION uint2_mod_uint4(uint2, uint4) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_mod_uint4';

CREATE FUNCTION uint2_mod_uint8(uint2, uint8) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_mod_uint8';

CREATE FUNCTION uint2_mod_uint16(uint2, uint16) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_mod_uint16';

CREATE FUNCTION uint2_mod_int16(uint2, int16) RETURNS uint2
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint2_mod_int16';


CREATE OPERATOR = (
    LEFTARG=uint2,
    RIGHTARG=uint4,
    PROCEDURE=uint2_eq_uint4,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint2,
    RIGHTARG=uint8,
    PROCEDURE=uint2_eq_uint8,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint2,
    RIGHTARG=uint16,
    PROCEDURE=uint2_eq_uint16,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=uint2,
    RIGHTARG=int16,
    PROCEDURE=uint2_eq_int16,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR <> (
    LEFTARG=uint2,
    RIGHTARG=uint4,
    PROCEDURE=uint2_ne_uint4,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint2,
    RIGHTARG=uint8,
    PROCEDURE=uint2_ne_uint8,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint2,
    RIGHTARG=uint16,
    PROCEDURE=uint2_ne_uint16,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=uint2,
    RIGHTARG=int16,
    PROCEDURE=uint2_ne_int16,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR > (
    LEFTARG=uint2,
    RIGHTARG=uint4,
    PROCEDURE=uint2_gt_uint4,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint2,
    RIGHTARG=uint8,
    PROCEDURE=uint2_gt_uint8,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint2,
    RIGHTARG=uint16,
    PROCEDURE=uint2_gt_uint16,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=uint2,
    RIGHTARG=int16,
    PROCEDURE=uint2_gt_int16,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR < (
    LEFTARG=uint2,
    RIGHTARG=uint4,
    PROCEDURE=uint2_lt_uint4,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint2,
    RIGHTARG=uint8,
    PROCEDURE=uint2_lt_uint8,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint2,
    RIGHTARG=uint16,
    PROCEDURE=uint2_lt_uint16,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=uint2,
    RIGHTARG=int16,
    PROCEDURE=uint2_lt_int16,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR >= (
    LEFTARG=uint2,
    RIGHTARG=uint4,
    PROCEDURE=uint2_ge_uint4,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint2,
    RIGHTARG=uint8,
    PROCEDURE=uint2_ge_uint8,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint2,
    RIGHTARG=uint16,
    PROCEDURE=uint2_ge_uint16,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=uint2,
    RIGHTARG=int16,
    PROCEDURE=uint2_ge_int16,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR <= (
    LEFTARG=uint2,
    RIGHTARG=uint4,
    PROCEDURE=uint2_le_uint4,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint2,
    RIGHTARG=uint8,
    PROCEDURE=uint2_le_uint8,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint2,
    RIGHTARG=uint16,
    PROCEDURE=uint2_le_uint16,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=uint2,
    RIGHTARG=int16,
    PROCEDURE=uint2_le_int16,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR + (
    LEFTARG=uint2,
    RIGHTARG=uint4,
    PROCEDURE=uint2_add_uint4,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint2,
    RIGHTARG=uint8,
    PROCEDURE=uint2_add_uint8,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint2,
    RIGHTARG=uint16,
    PROCEDURE=uint2_add_uint16,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=uint2,
    RIGHTARG=int16,
    PROCEDURE=uint2_add_int16,
    COMMUTATOR = +
);


CREATE OPERATOR - (
    LEFTARG=uint2,
    RIGHTARG=uint4,
    PROCEDURE=uint2_sub_uint4,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint2,
    RIGHTARG=uint8,
    PROCEDURE=uint2_sub_uint8,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint2,
    RIGHTARG=uint16,
    PROCEDURE=uint2_sub_uint16,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=uint2,
    RIGHTARG=int16,
    PROCEDURE=uint2_sub_int16,
    COMMUTATOR = -
);


CREATE OPERATOR * (
    LEFTARG=uint2,
    RIGHTARG=uint4,
    PROCEDURE=uint2_mul_uint4
);

CREATE OPERATOR * (
    LEFTARG=uint2,
    RIGHTARG=uint8,
    PROCEDURE=uint2_mul_uint8
);

CREATE OPERATOR * (
    LEFTARG=uint2,
    RIGHTARG=uint16,
    PROCEDURE=uint2_mul_uint16
);

CREATE OPERATOR * (
    LEFTARG=uint2,
    RIGHTARG=int16,
    PROCEDURE=uint2_mul_int16
);


CREATE OPERATOR / (
    LEFTARG=uint2,
    RIGHTARG=uint4,
    PROCEDURE=uint2_div_uint4
);

CREATE OPERATOR / (
    LEFTARG=uint2,
    RIGHTARG=uint8,
    PROCEDURE=uint2_div_uint8
);

CREATE OPERATOR / (
    LEFTARG=uint2,
    RIGHTARG=uint16,
    PROCEDURE=uint2_div_uint16
);

CREATE OPERATOR / (
    LEFTARG=uint2,
    RIGHTARG=int16,
    PROCEDURE=uint2_div_int16
);


CREATE OPERATOR % (
    LEFTARG=uint2,
    RIGHTARG=uint4,
    PROCEDURE=uint2_mod_uint4
);

CREATE OPERATOR % (
    LEFTARG=uint2,
    RIGHTARG=uint8,
    PROCEDURE=uint2_mod_uint8
);

CREATE OPERATOR % (
    LEFTARG=uint2,
    RIGHTARG=uint16,
    PROCEDURE=uint2_mod_uint16
);

CREATE OPERATOR % (
    LEFTARG=uint2,
    RIGHTARG=int16,
    PROCEDURE=uint2_mod_int16
);






-- Casts block
-- Ops block

CREATE FUNCTION int16_eq_uint2(int16, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_eq_uint2';

CREATE FUNCTION int16_eq_uint4(int16, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_eq_uint4';

CREATE FUNCTION int16_eq_uint8(int16, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_eq_uint8';

CREATE FUNCTION int16_eq_uint16(int16, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_eq_uint16';


CREATE FUNCTION int16_ne_uint2(int16, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ne_uint2';

CREATE FUNCTION int16_ne_uint4(int16, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ne_uint4';

CREATE FUNCTION int16_ne_uint8(int16, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ne_uint8';

CREATE FUNCTION int16_ne_uint16(int16, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ne_uint16';


CREATE FUNCTION int16_gt_uint2(int16, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_gt_uint2';

CREATE FUNCTION int16_gt_uint4(int16, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_gt_uint4';

CREATE FUNCTION int16_gt_uint8(int16, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_gt_uint8';

CREATE FUNCTION int16_gt_uint16(int16, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_gt_uint16';


CREATE FUNCTION int16_lt_uint2(int16, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_lt_uint2';

CREATE FUNCTION int16_lt_uint4(int16, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_lt_uint4';

CREATE FUNCTION int16_lt_uint8(int16, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_lt_uint8';

CREATE FUNCTION int16_lt_uint16(int16, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_lt_uint16';


CREATE FUNCTION int16_ge_uint2(int16, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ge_uint2';

CREATE FUNCTION int16_ge_uint4(int16, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ge_uint4';

CREATE FUNCTION int16_ge_uint8(int16, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ge_uint8';

CREATE FUNCTION int16_ge_uint16(int16, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ge_uint16';


CREATE FUNCTION int16_le_uint2(int16, uint2) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_le_uint2';

CREATE FUNCTION int16_le_uint4(int16, uint4) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_le_uint4';

CREATE FUNCTION int16_le_uint8(int16, uint8) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_le_uint8';

CREATE FUNCTION int16_le_uint16(int16, uint16) RETURNS boolean
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LEAKPROOF
    LANGUAGE C
    AS '$libdir/uint128', 'int16_le_uint16';


CREATE FUNCTION int16_add_uint2(int16, uint2) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_add_uint2';

CREATE FUNCTION int16_add_uint4(int16, uint4) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_add_uint4';

CREATE FUNCTION int16_add_uint8(int16, uint8) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_add_uint8';

CREATE FUNCTION int16_add_uint16(int16, uint16) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_add_uint16';


CREATE FUNCTION int16_sub_uint2(int16, uint2) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_sub_uint2';

CREATE FUNCTION int16_sub_uint4(int16, uint4) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_sub_uint4';

CREATE FUNCTION int16_sub_uint8(int16, uint8) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_sub_uint8';

CREATE FUNCTION int16_sub_uint16(int16, uint16) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_sub_uint16';


CREATE FUNCTION int16_mul_uint2(int16, uint2) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mul_uint2';

CREATE FUNCTION int16_mul_uint4(int16, uint4) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mul_uint4';

CREATE FUNCTION int16_mul_uint8(int16, uint8) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mul_uint8';

CREATE FUNCTION int16_mul_uint16(int16, uint16) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mul_uint16';


CREATE FUNCTION int16_div_uint2(int16, uint2) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_div_uint2';

CREATE FUNCTION int16_div_uint4(int16, uint4) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_div_uint4';

CREATE FUNCTION int16_div_uint8(int16, uint8) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_div_uint8';

CREATE FUNCTION int16_div_uint16(int16, uint16) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_div_uint16';


CREATE FUNCTION int16_mod_uint2(int16, uint2) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mod_uint2';

CREATE FUNCTION int16_mod_uint4(int16, uint4) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mod_uint4';

CREATE FUNCTION int16_mod_uint8(int16, uint8) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mod_uint8';

CREATE FUNCTION int16_mod_uint16(int16, uint16) RETURNS int16
    IMMUTABLE
    PARALLEL SAFE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mod_uint16';


CREATE OPERATOR = (
    LEFTARG=int16,
    RIGHTARG=uint2,
    PROCEDURE=int16_eq_uint2,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int16,
    RIGHTARG=uint4,
    PROCEDURE=int16_eq_uint4,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int16,
    RIGHTARG=uint8,
    PROCEDURE=int16_eq_uint8,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR = (
    LEFTARG=int16,
    RIGHTARG=uint16,
    PROCEDURE=int16_eq_uint16,
    COMMUTATOR = =,
    NEGATOR = <>,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR <> (
    LEFTARG=int16,
    RIGHTARG=uint2,
    PROCEDURE=int16_ne_uint2,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int16,
    RIGHTARG=uint4,
    PROCEDURE=int16_ne_uint4,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int16,
    RIGHTARG=uint8,
    PROCEDURE=int16_ne_uint8,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);

CREATE OPERATOR <> (
    LEFTARG=int16,
    RIGHTARG=uint16,
    PROCEDURE=int16_ne_uint16,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel,
    HASHES,
    MERGES
);


CREATE OPERATOR > (
    LEFTARG=int16,
    RIGHTARG=uint2,
    PROCEDURE=int16_gt_uint2,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int16,
    RIGHTARG=uint4,
    PROCEDURE=int16_gt_uint4,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int16,
    RIGHTARG=uint8,
    PROCEDURE=int16_gt_uint8,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR > (
    LEFTARG=int16,
    RIGHTARG=uint16,
    PROCEDURE=int16_gt_uint16,
    COMMUTATOR = >,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR < (
    LEFTARG=int16,
    RIGHTARG=uint2,
    PROCEDURE=int16_lt_uint2,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int16,
    RIGHTARG=uint4,
    PROCEDURE=int16_lt_uint4,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int16,
    RIGHTARG=uint8,
    PROCEDURE=int16_lt_uint8,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR < (
    LEFTARG=int16,
    RIGHTARG=uint16,
    PROCEDURE=int16_lt_uint16,
    COMMUTATOR = <,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR >= (
    LEFTARG=int16,
    RIGHTARG=uint2,
    PROCEDURE=int16_ge_uint2,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int16,
    RIGHTARG=uint4,
    PROCEDURE=int16_ge_uint4,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int16,
    RIGHTARG=uint8,
    PROCEDURE=int16_ge_uint8,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE OPERATOR >= (
    LEFTARG=int16,
    RIGHTARG=uint16,
    PROCEDURE=int16_ge_uint16,
    COMMUTATOR = >=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);


CREATE OPERATOR <= (
    LEFTARG=int16,
    RIGHTARG=uint2,
    PROCEDURE=int16_le_uint2,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int16,
    RIGHTARG=uint4,
    PROCEDURE=int16_le_uint4,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int16,
    RIGHTARG=uint8,
    PROCEDURE=int16_le_uint8,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE OPERATOR <= (
    LEFTARG=int16,
    RIGHTARG=uint16,
    PROCEDURE=int16_le_uint16,
    COMMUTATOR = <=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);


CREATE OPERATOR + (
    LEFTARG=int16,
    RIGHTARG=uint2,
    PROCEDURE=int16_add_uint2,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int16,
    RIGHTARG=uint4,
    PROCEDURE=int16_add_uint4,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int16,
    RIGHTARG=uint8,
    PROCEDURE=int16_add_uint8,
    COMMUTATOR = +
);

CREATE OPERATOR + (
    LEFTARG=int16,
    RIGHTARG=uint16,
    PROCEDURE=int16_add_uint16,
    COMMUTATOR = +
);


CREATE OPERATOR - (
    LEFTARG=int16,
    RIGHTARG=uint2,
    PROCEDURE=int16_sub_uint2,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int16,
    RIGHTARG=uint4,
    PROCEDURE=int16_sub_uint4,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int16,
    RIGHTARG=uint8,
    PROCEDURE=int16_sub_uint8,
    COMMUTATOR = -
);

CREATE OPERATOR - (
    LEFTARG=int16,
    RIGHTARG=uint16,
    PROCEDURE=int16_sub_uint16,
    COMMUTATOR = -
);


CREATE OPERATOR * (
    LEFTARG=int16,
    RIGHTARG=uint2,
    PROCEDURE=int16_mul_uint2
);

CREATE OPERATOR * (
    LEFTARG=int16,
    RIGHTARG=uint4,
    PROCEDURE=int16_mul_uint4
);

CREATE OPERATOR * (
    LEFTARG=int16,
    RIGHTARG=uint8,
    PROCEDURE=int16_mul_uint8
);

CREATE OPERATOR * (
    LEFTARG=int16,
    RIGHTARG=uint16,
    PROCEDURE=int16_mul_uint16
);


CREATE OPERATOR / (
    LEFTARG=int16,
    RIGHTARG=uint2,
    PROCEDURE=int16_div_uint2
);

CREATE OPERATOR / (
    LEFTARG=int16,
    RIGHTARG=uint4,
    PROCEDURE=int16_div_uint4
);

CREATE OPERATOR / (
    LEFTARG=int16,
    RIGHTARG=uint8,
    PROCEDURE=int16_div_uint8
);

CREATE OPERATOR / (
    LEFTARG=int16,
    RIGHTARG=uint16,
    PROCEDURE=int16_div_uint16
);


CREATE OPERATOR % (
    LEFTARG=int16,
    RIGHTARG=uint2,
    PROCEDURE=int16_mod_uint2
);

CREATE OPERATOR % (
    LEFTARG=int16,
    RIGHTARG=uint4,
    PROCEDURE=int16_mod_uint4
);

CREATE OPERATOR % (
    LEFTARG=int16,
    RIGHTARG=uint8,
    PROCEDURE=int16_mod_uint8
);

CREATE OPERATOR % (
    LEFTARG=int16,
    RIGHTARG=uint16,
    PROCEDURE=int16_mod_uint16
);





