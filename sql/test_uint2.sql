-- Testing uint2

-- Ops block

SELECT 1::uint2 = 1::uint2;
SELECT 1::uint2 = 0::uint2;
SELECT 1::uint2 = 1::int2;
SELECT 1::uint2 = 0::int2;
SELECT 1::int2 = 1::uint2;
SELECT 1::int2 = 0::uint2;
SELECT 1::uint2 = 1::int4;
SELECT 1::uint2 = 0::int4;
SELECT 1::int4 = 1::uint2;
SELECT 1::int4 = 0::uint2;
SELECT 1::uint2 = 1::int8;
SELECT 1::uint2 = 0::int8;
SELECT 1::int8 = 1::uint2;
SELECT 1::int8 = 0::uint2;

SELECT 1::uint2 <> 0::uint2;
SELECT 0::uint2 <> 0::uint2;
SELECT 1::uint2 <> 0::int2;
SELECT 0::uint2 <> 0::int2;
SELECT 1::int2 <> 0::uint2;
SELECT 0::int2 <> 0::uint2;
SELECT 1::uint2 <> 0::int4;
SELECT 0::uint2 <> 0::int4;
SELECT 1::int4 <> 0::uint2;
SELECT 0::int4 <> 0::uint2;
SELECT 1::uint2 <> 0::int8;
SELECT 0::uint2 <> 0::int8;
SELECT 1::int8 <> 0::uint2;
SELECT 0::int8 <> 0::uint2;

SELECT 1::uint2 > 0::uint2;
SELECT 0::uint2 > 1::uint2;
SELECT 1::uint2 > 0::int2;
SELECT 0::uint2 > 1::int2;
SELECT 1::int2 > 0::uint2;
SELECT 0::int2 > 1::uint2;
SELECT 1::uint2 > 0::int4;
SELECT 0::uint2 > 1::int4;
SELECT 1::int4 > 0::uint2;
SELECT 0::int4 > 1::uint2;
SELECT 1::uint2 > 0::int8;
SELECT 0::uint2 > 1::int8;
SELECT 1::int8 > 0::uint2;
SELECT 0::int8 > 1::uint2;

SELECT 0::uint2 < 1::uint2;
SELECT 1::uint2 < 0::uint2;
SELECT 0::uint2 < 1::int2;
SELECT 1::uint2 < 0::int2;
SELECT 0::int2 < 1::uint2;
SELECT 1::int2 < 0::uint2;
SELECT 0::uint2 < 1::int4;
SELECT 1::uint2 < 0::int4;
SELECT 0::int4 < 1::uint2;
SELECT 1::int4 < 0::uint2;
SELECT 0::uint2 < 1::int8;
SELECT 1::uint2 < 0::int8;
SELECT 0::int8 < 1::uint2;
SELECT 1::int8 < 0::uint2;

SELECT 1::uint2 >= 0::uint2;
SELECT 0::uint2 >= 1::uint2;
SELECT 1::uint2 >= 1::uint2;
SELECT 1::uint2 >= 0::int2;
SELECT 0::uint2 >= 1::int2;
SELECT 1::uint2 >= 1::int2;
SELECT 1::int2 >= 0::uint2;
SELECT 0::int2 >= 1::uint2;
SELECT 1::int2 >= 1::uint2;
SELECT 1::uint2 >= 0::int4;
SELECT 0::uint2 >= 1::int4;
SELECT 1::uint2 >= 1::int4;
SELECT 1::int4 >= 0::uint2;
SELECT 0::int4 >= 1::uint2;
SELECT 1::int4 >= 1::uint2;
SELECT 1::uint2 >= 0::int8;
SELECT 0::uint2 >= 1::int8;
SELECT 1::uint2 >= 1::int8;
SELECT 1::int8 >= 0::uint2;
SELECT 0::int8 >= 1::uint2;
SELECT 1::int8 >= 1::uint2;

SELECT 0::uint2 <= 1::uint2;
SELECT 1::uint2 <= 0::uint2;
SELECT 1::uint2 <= 1::uint2;
SELECT 0::uint2 <= 1::int2;
SELECT 1::uint2 <= 0::int2;
SELECT 1::uint2 <= 1::int2;
SELECT 0::int2 <= 1::uint2;
SELECT 1::int2 <= 0::uint2;
SELECT 1::int2 <= 1::uint2;
SELECT 0::uint2 <= 1::int4;
SELECT 1::uint2 <= 0::int4;
SELECT 1::uint2 <= 1::int4;
SELECT 0::int4 <= 1::uint2;
SELECT 1::int4 <= 0::uint2;
SELECT 1::int4 <= 1::uint2;
SELECT 0::uint2 <= 1::int8;
SELECT 1::uint2 <= 0::int8;
SELECT 1::uint2 <= 1::int8;
SELECT 0::int8 <= 1::uint2;
SELECT 1::int8 <= 0::uint2;
SELECT 1::int8 <= 1::uint2;

SELECT 120::uint2 + 10::uint2;
SELECT 120::uint2 + 10::int2;
SELECT 65535::uint2 + 1::int2;
SELECT 120::int2 + 10::uint2;
SELECT 32767::int2 + 1::uint2;
SELECT (-120)::int2 + 10::uint2;
SELECT 120::uint2 + 10::int4;
SELECT 65535::uint2 + 1::int4;
SELECT 120::int4 + 10::uint2;
SELECT 2147483647::int4 + 1::uint2;
SELECT (-120)::int4 + 10::uint2;
SELECT 120::uint2 + 10::int8;
SELECT 65535::uint2 + 1::int8;
SELECT 120::int8 + 10::uint2;
SELECT 9223372036854775807::int8 + 1::uint2;
SELECT (-120)::int8 + 10::uint2;

SELECT 120::uint2 - 10::uint2;
SELECT 120::uint2 - 10::int2;
SELECT 0::uint2 - 1::int2;
SELECT 120::int2 - 10::uint2;
SELECT (-32768)::int2 - 1::uint2;
SELECT (-120)::int2 - 10::uint2;
SELECT 120::uint2 - 10::int4;
SELECT 0::uint2 - 1::int4;
SELECT 120::int4 - 10::uint2;
SELECT (-2147483648)::int4 - 1::uint2;
SELECT (-120)::int4 - 10::uint2;
SELECT 120::uint2 - 10::int8;
SELECT 0::uint2 - 1::int8;
SELECT 120::int8 - 10::uint2;
SELECT (-9223372036854775808)::int8 - 1::uint2;
SELECT (-120)::int8 - 10::uint2;

SELECT 120::uint2 * 10::uint2;
SELECT 120::uint2 * 10::int2;
SELECT 65535::uint2 * 2::int2;
SELECT 120::int2 * 10::uint2;
SELECT 32767::int2 * 2::uint2;
SELECT (-120)::int2 * 10::uint2;
SELECT 120::uint2 * 10::int4;
SELECT 65535::uint2 * 2::int4;
SELECT 120::int4 * 10::uint2;
SELECT 2147483647::int4 * 2::uint2;
SELECT (-120)::int4 * 10::uint2;
SELECT 120::uint2 * 10::int8;
SELECT 65535::uint2 * 2::int8;
SELECT 120::int8 * 10::uint2;
SELECT 9223372036854775807::int8 * 2::uint2;
SELECT (-120)::int8 * 10::uint2;

SELECT 120::uint2 / 10::uint2;
SELECT 120::uint2 / 10::int2;
SELECT 1::uint2 / 0::int2;
SELECT 120::int2 / 10::uint2;
SELECT 1::int2 / 0::uint2;
SELECT (-120)::int2 / 10::uint2;
SELECT 120::uint2 / 10::int4;
SELECT 1::uint2 / 0::int4;
SELECT 120::int4 / 10::uint2;
SELECT 1::int4 / 0::uint2;
SELECT (-120)::int4 / 10::uint2;
SELECT 120::uint2 / 10::int8;
SELECT 1::uint2 / 0::int8;
SELECT 120::int8 / 10::uint2;
SELECT 1::int8 / 0::uint2;
SELECT (-120)::int8 / 10::uint2;

SELECT 120::uint2 % 10::uint2;
SELECT 120::uint2 % 10::int2;
SELECT 1::uint2 % 0::int2;
SELECT 120::int2 % 10::uint2;
SELECT 1::int2 % 0::uint2;
SELECT (-120)::int2 % 10::uint2;
SELECT 120::uint2 % 10::int4;
SELECT 1::uint2 % 0::int4;
SELECT 120::int4 % 10::uint2;
SELECT 1::int4 % 0::uint2;
SELECT (-120)::int4 % 10::uint2;
SELECT 120::uint2 % 10::int8;
SELECT 1::uint2 % 0::int8;
SELECT 120::int8 % 10::uint2;
SELECT 1::int8 % 0::uint2;
SELECT (-120)::int8 % 10::uint2;

-- Agg ops block

SELECT sum(s::uint2) FROM generate_series(1, 10000) s;
SELECT avg(s::uint2) FROM generate_series(1, 10000) s;
SELECT min(s::uint2) FROM generate_series(1, 10000) s;
SELECT max(s::uint2) FROM generate_series(1, 10000) s;

-- Generate series block

SELECT s FROM generate_series(1::uint2, 10::uint2) s;
SELECT s FROM generate_series(1::uint2, 10::uint2, 2::uint2) s;
