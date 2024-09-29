MODULES = uint128
EXTENSION = uint128
DATA = uint128--1.0.0.sql
#REGRESS = test

MODULE_big = $(EXTENSION)
OBJS = uint128.o uint_utils.o

PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
