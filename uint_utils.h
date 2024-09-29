#include "postgres.h"
#include <stdint.h>

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
