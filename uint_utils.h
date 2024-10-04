#ifndef UINT_UTILS_H
#define UINT_UTILS_H

#include "postgres.h"
#include <access/hash.h>
#include <stdint.h>

static inline uint128* AllocUint128(uint128 initial)
{
    uint128* ptr = palloc(sizeof(uint128));
    // Out of memory
    if (ptr == NULL) {
        return NULL;
    }

    *ptr = initial;

    return ptr;
}

#define INT128_MAX (__int128) (((unsigned __int128) 1 << ((__SIZEOF_INT128__ * __CHAR_BIT__) - 1)) - 1)
#define INT128_MIN (-INT128_MAX - 1)
#define UINT128_MAX ((2 * (unsigned __int128) INT128_MAX) + 1)

#define Uint128PGetDatum(X)		    PointerGetDatum(X)
#define PG_RETURN_UINT128_P(X)		return Uint128PGetDatum(X)
#define PG_RETURN_UINT128(X)		return Uint128PGetDatum(AllocUint128(X))
#define DatumGetUint128P(X)		    ((uint128 *) DatumGetPointer(X))
#define PG_GETARG_UINT128_P(X)		DatumGetUint128P(PG_GETARG_DATUM(X))
#define PG_GETARG_UINT128(X)		*DatumGetUint128P(PG_GETARG_DATUM(X))

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

#define UINT_DIVISION_BY_NEGATIVE_SIGNED_INT_ERR \
    ereport(ERROR, \
        ( \
            errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), \
            errmsg("unsigned int division/modulo by negative signed int is probhibited") \
        ) \
    )

#define UINT_MULTIPLY_BY_NEGATIVE_SIGNED_INT_ERR \
    ereport(ERROR, \
        ( \
            errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), \
            errmsg("unsigned int multiply by negative signed int is probhibited") \
        ) \
    )

#define OUT_OF_RANGE_ERR(pgtype) ereport(ERROR, \
    ( \
        errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), \
        errmsg(#pgtype " out of range") \
    ) \
);

#define OUT_OF_RANGE_ERR_WITH_SUFFIX(pgtype, suffix) ereport(ERROR, \
    ( \
        errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE), \
        errmsg(#pgtype " out of range" #suffix) \
    ) \
);

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

/*------------------------------------------------------------------------
 * Overflow routines for unsigned integers
 *------------------------------------------------------------------------
 */

/*
 * UINT16
 */

static inline bool add_u16_overflow(uint16 a, uint16 b, uint16 *result)
{
#if defined(HAVE__BUILTIN_OP_OVERFLOW)
    return __builtin_add_overflow(a, b, result);
#else
    uint16		res = a + b;

    if (res < a)
    {
        *result = 0x5EED;		/* to avoid spurious warnings */
        return true;
    }
    *result = res;
    return false;
#endif
}

static inline bool sub_u16_overflow(uint16 a, uint16 b, uint16 *result)
{
#if defined(HAVE__BUILTIN_OP_OVERFLOW)
    return __builtin_sub_overflow(a, b, result);
#else
    if (b > a)
    {
        *result = 0x5EED;		/* to avoid spurious warnings */
        return true;
    }
    *result = a - b;
    return false;
#endif
}

static inline bool mul_u16_overflow(uint16 a, uint16 b, uint16 *result)
{
#if defined(HAVE__BUILTIN_OP_OVERFLOW)
    return __builtin_mul_overflow(a, b, result);
#else
    uint32		res = (uint32) a * (uint32) b;

    if (res > PG_UINT16_MAX)
    {
        *result = 0x5EED;		/* to avoid spurious warnings */
        return true;
    }
    *result = (uint16) res;
    return false;
#endif
}

/*
 * UINT32
 */

static inline bool add_u32_overflow(uint32 a, uint32 b, uint32 *result)
{
#if defined(HAVE__BUILTIN_OP_OVERFLOW)
    return __builtin_add_overflow(a, b, result);
#else
    uint32		res = a + b;

    if (res < a)
    {
        *result = 0x5EED;		/* to avoid spurious warnings */
        return true;
    }
    *result = res;
    return false;
#endif
}

static inline bool sub_u32_overflow(uint32 a, uint32 b, uint32 *result)
{
#if defined(HAVE__BUILTIN_OP_OVERFLOW)
    return __builtin_sub_overflow(a, b, result);
#else
    if (b > a)
    {
        *result = 0x5EED;		/* to avoid spurious warnings */
        return true;
    }
    *result = a - b;
    return false;
#endif
}

static inline bool mul_u32_overflow(uint32 a, uint32 b, uint32 *result)
{
#if defined(HAVE__BUILTIN_OP_OVERFLOW)
    return __builtin_mul_overflow(a, b, result);
#else
    uint64		res = (uint64) a * (uint64) b;

    if (res > PG_UINT32_MAX)
    {
        *result = 0x5EED;		/* to avoid spurious warnings */
        return true;
    }
    *result = (uint32) res;
    return false;
#endif
}

/*
 * UINT64
 */

static inline bool add_u64_overflow(uint64 a, uint64 b, uint64 *result)
{
#if __has_builtin(__builtin_add_overflow)
    return __builtin_add_overflow(a, b, result);
#else
    uint64 res = a + b;

    // Check for overflow: If res is less than either a or b, overflow occurred
    if (res < a) {
        *result = 0; // Assign a dummy value to avoid warnings
        return true; // Overflow detected
    }

    *result = res;
    return false; // No overflow
#endif
}

static inline bool sub_u64_overflow(uint64 a, uint64 b, uint64 *result)
{
#if __has_builtin(__builtin_sub_overflow)
    return __builtin_sub_overflow(a, b, result);
#else
    if (b > a) {
        *result = 0; // Dummy value to avoid warnings
        return true; // Overflow detected
    }
    *result = a - b;
    return false; // No overflow
#endif
}

static inline bool mul_u64_overflow(uint64 a, uint64 b, uint64 *result)
{
#if __has_builtin(__builtin_mul_overflow)
    return __builtin_mul_overflow(a, b, result);
#elif defined(HAVE_INT128)
    uint128		res = (uint128) a * (uint128) b;

    if (res > PG_UINT64_MAX)
    {
        *result = 0x5EED;		/* to avoid spurious warnings */
        return true;
    }
    *result = (uint64) res;
    return false;
#else
    uint64		res = a * b;

    if (a != 0 && b != res / a)
    {
        *result = 0x5EED;		/* to avoid spurious warnings */
        return true;
    }
    *result = res;
    return false;
#endif
}

/*
 * UINT128
 */

static inline bool add_u128_overflow(uint128 a, uint128 b, uint128 *result)
{
#if __has_builtin(__builtin_add_overflow)
    return __builtin_add_overflow(a, b, result);
#else
    uint128 res = a + b;

    // Check for overflow: If res is less than either a or b, overflow occurred
    if (res < a) {
        *result = 0; // Assign a dummy value to avoid warnings
        return true; // Overflow detected
    }

    *result = res;
    return false; // No overflow
#endif
}

static inline bool sub_u128_overflow(uint128 a, uint128 b, uint128 *result)
{
#if __has_builtin(__builtin_sub_overflow)
    return __builtin_sub_overflow(a, b, result);
#else
    if (b > a) {
        *result = 0; // Dummy value to avoid warnings
        return true; // Overflow detected
    }
    *result = a - b;
    return false; // No overflow
#endif
}

static inline bool mul_u128_overflow(uint128 a, uint128 b, uint128 *result)
{
#if __has_builtin(__builtin_mul_overflow)
    return __builtin_mul_overflow(a, b, result);
#else
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
#endif
}

#endif
