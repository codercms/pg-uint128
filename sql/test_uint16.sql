-- Testing uint16

-- Ops block

SELECT 1::uint16 = 1::uint16;
SELECT 1::uint16 = 0::uint16;
SELECT 1::uint16 = 1::int2;
SELECT 1::uint16 = 0::int2;
SELECT 1::int2 = 1::uint16;
SELECT 1::int2 = 0::uint16;
SELECT 1::uint16 = 1::int4;
SELECT 1::uint16 = 0::int4;
SELECT 1::int4 = 1::uint16;
SELECT 1::int4 = 0::uint16;
SELECT 1::uint16 = 1::int8;
SELECT 1::uint16 = 0::int8;
SELECT 1::int8 = 1::uint16;
SELECT 1::int8 = 0::uint16;

SELECT 1::uint16 <> 0::uint16;
SELECT 0::uint16 <> 0::uint16;
SELECT 1::uint16 <> 0::int2;
SELECT 0::uint16 <> 0::int2;
SELECT 1::int2 <> 0::uint16;
SELECT 0::int2 <> 0::uint16;
SELECT 1::uint16 <> 0::int4;
SELECT 0::uint16 <> 0::int4;
SELECT 1::int4 <> 0::uint16;
SELECT 0::int4 <> 0::uint16;
SELECT 1::uint16 <> 0::int8;
SELECT 0::uint16 <> 0::int8;
SELECT 1::int8 <> 0::uint16;
SELECT 0::int8 <> 0::uint16;

SELECT 1::uint16 > 0::uint16;
SELECT 0::uint16 > 1::uint16;
SELECT 1::uint16 > 0::int2;
SELECT 0::uint16 > 1::int2;
SELECT 1::int2 > 0::uint16;
SELECT 0::int2 > 1::uint16;
SELECT 1::uint16 > 0::int4;
SELECT 0::uint16 > 1::int4;
SELECT 1::int4 > 0::uint16;
SELECT 0::int4 > 1::uint16;
SELECT 1::uint16 > 0::int8;
SELECT 0::uint16 > 1::int8;
SELECT 1::int8 > 0::uint16;
SELECT 0::int8 > 1::uint16;

SELECT 0::uint16 < 1::uint16;
SELECT 1::uint16 < 0::uint16;
SELECT 0::uint16 < 1::int2;
SELECT 1::uint16 < 0::int2;
SELECT 0::int2 < 1::uint16;
SELECT 1::int2 < 0::uint16;
SELECT 0::uint16 < 1::int4;
SELECT 1::uint16 < 0::int4;
SELECT 0::int4 < 1::uint16;
SELECT 1::int4 < 0::uint16;
SELECT 0::uint16 < 1::int8;
SELECT 1::uint16 < 0::int8;
SELECT 0::int8 < 1::uint16;
SELECT 1::int8 < 0::uint16;

SELECT 1::uint16 >= 0::uint16;
SELECT 0::uint16 >= 1::uint16;
SELECT 1::uint16 >= 1::uint16;
SELECT 1::uint16 >= 0::int2;
SELECT 0::uint16 >= 1::int2;
SELECT 1::uint16 >= 1::int2;
SELECT 1::int2 >= 0::uint16;
SELECT 0::int2 >= 1::uint16;
SELECT 1::int2 >= 1::uint16;
SELECT 1::uint16 >= 0::int4;
SELECT 0::uint16 >= 1::int4;
SELECT 1::uint16 >= 1::int4;
SELECT 1::int4 >= 0::uint16;
SELECT 0::int4 >= 1::uint16;
SELECT 1::int4 >= 1::uint16;
SELECT 1::uint16 >= 0::int8;
SELECT 0::uint16 >= 1::int8;
SELECT 1::uint16 >= 1::int8;
SELECT 1::int8 >= 0::uint16;
SELECT 0::int8 >= 1::uint16;
SELECT 1::int8 >= 1::uint16;

SELECT 0::uint16 <= 1::uint16;
SELECT 1::uint16 <= 0::uint16;
SELECT 1::uint16 <= 1::uint16;
SELECT 0::uint16 <= 1::int2;
SELECT 1::uint16 <= 0::int2;
SELECT 1::uint16 <= 1::int2;
SELECT 0::int2 <= 1::uint16;
SELECT 1::int2 <= 0::uint16;
SELECT 1::int2 <= 1::uint16;
SELECT 0::uint16 <= 1::int4;
SELECT 1::uint16 <= 0::int4;
SELECT 1::uint16 <= 1::int4;
SELECT 0::int4 <= 1::uint16;
SELECT 1::int4 <= 0::uint16;
SELECT 1::int4 <= 1::uint16;
SELECT 0::uint16 <= 1::int8;
SELECT 1::uint16 <= 0::int8;
SELECT 1::uint16 <= 1::int8;
SELECT 0::int8 <= 1::uint16;
SELECT 1::int8 <= 0::uint16;
SELECT 1::int8 <= 1::uint16;

SELECT 120::uint16 + 10::uint16;
SELECT 120::uint16 + 10::int2;
SELECT 340282366920938463463374607431768211455::uint16 + 1::int2;
SELECT 120::int2 + 10::uint16;
SELECT 32767::int2 + 1::uint16;
SELECT (-120)::int2 + 10::uint16;
SELECT 120::uint16 + 10::int4;
SELECT 340282366920938463463374607431768211455::uint16 + 1::int4;
SELECT 120::int4 + 10::uint16;
SELECT 2147483647::int4 + 1::uint16;
SELECT (-120)::int4 + 10::uint16;
SELECT 120::uint16 + 10::int8;
SELECT 340282366920938463463374607431768211455::uint16 + 1::int8;
SELECT 120::int8 + 10::uint16;
SELECT 9223372036854775807::int8 + 1::uint16;
SELECT (-120)::int8 + 10::uint16;

SELECT 120::uint16 - 10::uint16;
SELECT 120::uint16 - 10::int2;
SELECT 0::uint16 - 1::int2;
SELECT 120::int2 - 10::uint16;
SELECT (-32768)::int2 - 1::uint16;
SELECT (-120)::int2 - 10::uint16;
SELECT 120::uint16 - 10::int4;
SELECT 0::uint16 - 1::int4;
SELECT 120::int4 - 10::uint16;
SELECT (-2147483648)::int4 - 1::uint16;
SELECT (-120)::int4 - 10::uint16;
SELECT 120::uint16 - 10::int8;
SELECT 0::uint16 - 1::int8;
SELECT 120::int8 - 10::uint16;
SELECT (-9223372036854775808)::int8 - 1::uint16;
SELECT (-120)::int8 - 10::uint16;

SELECT 120::uint16 * 10::uint16;
SELECT 120::uint16 * 10::int2;
SELECT 340282366920938463463374607431768211455::uint16 * 2::int2;
SELECT 120::int2 * 10::uint16;
SELECT 32767::int2 * 2::uint16;
SELECT (-120)::int2 * 10::uint16;
SELECT 120::uint16 * 10::int4;
SELECT 340282366920938463463374607431768211455::uint16 * 2::int4;
SELECT 120::int4 * 10::uint16;
SELECT 2147483647::int4 * 2::uint16;
SELECT (-120)::int4 * 10::uint16;
SELECT 120::uint16 * 10::int8;
SELECT 340282366920938463463374607431768211455::uint16 * 2::int8;
SELECT 120::int8 * 10::uint16;
SELECT 9223372036854775807::int8 * 2::uint16;
SELECT (-120)::int8 * 10::uint16;

SELECT 120::uint16 / 10::uint16;
SELECT 120::uint16 / 10::int2;
SELECT 1::uint16 / 0::int2;
SELECT 120::int2 / 10::uint16;
SELECT 1::int2 / 0::uint16;
SELECT (-120)::int2 / 10::uint16;
SELECT 120::uint16 / 10::int4;
SELECT 1::uint16 / 0::int4;
SELECT 120::int4 / 10::uint16;
SELECT 1::int4 / 0::uint16;
SELECT (-120)::int4 / 10::uint16;
SELECT 120::uint16 / 10::int8;
SELECT 1::uint16 / 0::int8;
SELECT 120::int8 / 10::uint16;
SELECT 1::int8 / 0::uint16;
SELECT (-120)::int8 / 10::uint16;

SELECT 120::uint16 % 10::uint16;
SELECT 120::uint16 % 10::int2;
SELECT 1::uint16 % 0::int2;
SELECT 120::int2 % 10::uint16;
SELECT 1::int2 % 0::uint16;
SELECT (-120)::int2 % 10::uint16;
SELECT 120::uint16 % 10::int4;
SELECT 1::uint16 % 0::int4;
SELECT 120::int4 % 10::uint16;
SELECT 1::int4 % 0::uint16;
SELECT (-120)::int4 % 10::uint16;
SELECT 120::uint16 % 10::int8;
SELECT 1::uint16 % 0::int8;
SELECT 120::int8 % 10::uint16;
SELECT 1::int8 % 0::uint16;
SELECT (-120)::int8 % 10::uint16;

-- Agg ops block

SELECT sum(s::uint16) FROM generate_series(1, 10000) s;
SELECT avg(s::uint16) FROM generate_series(1, 10000) s;
SELECT min(s::uint16) FROM generate_series(1, 10000) s;
SELECT max(s::uint16) FROM generate_series(1, 10000) s;

-- Generate series block

SELECT s FROM generate_series(1::uint16, 10::uint16) s;
SELECT s FROM generate_series(1::uint16, 10::uint16, 2::uint16) s;

-- Ranges block

SELECT uint16range(0, 10);
SELECT uint16range(0::uint16, 340282366920938463463374607431768211455::uint16);
SELECT uint16range(0::uint16, 340282366920938463463374607431768211455::uint16, '[]');
SELECT upper(uint16range(0, 10));
SELECT lower(uint16range(0, 10));
SELECT isempty(uint16range(0, 10));
SELECT uint16range(0, 10) @> 9::uint16;
SELECT uint16range(0, 10) @> 10::uint16;
SELECT uint16range(0, 10) && uint16range(10,20);
SELECT uint16range(0, 10) && uint16range(9,20);
SELECT uint16range(5, 10) - uint16range(5, 10);
SELECT uint16range(5, 10) - uint16range(5, 9);
CREATE TEMPORARY TABLE test_uint16range (
    r uint16range,

    EXCLUDE USING GIST (r WITH &&)
);

INSERT INTO test_uint16range (r) VALUES (uint16range(0, 10));
INSERT INTO test_uint16range (r) VALUES (uint16range(10, 20));
INSERT INTO test_uint16range (r) VALUES (uint16range(19, 30));

DROP TABLE test_uint16range;
