-- Testing uint8

-- Ops block

SELECT 1::uint8 = 1::uint8;
SELECT 1::uint8 = 0::uint8;
SELECT 1::uint8 = 1::int2;
SELECT 1::uint8 = 0::int2;
SELECT 1::int2 = 1::uint8;
SELECT 1::int2 = 0::uint8;
SELECT 1::uint8 = 1::int4;
SELECT 1::uint8 = 0::int4;
SELECT 1::int4 = 1::uint8;
SELECT 1::int4 = 0::uint8;
SELECT 1::uint8 = 1::int8;
SELECT 1::uint8 = 0::int8;
SELECT 1::int8 = 1::uint8;
SELECT 1::int8 = 0::uint8;

SELECT 1::uint8 <> 0::uint8;
SELECT 0::uint8 <> 0::uint8;
SELECT 1::uint8 <> 0::int2;
SELECT 0::uint8 <> 0::int2;
SELECT 1::int2 <> 0::uint8;
SELECT 0::int2 <> 0::uint8;
SELECT 1::uint8 <> 0::int4;
SELECT 0::uint8 <> 0::int4;
SELECT 1::int4 <> 0::uint8;
SELECT 0::int4 <> 0::uint8;
SELECT 1::uint8 <> 0::int8;
SELECT 0::uint8 <> 0::int8;
SELECT 1::int8 <> 0::uint8;
SELECT 0::int8 <> 0::uint8;

SELECT 1::uint8 > 0::uint8;
SELECT 0::uint8 > 1::uint8;
SELECT 1::uint8 > 0::int2;
SELECT 0::uint8 > 1::int2;
SELECT 1::int2 > 0::uint8;
SELECT 0::int2 > 1::uint8;
SELECT 1::uint8 > 0::int4;
SELECT 0::uint8 > 1::int4;
SELECT 1::int4 > 0::uint8;
SELECT 0::int4 > 1::uint8;
SELECT 1::uint8 > 0::int8;
SELECT 0::uint8 > 1::int8;
SELECT 1::int8 > 0::uint8;
SELECT 0::int8 > 1::uint8;

SELECT 0::uint8 < 1::uint8;
SELECT 1::uint8 < 0::uint8;
SELECT 0::uint8 < 1::int2;
SELECT 1::uint8 < 0::int2;
SELECT 0::int2 < 1::uint8;
SELECT 1::int2 < 0::uint8;
SELECT 0::uint8 < 1::int4;
SELECT 1::uint8 < 0::int4;
SELECT 0::int4 < 1::uint8;
SELECT 1::int4 < 0::uint8;
SELECT 0::uint8 < 1::int8;
SELECT 1::uint8 < 0::int8;
SELECT 0::int8 < 1::uint8;
SELECT 1::int8 < 0::uint8;

SELECT 1::uint8 >= 0::uint8;
SELECT 0::uint8 >= 1::uint8;
SELECT 1::uint8 >= 1::uint8;
SELECT 1::uint8 >= 0::int2;
SELECT 0::uint8 >= 1::int2;
SELECT 1::uint8 >= 1::int2;
SELECT 1::int2 >= 0::uint8;
SELECT 0::int2 >= 1::uint8;
SELECT 1::int2 >= 1::uint8;
SELECT 1::uint8 >= 0::int4;
SELECT 0::uint8 >= 1::int4;
SELECT 1::uint8 >= 1::int4;
SELECT 1::int4 >= 0::uint8;
SELECT 0::int4 >= 1::uint8;
SELECT 1::int4 >= 1::uint8;
SELECT 1::uint8 >= 0::int8;
SELECT 0::uint8 >= 1::int8;
SELECT 1::uint8 >= 1::int8;
SELECT 1::int8 >= 0::uint8;
SELECT 0::int8 >= 1::uint8;
SELECT 1::int8 >= 1::uint8;

SELECT 0::uint8 <= 1::uint8;
SELECT 1::uint8 <= 0::uint8;
SELECT 1::uint8 <= 1::uint8;
SELECT 0::uint8 <= 1::int2;
SELECT 1::uint8 <= 0::int2;
SELECT 1::uint8 <= 1::int2;
SELECT 0::int2 <= 1::uint8;
SELECT 1::int2 <= 0::uint8;
SELECT 1::int2 <= 1::uint8;
SELECT 0::uint8 <= 1::int4;
SELECT 1::uint8 <= 0::int4;
SELECT 1::uint8 <= 1::int4;
SELECT 0::int4 <= 1::uint8;
SELECT 1::int4 <= 0::uint8;
SELECT 1::int4 <= 1::uint8;
SELECT 0::uint8 <= 1::int8;
SELECT 1::uint8 <= 0::int8;
SELECT 1::uint8 <= 1::int8;
SELECT 0::int8 <= 1::uint8;
SELECT 1::int8 <= 0::uint8;
SELECT 1::int8 <= 1::uint8;

SELECT 120::uint8 + 10::uint8;
SELECT 120::uint8 + 10::int2;
SELECT 18446744073709551615::uint8 + 1::int2;
SELECT 120::int2 + 10::uint8;
SELECT 32767::int2 + 1::uint8;
SELECT (-120)::int2 + 10::uint8;
SELECT 120::uint8 + 10::int4;
SELECT 18446744073709551615::uint8 + 1::int4;
SELECT 120::int4 + 10::uint8;
SELECT 2147483647::int4 + 1::uint8;
SELECT (-120)::int4 + 10::uint8;
SELECT 120::uint8 + 10::int8;
SELECT 18446744073709551615::uint8 + 1::int8;
SELECT 120::int8 + 10::uint8;
SELECT 9223372036854775807::int8 + 1::uint8;
SELECT (-120)::int8 + 10::uint8;

SELECT 120::uint8 - 10::uint8;
SELECT 120::uint8 - 10::int2;
SELECT 0::uint8 - 1::int2;
SELECT 120::int2 - 10::uint8;
SELECT (-32768)::int2 - 1::uint8;
SELECT (-120)::int2 - 10::uint8;
SELECT 120::uint8 - 10::int4;
SELECT 0::uint8 - 1::int4;
SELECT 120::int4 - 10::uint8;
SELECT (-2147483648)::int4 - 1::uint8;
SELECT (-120)::int4 - 10::uint8;
SELECT 120::uint8 - 10::int8;
SELECT 0::uint8 - 1::int8;
SELECT 120::int8 - 10::uint8;
SELECT (-9223372036854775808)::int8 - 1::uint8;
SELECT (-120)::int8 - 10::uint8;

SELECT 120::uint8 * 10::uint8;
SELECT 120::uint8 * 10::int2;
SELECT 18446744073709551615::uint8 * 2::int2;
SELECT 120::int2 * 10::uint8;
SELECT 32767::int2 * 2::uint8;
SELECT (-120)::int2 * 10::uint8;
SELECT 120::uint8 * 10::int4;
SELECT 18446744073709551615::uint8 * 2::int4;
SELECT 120::int4 * 10::uint8;
SELECT 2147483647::int4 * 2::uint8;
SELECT (-120)::int4 * 10::uint8;
SELECT 120::uint8 * 10::int8;
SELECT 18446744073709551615::uint8 * 2::int8;
SELECT 120::int8 * 10::uint8;
SELECT 9223372036854775807::int8 * 2::uint8;
SELECT (-120)::int8 * 10::uint8;

SELECT 120::uint8 / 10::uint8;
SELECT 120::uint8 / 10::int2;
SELECT 1::uint8 / 0::int2;
SELECT 120::int2 / 10::uint8;
SELECT 1::int2 / 0::uint8;
SELECT (-120)::int2 / 10::uint8;
SELECT 120::uint8 / 10::int4;
SELECT 1::uint8 / 0::int4;
SELECT 120::int4 / 10::uint8;
SELECT 1::int4 / 0::uint8;
SELECT (-120)::int4 / 10::uint8;
SELECT 120::uint8 / 10::int8;
SELECT 1::uint8 / 0::int8;
SELECT 120::int8 / 10::uint8;
SELECT 1::int8 / 0::uint8;
SELECT (-120)::int8 / 10::uint8;

SELECT 120::uint8 % 10::uint8;
SELECT 120::uint8 % 10::int2;
SELECT 1::uint8 % 0::int2;
SELECT 120::int2 % 10::uint8;
SELECT 1::int2 % 0::uint8;
SELECT (-120)::int2 % 10::uint8;
SELECT 120::uint8 % 10::int4;
SELECT 1::uint8 % 0::int4;
SELECT 120::int4 % 10::uint8;
SELECT 1::int4 % 0::uint8;
SELECT (-120)::int4 % 10::uint8;
SELECT 120::uint8 % 10::int8;
SELECT 1::uint8 % 0::int8;
SELECT 120::int8 % 10::uint8;
SELECT 1::int8 % 0::uint8;
SELECT (-120)::int8 % 10::uint8;

