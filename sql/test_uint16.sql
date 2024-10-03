-- Testing uint16

-- Ops block

SELECT 1::uint16 = 1::uint16;
SELECT 1::uint16 = 0::uint16;
SELECT 1::uint16 = 1::int2;
SELECT 1::uint16 = 0::int2;
SELECT 1::uint16 = 1::int4;
SELECT 1::uint16 = 0::int4;
SELECT 1::uint16 = 1::int8;
SELECT 1::uint16 = 0::int8;

SELECT 1::uint16 <> 0::uint16;
SELECT 0::uint16 <> 0::uint16;
SELECT 1::uint16 <> 0::int2;
SELECT 0::uint16 <> 0::int2;
SELECT 1::uint16 <> 0::int4;
SELECT 0::uint16 <> 0::int4;
SELECT 1::uint16 <> 0::int8;
SELECT 0::uint16 <> 0::int8;

SELECT 1::uint16 > 0::uint16;
SELECT 0::uint16 > 1::uint16;
SELECT 1::uint16 > 0::int2;
SELECT 0::uint16 > 1::int2;
SELECT 1::uint16 > 0::int4;
SELECT 0::uint16 > 1::int4;
SELECT 1::uint16 > 0::int8;
SELECT 0::uint16 > 1::int8;

SELECT 0::uint16 < 1::uint16;
SELECT 1::uint16 < 0::uint16;
SELECT 0::uint16 < 1::int2;
SELECT 1::uint16 < 0::int2;
SELECT 0::uint16 < 1::int4;
SELECT 1::uint16 < 0::int4;
SELECT 0::uint16 < 1::int8;
SELECT 1::uint16 < 0::int8;

SELECT 1::uint16 >= 0::uint16;
SELECT 0::uint16 >= 1::uint16;
SELECT 1::uint16 >= 1::uint16;
SELECT 1::uint16 >= 0::int2;
SELECT 0::uint16 >= 1::int2;
SELECT 1::uint16 >= 1::int2;
SELECT 1::uint16 >= 0::int4;
SELECT 0::uint16 >= 1::int4;
SELECT 1::uint16 >= 1::int4;
SELECT 1::uint16 >= 0::int8;
SELECT 0::uint16 >= 1::int8;
SELECT 1::uint16 >= 1::int8;

SELECT 0::uint16 <= 1::uint16;
SELECT 1::uint16 <= 0::uint16;
SELECT 1::uint16 <= 1::uint16;
SELECT 0::uint16 <= 1::int2;
SELECT 1::uint16 <= 0::int2;
SELECT 1::uint16 <= 1::int2;
SELECT 0::uint16 <= 1::int4;
SELECT 1::uint16 <= 0::int4;
SELECT 1::uint16 <= 1::int4;
SELECT 0::uint16 <= 1::int8;
SELECT 1::uint16 <= 0::int8;
SELECT 1::uint16 <= 1::int8;

SELECT 120::uint16 + 10::uint16;
SELECT 120::uint16 + 10::int2;
SELECT 340282366920938463463374607431768211455::uint16 + 1::int2;
SELECT 120::uint16 + 10::int4;
SELECT 340282366920938463463374607431768211455::uint16 + 1::int4;
SELECT 120::uint16 + 10::int8;
SELECT 340282366920938463463374607431768211455::uint16 + 1::int8;

SELECT 120::uint16 - 10::uint16;
SELECT 120::uint16 - 10::int2;
SELECT 0::uint16 - 1::int2;
SELECT 120::uint16 - 10::int4;
SELECT 0::uint16 - 1::int4;
SELECT 120::uint16 - 10::int8;
SELECT 0::uint16 - 1::int8;

SELECT 120::uint16 * 10::uint16;
SELECT 120::uint16 * 10::int2;
SELECT 340282366920938463463374607431768211455::uint16 * 2::int2;
SELECT 120::uint16 * 10::int4;
SELECT 340282366920938463463374607431768211455::uint16 * 2::int4;
SELECT 120::uint16 * 10::int8;
SELECT 340282366920938463463374607431768211455::uint16 * 2::int8;

SELECT 120::uint16 / 10::uint16;
SELECT 120::uint16 / 10::int2;
SELECT 1::uint16 / 0::int2;
SELECT 120::uint16 / 10::int4;
SELECT 1::uint16 / 0::int4;
SELECT 120::uint16 / 10::int8;
SELECT 1::uint16 / 0::int8;

SELECT 120::uint16 % 10::uint16;
SELECT 120::uint16 % 10::int2;
SELECT 1::uint16 % 0::int2;
SELECT 120::uint16 % 10::int4;
SELECT 1::uint16 % 0::int4;
SELECT 120::uint16 % 10::int8;
SELECT 1::uint16 % 0::int8;

