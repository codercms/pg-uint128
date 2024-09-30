#include "postgres.h"
#include <access/hash.h>
#include <stdint.h>

#define INT128_MAX (__int128) (((unsigned __int128) 1 << ((__SIZEOF_INT128__ * __CHAR_BIT__) - 1)) - 1)
#define INT128_MIN (-INT128_MAX - 1)
#define UINT128_MAX ((2 * (unsigned __int128) INT128_MAX) + 1)

#define Uint128PGetDatum(X)		    PointerGetDatum(X)
#define PG_RETURN_Uint128_P(X)		return Uint128PGetDatum(X)
#define DatumGetUint128P(X)		    ((uint128 *) DatumGetPointer(X))
#define PG_GETARG_Uint128_P(X)		DatumGetUint128P(PG_GETARG_DATUM(X))

uint32_t Uint32LE(uint8_t*);
uint32_t Uint32BE(uint8_t*);
uint64_t Uint64LE(uint8_t*);
uint64_t Uint64BE(uint8_t*);
uint128 Uint128BE(uint8_t*);

void PutUint64BE(uint8_t* b, uint64_t v);

int parse_uint128(const char* str, uint128* result);

char* uint128_to_string(uint128 value, char* buffer, size_t buffer_size);
char* uint128_to_string_v2(uint128 value, char* buffer, size_t buffer_size);

// Swaps bytes in 64 bit int
// Linux byteswap.h impl
static inline uint64_t bswap_64(uint64_t x)
{
    return 
        (((x) & 0xff00000000000000ull) >> 56) |
        (((x) & 0x00ff000000000000ull) >> 40) |
        (((x) & 0x0000ff0000000000ull) >> 24) |
        (((x) & 0x000000ff00000000ull) >> 8)  |
        (((x) & 0x00000000ff000000ull) << 8)  |
        (((x) & 0x0000000000ff0000ull) << 24) |
        (((x) & 0x000000000000ff00ull) << 40) |
        (((x) & 0x00000000000000ffull) << 56);
}

static inline uint128 bswap_128 (uint128 x)
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

static inline uint128 le128toh(uint128 x) {
  #if BYTE_ORDER == LITTLE_ENDIAN
  // noop
  #elif BYTE_ORDER == BIG_ENDIAN
  return bswap_128(x);
  #endif

  return x;
}

static inline Datum hashuint8(uint64 val)
{
	uint32		lohalf = (uint32) val;
	uint32		hihalf = (uint32) (val >> 32);

	lohalf ^= hihalf;

	return hash_uint32(lohalf);
}
