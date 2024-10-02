#ifndef UINT_UTILS_H
#define UINT_UTILS_H

#include "postgres.h"
#include <access/hash.h>
#include <stdint.h>

#define INT128_MAX (__int128) (((unsigned __int128) 1 << ((__SIZEOF_INT128__ * __CHAR_BIT__) - 1)) - 1)
#define INT128_MIN (-INT128_MAX - 1)
#define UINT128_MAX ((2 * (unsigned __int128) INT128_MAX) + 1)

#define Uint128PGetDatum(X)		    PointerGetDatum(X)
#define PG_RETURN_UINT128_P(X)		return Uint128PGetDatum(X)
#define DatumGetUint128P(X)		    ((uint128 *) DatumGetPointer(X))
#define PG_GETARG_UINT128_P(X)		DatumGetUint128P(PG_GETARG_DATUM(X))

#ifndef PG_GETARG_UINT64
#define PG_GETARG_UINT64(n)  DatumGetUInt64(PG_GETARG_DATUM(n))
#endif


#define DIVISION_BY_ZERO_ERR \
    ereport(ERROR, \
        ( \
            errcode(ERRCODE_DIVISION_BY_ZERO), \
            errmsg("division by zero") \
        ) \
    )

#define OUT_OF_RANGE_ERR(pgtype) ereport(ERROR, \
    ( \
        errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), \
        errmsg(#pgtype " out of range") \
    ) \
);

uint32_t Uint32LE(uint8_t *);

uint32_t Uint32BE(uint8_t *);

uint64_t Uint64LE(uint8_t *);

uint64_t Uint64BE(uint8_t *);

uint128 Uint128BE(uint8_t *);

void PutUint64BE(uint8_t *b, uint64_t v);

int parse_uint128(const char *str, uint128 *result);

int parse_uint64(const char *str, uint64 *result);

char *uint128_to_string(uint128 value, char *buffer, size_t buffer_size);

char *uint128_to_string_v2(uint128 value, char *buffer, size_t buffer_size);

char *uint64_to_string_v2(uint64 value, char *buffer, size_t buffer_size);

// Swaps bytes in 64 bit int
// Linux byteswap.h impl
static inline uint64_t bswap_64(uint64_t x)
{
    return
            (((x) & 0xff00000000000000ull) >> 56) |
            (((x) & 0x00ff000000000000ull) >> 40) |
            (((x) & 0x0000ff0000000000ull) >> 24) |
            (((x) & 0x000000ff00000000ull) >> 8) |
            (((x) & 0x00000000ff000000ull) << 8) |
            (((x) & 0x0000000000ff0000ull) << 24) |
            (((x) & 0x000000000000ff00ull) << 40) |
            (((x) & 0x00000000000000ffull) << 56);
}

static inline uint128 bswap_128(uint128 x)
{
    uint64_t hi = (uint64_t) (x >> 64);
    uint64_t lo = (uint64_t) x;

    return ((uint128) bswap_64(lo)) << 64 | (uint128) bswap_64(hi);
}

/* --- 128-bit equivalents to man (3) endian --- */

static inline uint128 htobe128(uint128 x)
{
#if BYTE_ORDER == BIG_ENDIAN
    // noop
#elif BYTE_ORDER == LITTLE_ENDIAN
    x = bswap_128(x);
#endif

    return x;
}

static inline uint128 htole128(uint128 x)
{
#if BYTE_ORDER == LITTLE_ENDIAN
    // noop
#elif BYTE_ORDER == BIG_ENDIAN
    return bswap_128(x);
#endif

    return x;
}

static inline uint128 be128toh(uint128 x)
{
#if BYTE_ORDER == BIG_ENDIAN
    // noop
#elif BYTE_ORDER == LITTLE_ENDIAN
    return bswap_128(x);
#endif

    return x;
}

static inline uint128 le128toh(uint128 x)
{
#if BYTE_ORDER == LITTLE_ENDIAN
    // noop
#elif BYTE_ORDER == BIG_ENDIAN
  return bswap_128(x);
#endif

    return x;
}

static inline Datum hashuint8(uint64 val)
{
    uint32 lohalf = (uint32) val;
    uint32 hihalf = (uint32) (val >> 32);

    lohalf ^= hihalf;

    return hash_uint32(lohalf);
}

static inline bool add_u128_overflow(uint128 a, uint128 b, uint128 *result)
{
    uint128 res = a + b;

    // Check for overflow: If res is less than either a or b, overflow occurred
    if (res < a) {
        *result = 0; // Assign a dummy value to avoid warnings
        return true; // Overflow detected
    }

    *result = res;
    return false; // No overflow
}

static inline bool sub_u128_overflow(uint128 a, uint128 b, uint128 *result)
{
    if (b > a) {
        *result = 0; // Dummy value to avoid warnings
        return true; // Overflow detected
    }
    *result = a - b;
    return false; // No overflow
}

static inline bool mul_u128_overflow(uint128 a, uint128 b, uint128 *result)
{
    if (a == 0 || b == 0) {
        *result = 0; // No overflow, product is zero
        return false;
    }

    // Check for overflow: If a > UINT128_MAX / b, overflow occurred
    if (a > (uint128) -1 / b) {
        *result = 0; // Assign a dummy value to avoid warnings
        return true; // Overflow detected
    }

    *result = a * b;
    return false; // No overflow
}

static inline bool add_u64_overflow(uint64 a, uint64 b, uint64 *result)
{
    uint64 res = a + b;

    // Check for overflow: If res is less than either a or b, overflow occurred
    if (res < a) {
        *result = 0; // Assign a dummy value to avoid warnings
        return true; // Overflow detected
    }

    *result = res;
    return false; // No overflow
}

static inline bool sub_u64_overflow(uint64 a, uint64 b, uint64 *result)
{
    if (b > a) {
        *result = 0; // Dummy value to avoid warnings
        return true; // Overflow detected
    }
    *result = a - b;
    return false; // No overflow
}

static inline bool mul_u64_overflow(uint64 a, uint64 b, uint64 *result)
{
    if (a == 0 || b == 0) {
        *result = 0; // No overflow, product is zero
        return false;
    }

    // Check for overflow: If a > UINT128_MAX / b, overflow occurred
    if (a > (uint64) -1 / b) {
        *result = 0; // Assign a dummy value to avoid warnings
        return true; // Overflow detected
    }

    *result = a * b;
    return false; // No overflow
}

#endif
