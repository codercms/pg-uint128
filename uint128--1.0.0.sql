CREATE TYPE uint16;
CREATE TYPE uint8;
CREATE TYPE int16;

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
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_eq_uint16';

CREATE FUNCTION uint16_eq_int2(uint16, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_eq_int2';

CREATE FUNCTION int2_eq_uint16(int2, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_eq_uint16';

CREATE FUNCTION uint16_eq_int4(uint16, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_eq_int4';

CREATE FUNCTION int4_eq_uint16(int4, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_eq_uint16';

CREATE FUNCTION uint16_eq_int8(uint16, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_eq_int8';

CREATE FUNCTION int8_eq_uint16(int8, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_eq_uint16';


CREATE FUNCTION uint16_ne_uint16(uint16, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ne_uint16';

CREATE FUNCTION uint16_ne_int2(uint16, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ne_int2';

CREATE FUNCTION int2_ne_uint16(int2, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_ne_uint16';

CREATE FUNCTION uint16_ne_int4(uint16, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ne_int4';

CREATE FUNCTION int4_ne_uint16(int4, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_ne_uint16';

CREATE FUNCTION uint16_ne_int8(uint16, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ne_int8';

CREATE FUNCTION int8_ne_uint16(int8, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_ne_uint16';


CREATE FUNCTION uint16_gt_uint16(uint16, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_gt_uint16';

CREATE FUNCTION uint16_gt_int2(uint16, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_gt_int2';

CREATE FUNCTION int2_gt_uint16(int2, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_gt_uint16';

CREATE FUNCTION uint16_gt_int4(uint16, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_gt_int4';

CREATE FUNCTION int4_gt_uint16(int4, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_gt_uint16';

CREATE FUNCTION uint16_gt_int8(uint16, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_gt_int8';

CREATE FUNCTION int8_gt_uint16(int8, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_gt_uint16';


CREATE FUNCTION uint16_lt_uint16(uint16, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_lt_uint16';

CREATE FUNCTION uint16_lt_int2(uint16, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_lt_int2';

CREATE FUNCTION int2_lt_uint16(int2, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_lt_uint16';

CREATE FUNCTION uint16_lt_int4(uint16, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_lt_int4';

CREATE FUNCTION int4_lt_uint16(int4, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_lt_uint16';

CREATE FUNCTION uint16_lt_int8(uint16, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_lt_int8';

CREATE FUNCTION int8_lt_uint16(int8, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_lt_uint16';


CREATE FUNCTION uint16_ge_uint16(uint16, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ge_uint16';

CREATE FUNCTION uint16_ge_int2(uint16, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ge_int2';

CREATE FUNCTION int2_ge_uint16(int2, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_ge_uint16';

CREATE FUNCTION uint16_ge_int4(uint16, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ge_int4';

CREATE FUNCTION int4_ge_uint16(int4, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_ge_uint16';

CREATE FUNCTION uint16_ge_int8(uint16, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ge_int8';

CREATE FUNCTION int8_ge_uint16(int8, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_ge_uint16';


CREATE FUNCTION uint16_le_uint16(uint16, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_le_uint16';

CREATE FUNCTION uint16_le_int2(uint16, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_le_int2';

CREATE FUNCTION int2_le_uint16(int2, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_le_uint16';

CREATE FUNCTION uint16_le_int4(uint16, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_le_int4';

CREATE FUNCTION int4_le_uint16(int4, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_le_uint16';

CREATE FUNCTION uint16_le_int8(uint16, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_le_int8';

CREATE FUNCTION int8_le_uint16(int8, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_le_uint16';


CREATE FUNCTION uint16_add_uint16(uint16, uint16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_add_uint16';

CREATE FUNCTION uint16_add_int2(uint16, int2) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_add_int2';

CREATE FUNCTION int2_add_uint16(int2, uint16) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_add_uint16';

CREATE FUNCTION uint16_add_int4(uint16, int4) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_add_int4';

CREATE FUNCTION int4_add_uint16(int4, uint16) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_add_uint16';

CREATE FUNCTION uint16_add_int8(uint16, int8) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_add_int8';

CREATE FUNCTION int8_add_uint16(int8, uint16) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_add_uint16';


CREATE FUNCTION uint16_sub_uint16(uint16, uint16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_sub_uint16';

CREATE FUNCTION uint16_sub_int2(uint16, int2) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_sub_int2';

CREATE FUNCTION int2_sub_uint16(int2, uint16) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_sub_uint16';

CREATE FUNCTION uint16_sub_int4(uint16, int4) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_sub_int4';

CREATE FUNCTION int4_sub_uint16(int4, uint16) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_sub_uint16';

CREATE FUNCTION uint16_sub_int8(uint16, int8) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_sub_int8';

CREATE FUNCTION int8_sub_uint16(int8, uint16) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_sub_uint16';


CREATE FUNCTION uint16_mul_uint16(uint16, uint16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mul_uint16';

CREATE FUNCTION uint16_mul_int2(uint16, int2) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mul_int2';

CREATE FUNCTION int2_mul_uint16(int2, uint16) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_mul_uint16';

CREATE FUNCTION uint16_mul_int4(uint16, int4) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mul_int4';

CREATE FUNCTION int4_mul_uint16(int4, uint16) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_mul_uint16';

CREATE FUNCTION uint16_mul_int8(uint16, int8) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mul_int8';

CREATE FUNCTION int8_mul_uint16(int8, uint16) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_mul_uint16';


CREATE FUNCTION uint16_div_uint16(uint16, uint16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_div_uint16';

CREATE FUNCTION uint16_div_int2(uint16, int2) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_div_int2';

CREATE FUNCTION int2_div_uint16(int2, uint16) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_div_uint16';

CREATE FUNCTION uint16_div_int4(uint16, int4) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_div_int4';

CREATE FUNCTION int4_div_uint16(int4, uint16) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_div_uint16';

CREATE FUNCTION uint16_div_int8(uint16, int8) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_div_int8';

CREATE FUNCTION int8_div_uint16(int8, uint16) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_div_uint16';


CREATE FUNCTION uint16_mod_uint16(uint16, uint16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mod_uint16';

CREATE FUNCTION uint16_mod_int2(uint16, int2) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mod_int2';

CREATE FUNCTION int2_mod_uint16(int2, uint16) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_mod_uint16';

CREATE FUNCTION uint16_mod_int4(uint16, int4) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mod_int4';

CREATE FUNCTION int4_mod_uint16(int4, uint16) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_mod_uint16';

CREATE FUNCTION uint16_mod_int8(uint16, int8) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mod_int8';

CREATE FUNCTION int8_mod_uint16(int8, uint16) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_mod_uint16';


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


CREATE FUNCTION uint8_in(cstring) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_in';

CREATE FUNCTION uint8_out(uint8) RETURNS cstring
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_out';

CREATE FUNCTION uint8_recv(internal) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_recv';

CREATE FUNCTION uint8_send(uint8) RETURNS bytea
    IMMUTABLE
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
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_eq_uint8';

CREATE FUNCTION uint8_eq_int2(uint8, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_eq_int2';

CREATE FUNCTION int2_eq_uint8(int2, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_eq_uint8';

CREATE FUNCTION uint8_eq_int4(uint8, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_eq_int4';

CREATE FUNCTION int4_eq_uint8(int4, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_eq_uint8';

CREATE FUNCTION uint8_eq_int8(uint8, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_eq_int8';

CREATE FUNCTION int8_eq_uint8(int8, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_eq_uint8';


CREATE FUNCTION uint8_ne_uint8(uint8, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ne_uint8';

CREATE FUNCTION uint8_ne_int2(uint8, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ne_int2';

CREATE FUNCTION int2_ne_uint8(int2, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_ne_uint8';

CREATE FUNCTION uint8_ne_int4(uint8, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ne_int4';

CREATE FUNCTION int4_ne_uint8(int4, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_ne_uint8';

CREATE FUNCTION uint8_ne_int8(uint8, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ne_int8';

CREATE FUNCTION int8_ne_uint8(int8, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_ne_uint8';


CREATE FUNCTION uint8_gt_uint8(uint8, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_gt_uint8';

CREATE FUNCTION uint8_gt_int2(uint8, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_gt_int2';

CREATE FUNCTION int2_gt_uint8(int2, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_gt_uint8';

CREATE FUNCTION uint8_gt_int4(uint8, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_gt_int4';

CREATE FUNCTION int4_gt_uint8(int4, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_gt_uint8';

CREATE FUNCTION uint8_gt_int8(uint8, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_gt_int8';

CREATE FUNCTION int8_gt_uint8(int8, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_gt_uint8';


CREATE FUNCTION uint8_lt_uint8(uint8, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_lt_uint8';

CREATE FUNCTION uint8_lt_int2(uint8, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_lt_int2';

CREATE FUNCTION int2_lt_uint8(int2, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_lt_uint8';

CREATE FUNCTION uint8_lt_int4(uint8, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_lt_int4';

CREATE FUNCTION int4_lt_uint8(int4, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_lt_uint8';

CREATE FUNCTION uint8_lt_int8(uint8, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_lt_int8';

CREATE FUNCTION int8_lt_uint8(int8, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_lt_uint8';


CREATE FUNCTION uint8_ge_uint8(uint8, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ge_uint8';

CREATE FUNCTION uint8_ge_int2(uint8, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ge_int2';

CREATE FUNCTION int2_ge_uint8(int2, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_ge_uint8';

CREATE FUNCTION uint8_ge_int4(uint8, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ge_int4';

CREATE FUNCTION int4_ge_uint8(int4, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_ge_uint8';

CREATE FUNCTION uint8_ge_int8(uint8, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ge_int8';

CREATE FUNCTION int8_ge_uint8(int8, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_ge_uint8';


CREATE FUNCTION uint8_le_uint8(uint8, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_le_uint8';

CREATE FUNCTION uint8_le_int2(uint8, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_le_int2';

CREATE FUNCTION int2_le_uint8(int2, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_le_uint8';

CREATE FUNCTION uint8_le_int4(uint8, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_le_int4';

CREATE FUNCTION int4_le_uint8(int4, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_le_uint8';

CREATE FUNCTION uint8_le_int8(uint8, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_le_int8';

CREATE FUNCTION int8_le_uint8(int8, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_le_uint8';


CREATE FUNCTION uint8_add_uint8(uint8, uint8) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_add_uint8';

CREATE FUNCTION uint8_add_int2(uint8, int2) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_add_int2';

CREATE FUNCTION int2_add_uint8(int2, uint8) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_add_uint8';

CREATE FUNCTION uint8_add_int4(uint8, int4) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_add_int4';

CREATE FUNCTION int4_add_uint8(int4, uint8) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_add_uint8';

CREATE FUNCTION uint8_add_int8(uint8, int8) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_add_int8';

CREATE FUNCTION int8_add_uint8(int8, uint8) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_add_uint8';


CREATE FUNCTION uint8_sub_uint8(uint8, uint8) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_sub_uint8';

CREATE FUNCTION uint8_sub_int2(uint8, int2) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_sub_int2';

CREATE FUNCTION int2_sub_uint8(int2, uint8) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_sub_uint8';

CREATE FUNCTION uint8_sub_int4(uint8, int4) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_sub_int4';

CREATE FUNCTION int4_sub_uint8(int4, uint8) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_sub_uint8';

CREATE FUNCTION uint8_sub_int8(uint8, int8) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_sub_int8';

CREATE FUNCTION int8_sub_uint8(int8, uint8) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_sub_uint8';


CREATE FUNCTION uint8_mul_uint8(uint8, uint8) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mul_uint8';

CREATE FUNCTION uint8_mul_int2(uint8, int2) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mul_int2';

CREATE FUNCTION int2_mul_uint8(int2, uint8) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_mul_uint8';

CREATE FUNCTION uint8_mul_int4(uint8, int4) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mul_int4';

CREATE FUNCTION int4_mul_uint8(int4, uint8) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_mul_uint8';

CREATE FUNCTION uint8_mul_int8(uint8, int8) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mul_int8';

CREATE FUNCTION int8_mul_uint8(int8, uint8) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_mul_uint8';


CREATE FUNCTION uint8_div_uint8(uint8, uint8) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_div_uint8';

CREATE FUNCTION uint8_div_int2(uint8, int2) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_div_int2';

CREATE FUNCTION int2_div_uint8(int2, uint8) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_div_uint8';

CREATE FUNCTION uint8_div_int4(uint8, int4) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_div_int4';

CREATE FUNCTION int4_div_uint8(int4, uint8) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_div_uint8';

CREATE FUNCTION uint8_div_int8(uint8, int8) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_div_int8';

CREATE FUNCTION int8_div_uint8(int8, uint8) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_div_uint8';


CREATE FUNCTION uint8_mod_uint8(uint8, uint8) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mod_uint8';

CREATE FUNCTION uint8_mod_int2(uint8, int2) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mod_int2';

CREATE FUNCTION int2_mod_uint8(int2, uint8) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_mod_uint8';

CREATE FUNCTION uint8_mod_int4(uint8, int4) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mod_int4';

CREATE FUNCTION int4_mod_uint8(int4, uint8) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_mod_uint8';

CREATE FUNCTION uint8_mod_int8(uint8, int8) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mod_int8';

CREATE FUNCTION int8_mod_uint8(int8, uint8) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_mod_uint8';


CREATE FUNCTION uint8_xor(uint8, uint8) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_xor';


CREATE FUNCTION uint8_and(uint8, uint8) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_and';


CREATE FUNCTION uint8_or(uint8, uint8) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_or';


CREATE FUNCTION uint8_not(uint8) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_not';

CREATE FUNCTION uint8_shl(uint8, int4) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_shl';


CREATE FUNCTION uint8_shr(uint8, int4) RETURNS uint8
    IMMUTABLE
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


CREATE FUNCTION int16_in(cstring) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_in';

CREATE FUNCTION int16_out(int16) RETURNS cstring
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_out';

CREATE FUNCTION int16_recv(internal) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_recv';

CREATE FUNCTION int16_send(int16) RETURNS bytea
    IMMUTABLE
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
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_eq_int16';

CREATE FUNCTION int16_eq_int2(int16, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_eq_int2';

CREATE FUNCTION int2_eq_int16(int2, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_eq_int16';

CREATE FUNCTION int16_eq_int4(int16, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_eq_int4';

CREATE FUNCTION int4_eq_int16(int4, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_eq_int16';

CREATE FUNCTION int16_eq_int8(int16, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_eq_int8';

CREATE FUNCTION int8_eq_int16(int8, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_eq_int16';


CREATE FUNCTION int16_ne_int16(int16, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ne_int16';

CREATE FUNCTION int16_ne_int2(int16, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ne_int2';

CREATE FUNCTION int2_ne_int16(int2, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_ne_int16';

CREATE FUNCTION int16_ne_int4(int16, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ne_int4';

CREATE FUNCTION int4_ne_int16(int4, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_ne_int16';

CREATE FUNCTION int16_ne_int8(int16, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ne_int8';

CREATE FUNCTION int8_ne_int16(int8, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_ne_int16';


CREATE FUNCTION int16_gt_int16(int16, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_gt_int16';

CREATE FUNCTION int16_gt_int2(int16, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_gt_int2';

CREATE FUNCTION int2_gt_int16(int2, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_gt_int16';

CREATE FUNCTION int16_gt_int4(int16, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_gt_int4';

CREATE FUNCTION int4_gt_int16(int4, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_gt_int16';

CREATE FUNCTION int16_gt_int8(int16, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_gt_int8';

CREATE FUNCTION int8_gt_int16(int8, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_gt_int16';


CREATE FUNCTION int16_lt_int16(int16, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_lt_int16';

CREATE FUNCTION int16_lt_int2(int16, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_lt_int2';

CREATE FUNCTION int2_lt_int16(int2, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_lt_int16';

CREATE FUNCTION int16_lt_int4(int16, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_lt_int4';

CREATE FUNCTION int4_lt_int16(int4, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_lt_int16';

CREATE FUNCTION int16_lt_int8(int16, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_lt_int8';

CREATE FUNCTION int8_lt_int16(int8, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_lt_int16';


CREATE FUNCTION int16_ge_int16(int16, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ge_int16';

CREATE FUNCTION int16_ge_int2(int16, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ge_int2';

CREATE FUNCTION int2_ge_int16(int2, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_ge_int16';

CREATE FUNCTION int16_ge_int4(int16, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ge_int4';

CREATE FUNCTION int4_ge_int16(int4, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_ge_int16';

CREATE FUNCTION int16_ge_int8(int16, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ge_int8';

CREATE FUNCTION int8_ge_int16(int8, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_ge_int16';


CREATE FUNCTION int16_le_int16(int16, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_le_int16';

CREATE FUNCTION int16_le_int2(int16, int2) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_le_int2';

CREATE FUNCTION int2_le_int16(int2, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_le_int16';

CREATE FUNCTION int16_le_int4(int16, int4) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_le_int4';

CREATE FUNCTION int4_le_int16(int4, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_le_int16';

CREATE FUNCTION int16_le_int8(int16, int8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_le_int8';

CREATE FUNCTION int8_le_int16(int8, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_le_int16';


CREATE FUNCTION int16_add_int16(int16, int16) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_add_int16';

CREATE FUNCTION int16_add_int2(int16, int2) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_add_int2';

CREATE FUNCTION int2_add_int16(int2, int16) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_add_int16';

CREATE FUNCTION int16_add_int4(int16, int4) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_add_int4';

CREATE FUNCTION int4_add_int16(int4, int16) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_add_int16';

CREATE FUNCTION int16_add_int8(int16, int8) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_add_int8';

CREATE FUNCTION int8_add_int16(int8, int16) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_add_int16';


CREATE FUNCTION int16_sub_int16(int16, int16) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_sub_int16';

CREATE FUNCTION int16_sub_int2(int16, int2) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_sub_int2';

CREATE FUNCTION int2_sub_int16(int2, int16) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_sub_int16';

CREATE FUNCTION int16_sub_int4(int16, int4) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_sub_int4';

CREATE FUNCTION int4_sub_int16(int4, int16) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_sub_int16';

CREATE FUNCTION int16_sub_int8(int16, int8) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_sub_int8';

CREATE FUNCTION int8_sub_int16(int8, int16) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_sub_int16';


CREATE FUNCTION int16_mul_int16(int16, int16) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mul_int16';

CREATE FUNCTION int16_mul_int2(int16, int2) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mul_int2';

CREATE FUNCTION int2_mul_int16(int2, int16) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_mul_int16';

CREATE FUNCTION int16_mul_int4(int16, int4) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mul_int4';

CREATE FUNCTION int4_mul_int16(int4, int16) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_mul_int16';

CREATE FUNCTION int16_mul_int8(int16, int8) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mul_int8';

CREATE FUNCTION int8_mul_int16(int8, int16) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_mul_int16';


CREATE FUNCTION int16_div_int16(int16, int16) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_div_int16';

CREATE FUNCTION int16_div_int2(int16, int2) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_div_int2';

CREATE FUNCTION int2_div_int16(int2, int16) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_div_int16';

CREATE FUNCTION int16_div_int4(int16, int4) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_div_int4';

CREATE FUNCTION int4_div_int16(int4, int16) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_div_int16';

CREATE FUNCTION int16_div_int8(int16, int8) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_div_int8';

CREATE FUNCTION int8_div_int16(int8, int16) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_div_int16';


CREATE FUNCTION int16_mod_int16(int16, int16) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mod_int16';

CREATE FUNCTION int16_mod_int2(int16, int2) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mod_int2';

CREATE FUNCTION int2_mod_int16(int2, int16) RETURNS int2
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int2_mod_int16';

CREATE FUNCTION int16_mod_int4(int16, int4) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mod_int4';

CREATE FUNCTION int4_mod_int16(int4, int16) RETURNS int4
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int4_mod_int16';

CREATE FUNCTION int16_mod_int8(int16, int8) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mod_int8';

CREATE FUNCTION int8_mod_int16(int8, int16) RETURNS int8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int8_mod_int16';


CREATE FUNCTION int16_xor(int16, int16) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_xor';


CREATE FUNCTION int16_and(int16, int16) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_and';


CREATE FUNCTION int16_or(int16, int16) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_or';


CREATE FUNCTION int16_not(int16) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_not';

CREATE FUNCTION int16_shl(int16, int4) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_shl';


CREATE FUNCTION int16_shr(int16, int4) RETURNS int16
    IMMUTABLE
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




-- Cross types ops

-- Casts block

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

CREATE FUNCTION uint16_eq_uint8(uint16, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_eq_uint8';

CREATE FUNCTION uint16_eq_int16(uint16, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_eq_int16';


CREATE FUNCTION uint16_ne_uint8(uint16, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ne_uint8';

CREATE FUNCTION uint16_ne_int16(uint16, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ne_int16';


CREATE FUNCTION uint16_gt_uint8(uint16, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_gt_uint8';

CREATE FUNCTION uint16_gt_int16(uint16, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_gt_int16';


CREATE FUNCTION uint16_lt_uint8(uint16, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_lt_uint8';

CREATE FUNCTION uint16_lt_int16(uint16, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_lt_int16';


CREATE FUNCTION uint16_ge_uint8(uint16, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ge_uint8';

CREATE FUNCTION uint16_ge_int16(uint16, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_ge_int16';


CREATE FUNCTION uint16_le_uint8(uint16, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_le_uint8';

CREATE FUNCTION uint16_le_int16(uint16, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_le_int16';


CREATE FUNCTION uint16_add_uint8(uint16, uint8) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_add_uint8';

CREATE FUNCTION uint16_add_int16(uint16, int16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_add_int16';


CREATE FUNCTION uint16_sub_uint8(uint16, uint8) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_sub_uint8';

CREATE FUNCTION uint16_sub_int16(uint16, int16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_sub_int16';


CREATE FUNCTION uint16_mul_uint8(uint16, uint8) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mul_uint8';

CREATE FUNCTION uint16_mul_int16(uint16, int16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mul_int16';


CREATE FUNCTION uint16_div_uint8(uint16, uint8) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_div_uint8';

CREATE FUNCTION uint16_div_int16(uint16, int16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_div_int16';


CREATE FUNCTION uint16_mod_uint8(uint16, uint8) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mod_uint8';

CREATE FUNCTION uint16_mod_int16(uint16, int16) RETURNS uint16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint16_mod_int16';


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
    RIGHTARG=uint8,
    PROCEDURE=uint16_mod_uint8
);

CREATE OPERATOR % (
    LEFTARG=uint16,
    RIGHTARG=int16,
    PROCEDURE=uint16_mod_int16
);






-- Casts block

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

CREATE FUNCTION uint8_eq_uint16(uint8, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_eq_uint16';

CREATE FUNCTION uint8_eq_int16(uint8, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_eq_int16';


CREATE FUNCTION uint8_ne_uint16(uint8, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ne_uint16';

CREATE FUNCTION uint8_ne_int16(uint8, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ne_int16';


CREATE FUNCTION uint8_gt_uint16(uint8, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_gt_uint16';

CREATE FUNCTION uint8_gt_int16(uint8, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_gt_int16';


CREATE FUNCTION uint8_lt_uint16(uint8, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_lt_uint16';

CREATE FUNCTION uint8_lt_int16(uint8, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_lt_int16';


CREATE FUNCTION uint8_ge_uint16(uint8, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ge_uint16';

CREATE FUNCTION uint8_ge_int16(uint8, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_ge_int16';


CREATE FUNCTION uint8_le_uint16(uint8, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_le_uint16';

CREATE FUNCTION uint8_le_int16(uint8, int16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_le_int16';


CREATE FUNCTION uint8_add_uint16(uint8, uint16) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_add_uint16';

CREATE FUNCTION uint8_add_int16(uint8, int16) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_add_int16';


CREATE FUNCTION uint8_sub_uint16(uint8, uint16) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_sub_uint16';

CREATE FUNCTION uint8_sub_int16(uint8, int16) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_sub_int16';


CREATE FUNCTION uint8_mul_uint16(uint8, uint16) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mul_uint16';

CREATE FUNCTION uint8_mul_int16(uint8, int16) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mul_int16';


CREATE FUNCTION uint8_div_uint16(uint8, uint16) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_div_uint16';

CREATE FUNCTION uint8_div_int16(uint8, int16) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_div_int16';


CREATE FUNCTION uint8_mod_uint16(uint8, uint16) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mod_uint16';

CREATE FUNCTION uint8_mod_int16(uint8, int16) RETURNS uint8
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'uint8_mod_int16';


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
    RIGHTARG=uint16,
    PROCEDURE=uint8_mod_uint16
);

CREATE OPERATOR % (
    LEFTARG=uint8,
    RIGHTARG=int16,
    PROCEDURE=uint8_mod_int16
);






-- Casts block
-- Ops block

CREATE FUNCTION int16_eq_uint8(int16, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_eq_uint8';

CREATE FUNCTION int16_eq_uint16(int16, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_eq_uint16';


CREATE FUNCTION int16_ne_uint8(int16, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ne_uint8';

CREATE FUNCTION int16_ne_uint16(int16, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ne_uint16';


CREATE FUNCTION int16_gt_uint8(int16, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_gt_uint8';

CREATE FUNCTION int16_gt_uint16(int16, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_gt_uint16';


CREATE FUNCTION int16_lt_uint8(int16, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_lt_uint8';

CREATE FUNCTION int16_lt_uint16(int16, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_lt_uint16';


CREATE FUNCTION int16_ge_uint8(int16, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ge_uint8';

CREATE FUNCTION int16_ge_uint16(int16, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_ge_uint16';


CREATE FUNCTION int16_le_uint8(int16, uint8) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_le_uint8';

CREATE FUNCTION int16_le_uint16(int16, uint16) RETURNS boolean
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_le_uint16';


CREATE FUNCTION int16_add_uint8(int16, uint8) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_add_uint8';

CREATE FUNCTION int16_add_uint16(int16, uint16) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_add_uint16';


CREATE FUNCTION int16_sub_uint8(int16, uint8) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_sub_uint8';

CREATE FUNCTION int16_sub_uint16(int16, uint16) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_sub_uint16';


CREATE FUNCTION int16_mul_uint8(int16, uint8) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mul_uint8';

CREATE FUNCTION int16_mul_uint16(int16, uint16) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mul_uint16';


CREATE FUNCTION int16_div_uint8(int16, uint8) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_div_uint8';

CREATE FUNCTION int16_div_uint16(int16, uint16) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_div_uint16';


CREATE FUNCTION int16_mod_uint8(int16, uint8) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mod_uint8';

CREATE FUNCTION int16_mod_uint16(int16, uint16) RETURNS int16
    IMMUTABLE
    STRICT
    LANGUAGE C
    AS '$libdir/uint128', 'int16_mod_uint16';


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
    RIGHTARG=uint8,
    PROCEDURE=int16_mod_uint8
);

CREATE OPERATOR % (
    LEFTARG=int16,
    RIGHTARG=uint16,
    PROCEDURE=int16_mod_uint16
);





