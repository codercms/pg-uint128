# pg-uint128
PostgreSQL extension that adds native uint128 support

## Features
* Casts to int2, int4, int8, numeric, real, double, uuid
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
