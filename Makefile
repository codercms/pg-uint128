MODULES = uint128
EXTENSION = uint128
DATA = uint128--1.0.0.sql
REGRESS = test_uint8

MODULE_big = $(EXTENSION)
OBJS = magic.o uint128.o uint64.o uint_utils.o int_utils.o misc.o

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
