MODULES = uint128
EXTENSION = uint128
DATA = uint128--1.0.0.sql
REGRESS = create_ext test_uint8 test_uint16 test_int16

MODULE_big = $(EXTENSION)
OBJS = magic.o uint128.o uint64.o int128.o uint_utils.o int_utils.o \
	cmp/int16.o cmp/int32.o cmp/int64.o cmp/int128.o \
	cmp/uint16.o cmp/uint32.o cmp/uint64.o cmp/uint128.o \
	arithm/int16.o arithm/int32.o arithm/int64.o arithm/int128.o \
	arithm/uint16.o arithm/uint32.o arithm/uint64.o arithm/uint128.o \
	bitwise/int128.o \
	bitwise/uint16.o bitwise/uint32.o bitwise/uint64.o bitwise/uint128.o

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)

# Generates both C and SQL code
gen:
	php codegen.php

# Generates only C code
gen-c:
	php codegen.php --c-only

# Generates only SQL code
gen-sql:
	php codegen.php --sql-only

