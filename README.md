# pg-uint128
A PostgreSQL extension that adds native support for unsigned integers and 128-bit signed/unsigned integer types.

## Features
* Provides multiple unsigned types:
  * `uint2` (uint16)
  * `uint4` (uint32)
  * `uint8` (uint64)
  * `uint16` (uint128)
* Provides signed 128-bit integer type:
  * `int16` (int128)
* Provides corresponding range (and multi range) types with GIST indexing support:
  * `uint2range`, `uint2multirange`
  * `uint4range`, `uint4multirange`
  * `uint8range`, `uint8multirange`
  * `uint16range`, `uint16multirange`
  * `int16range`, `int16multirange`
* Binary send/recv support
* Casts to `uint16`, `uint8`, `uint4`, `uint2`, `int16`, `int8`, `int4`, `int2`, `numeric`, `real`, `double`, `uuid` (for `uint16` only)
* Mixed-type arithmetic support (signed ↔ unsigned)
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
* Comprehensive set of comparison operators:
  * = - EQ (Equal)
  * \<> (!=) - NE (Not Equal)
  * \> - GT (Greater Than)
  * \< - LT (Less Than)
  * \>= - GE (Greater Than or Equal)
  * \<= - LE (Less Than or Equal)
* Aggregation support:
  * SUM
  * AVG
  * MIN
  * MAX
  *
  * **Note on SUM/AVG Aggregation**: These aggregations are performed using PostgreSQL's numeric type to minimize the risk of overflow.  
    While this approach ensures precision, it may not be the most efficient in terms of performance, as it relies on PostgreSQL's numeric type calculations rather than CPU-native operations.  
    The maximum precision of the aggregates is limited by PostgreSQL's numeric type precision.
* `generate_series` support for each type (`SELECT * FROM generate_series(1::uint4, 10::uint4);`)

## Mixed type arithmetic
Mixed-type arithmetic between signed and unsigned integer types is complex due to the different representations used for each.

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

From a binary perspective, `UINT8_MAX` (255) becomes `-1` for a signed 8-bit integer, `UINT 254` becomes `-2`, and so on.

This extension addresses potential overflow and underflow during arithmetic operations between signed and unsigned types.

### Arithmetic
* Addition
  * Signed int dominant - `SELECT 9223372036854775807::int8 + 9223372036854775807::uint8;` → `int8 out of range`
  * Unsigned int dominant - `SELECT 9223372036854775807::uint8 + 9223372036854775807::int8;` → `18446744073709551614`
  * 
  * Signed int dominant - `SELECT (-120)::int4 + 10::uint8;` → `-110`
  * Unsigned int dominant - `SELECT 10::uint8 + (-120)::int4;` → `uint8 out of range`, because unsigned integer cannot represent negative values
  * Unsigned int dominant - `SELECT 10::uint8 + (-10)::int4;` → `0`
* Subtraction
  * Signed int dominant - `SELECT (-120)::int4 - 10::uint8;` → `-130`
  * Unsigned int dominant - `SELECT 10::uint8 - (-120)::int4;` → `130`
  * Unsigned int dominant - `SELECT 10::uint8 - (120)::int4;` → `uint8 out of range`, because unsigned integer cannot represent negative values
* Multiplication
  * Signed int dominant - `SELECT (-120)::int4 * 10::uint8;` → `-1200`
  * Unsigned int dominant - `SELECT 10::uint8 * (-120)::int4;` → `unsigned int multiply by negative signed int is probhibited`, because unsigned integer cannot represent negative values
  * Unsigned int dominant - `SELECT 120::uint8 * 10::int4;` → `1200`
* Division
  * Signed int dominant - `SELECT (-120)::int4 / 10::uint8;` → `0` (because negative int is always less than uint)
  * Unsigned int dominant - `SELECT 10::uint8 / (-120)::int4;` → `unsigned int division/modulo by negative signed int is probhibited`, because unsigned integer cannot represent negative values
  * Unsigned int dominant - `SELECT 120::uint8 / 10::int4;` → `12`
* Modulo
  * Signed int dominant - `SELECT (-3)::int4 % 2::uint8;` → `-3` (because negative int is always less than int)
  * Unsigned int dominant - `SELECT 3::uint8 % (-2)::int4;` → `unsigned int division/modulo by negative signed int is probhibited`, because unsigned integer cannot represent negative values
  * Unsigned int dominant - `SELECT 3::uint8 % 2::int4;` → `1`


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
