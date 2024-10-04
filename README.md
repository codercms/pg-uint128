# pg-uint128
PostgreSQL extension that adds native uint128 support

## Features
* Provides multiple unsigned types:
  * uint16 (uint128)
  * int16 (int128)
  * uint8 (uint64)
* Binary send/recv support
* Casts to uint16, uint8, int2, int4, int8, int16, numeric, real, double, uuid (only uint16)
* Mixed type arithmetic support (signed -> unsigned and unsigned -> signed)
* Indexing support for BTREE and HASH indexes
* Rich operators set:
  * \+ - ADD (Addition)
  * \- - SUB (Subtract)
  * \* - MUL (Multiply)
  * \/ - DIV (Divide)
  * \% - MOD (Modulo)
  * \# - Bitwise XOR
  * \& - Bitwise AND
  * \| - Bitwise OR
  * \~ - Bitwise NOT
  * \<< - Bitwise SHL (shift left)
  * \>> - Bitwise SHR (shift right)
* Comparison operators set:
  * = - EQ (Equal)
  * \<> (!=) - NE (Not Equal)
  * \> - GT (Greater Than)
  * \< - LT (Less Than)
  * \>= - GE (Greater Than or Equal)
  * \<= - LE (Less Than or Equal)

## Mixed type arithmetic
Mixed type arithmetic between signed and unsigned integer types is quite complex because of different representation for signed and unsigned types.

Signed integer ranges:

    Int8 (int1)    — [-128 : 127]
    Int16 (int2)   — [-32768 : 32767]
    Int32 (int4)   — [-2147483648 : 2147483647]
    Int64 (int8)   — [-9223372036854775808 : 9223372036854775807]
    Int128 (int16) — [-170141183460469231731687303715884105728 : 170141183460469231731687303715884105727]

Unsigned integer ranges:

    UInt8 (uint1)    — [0 : 255]
    UInt16 (uint2)   — [0 : 65535]
    UInt32 (uint4)   — [0 : 4294967295]
    UInt64 (uint8)   — [0 : 18446744073709551615]
    UInt128 (uint16) — [0 : 340282366920938463463374607431768211455]

From binary point of view UINT8_MAX (255) becomes -1 for signed 8bit integer, UINT 254 becomes -2 for signed 8bit integer and so on.

This extension tries to solve this unexpected behavior by preventing overflow and underflow in arithmetic operations between signed and unsigned types.

### Arithmetic
* Addition
  * With signed int dominance - `SELECT 9223372036854775807::int8 + 9223372036854775807::uint8;` will result in error `int8 out of range`
  * With unsigned int dominance - `SELECT 9223372036854775807::uint8 + 9223372036854775807::int8;` will result in `18446744073709551614`
  * 
  * With signed int dominance - `SELECT (-120)::int4 + 10::uint8;` will result in `-110`
  * With unsigned int dominance - `SELECT 10::uint8 + (-120)::int4;` will result in error `uint8 out of range`, because unsigned integer cannot represent negative values
  * With unsigned int dominance - `SELECT 10::uint8 + (-10)::int4;` will result in `0`
* Subtraction
  * With signed int dominance - `SELECT (-120)::int4 - 10::uint8;` will result in `-130`
  * With unsigned int dominance - `SELECT 10::uint8 - (-120)::int4;` will result in `130`
  * With unsigned int dominance - `SELECT 10::uint8 - (120)::int4;` will result in in error `uint8 out of range`, because unsigned integer cannot represent negative values
* Multiplication
  * With signed int dominance - `SELECT (-120)::int4 * 10::uint8;` with result in `-1200`
  * With unsigned int dominance - `SELECT 10::uint8 * (-120)::int4;` will result in error `unsigned int multiply by negative signed int is probhibited`, because unsigned integer cannot represent negative values
  * With unsigned int dominance - `SELECT 120::uint8 * 10::int4;` will result in `1200`
* Division
  * With signed int dominance - `SELECT (-120)::int4 / 10::uint8;` will result in `-12`
  * With unsigned int dominance - `SELECT 10::uint8 / (-120)::int4;` will result in error `unsigned int division/modulo by negative signed int is probhibited`, because unsigned integer cannot represent negative values
  * With unsigned int dominance - `SELECT 120::uint8 / 10::int4;` will result in `12`
* Modulo
  * With signed int dominance - `SELECT (-3)::int4 % 2::uint8;` will result in `-1`
  * With unsigned int dominance - `SELECT 3::uint8 % (-2)::int4;` will result in error `unsigned int division/modulo by negative signed int is probhibited`, because unsigned integer cannot represent negative values
  * With unsigned int dominance - `SELECT 3::uint8 % 2::int4;` will result in `1`

### Bitwise arithmetic
Bitwise arithmetic between signed and unsigned integer types is allowed for all kind of operations without any restrictions, so use it with caution.


## Build
### Linux
* Add PostgreSQL repository to your package manager, e.g. see this for Ubuntu https://www.postgresql.org/download/linux/ubuntu/
* Install PostgreSQL version you want, e.g. `sudo apt-get install postgresql-15`
* Install PostgreSQL dev headers, e.g. `sudo apt-get install postgresql-server-dev-15`
* Install build tools `sudo apt-get install build-essentials`
* Clone repository `git clone https://github.com/codercms/pg-uint128.git && cd pg-uint128`
* Compile extension `make`
* Copy extension files to pg catalogs `sudo make install`

### Windows
* Install `MSYS2` from https://www.msys2.org/
* Launch MINGW64 console and execute following commands:
    * `pacman -U https://repo.msys2.org/mingw/mingw64/mingw-w64-x86_64-postgresql-15.3-3-any.pkg.tar.zst` (use your PostgreSQL version here)
    * `pacman --needed -S git mingw-w64-x86_64-gcc base-devel`
    * `git clone https://github.com/codercms/pg-uint128.git && cd pg-uint128`

Then run `make` and copy those files to `POSTGRES_PATH\share\extension` (e.g. `C:\Program Files\PostgreSQL\15\share\extension`):
* `uint128.control`
* `uint128*.sql`

And copy `uint128.dll` to `POSTGRES_PATH\lib` (e.g. `C:\Program Files\PostgreSQL\15\lib`)

## Testing
**Make sure you run tests on the build environment database, not on the production one.**

* Create PostgreSQL user to run tests `CREATE USER uint128_test WITH PASSWORD 'test-suite';`
* Grant superuser role to newly created user `ALTER ROLE uint128_test SUPERUSER;`
* Run `make PGHOST=127.0.0.1 PGUSER=uint128_test PGPASSWORD=test-suite installcheck`

## Installation
Open psql console from postgres superuser and run on database you want - `CREATE EXTENSION uint128;`
