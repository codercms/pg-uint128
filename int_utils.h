#ifndef _INT_UTILS_H
#define _INT_UTILS_H

#include "postgres.h"

static inline int128* AllocInt128(int128 initial)
{
	int128* ptr = palloc(sizeof(int128));
	// Out of memory
	if (ptr == NULL) {
		return NULL;
	}

	*ptr = initial;

	return ptr;
}

#define Int128PGetDatum(X)		    PointerGetDatum(X)
#define PG_RETURN_INT128_P(X)		return Int128PGetDatum(X)
#define PG_RETURN_INT128(X)		    return Int128PGetDatum(AllocInt128(X))
#define DatumGetInt128P(X)		    ((int128 *) DatumGetPointer(X))
#define PG_GETARG_INT128_P(X)		DatumGetInt128P(PG_GETARG_DATUM(X))
#define PG_GETARG_INT128(X)		    *DatumGetInt128P(PG_GETARG_DATUM(X))

// Function to parse int128 from string
int parse_int128(const char *str, int128 *result);

// Function to convert int128 to a decimal string using Golang approach
// inspired by formatBits in strconv/itoa.go
char *int128_to_string_v2(int128 value, char *buffer, size_t buffer_size);

/*------------------------------------------------------------------------
 * Overflow routines for signed integers
 *------------------------------------------------------------------------
 */

/*
 * INT16
 */
static inline bool add_s16_overflow(int16 a, int16 b, int16 *result)
{
#if __has_builtin(__builtin_add_overflow)
    return __builtin_add_overflow(a, b, result);
#else
	int32		res = (int32) a + (int32) b;

	if (res > PG_INT16_MAX || res < PG_INT16_MIN)
	{
		*result = 0x5EED;		/* to avoid spurious warnings */
		return true;
	}
	*result = (int16) res;
	return false;
#endif
}

static inline bool sub_s16_overflow(int16 a, int16 b, int16 *result)
{
#if __has_builtin(__builtin_sub_overflow)
    return __builtin_sub_overflow(a, b, result);
#else
	int32		res = (int32) a - (int32) b;

	if (res > PG_INT16_MAX || res < PG_INT16_MIN)
	{
		*result = 0x5EED;		/* to avoid spurious warnings */
		return true;
	}
	*result = (int16) res;
	return false;
#endif
}

static inline bool mul_s16_overflow(int16 a, int16 b, int16 *result)
{
#if __has_builtin(__builtin_mul_overflow)
    return __builtin_mul_overflow(a, b, result);
#else
	int32		res = (int32) a * (int32) b;

	if (res > PG_INT16_MAX || res < PG_INT16_MIN)
	{
		*result = 0x5EED;		/* to avoid spurious warnings */
		return true;
	}
	*result = (int16) res;
	return false;
#endif
}

/*
 * INT32
 */
static inline bool add_s32_overflow(int32 a, int32 b, int32 *result)
{
#if __has_builtin(__builtin_add_overflow)
    return __builtin_add_overflow(a, b, result);
#else
	int64		res = (int64) a + (int64) b;

	if (res > PG_INT32_MAX || res < PG_INT32_MIN)
	{
		*result = 0x5EED;		/* to avoid spurious warnings */
		return true;
	}
	*result = (int32) res;
	return false;
#endif
}

static inline bool sub_s32_overflow(int32 a, int32 b, int32 *result)
{
#if __has_builtin(__builtin_sub_overflow)
    return __builtin_sub_overflow(a, b, result);
#else
	int64		res = (int64) a - (int64) b;

	if (res > PG_INT32_MAX || res < PG_INT32_MIN)
	{
		*result = 0x5EED;		/* to avoid spurious warnings */
		return true;
	}
	*result = (int32) res;
	return false;
#endif
}

static inline bool mul_s32_overflow(int32 a, int32 b, int32 *result)
{
#if __has_builtin(__builtin_mul_overflow)
    return __builtin_mul_overflow(a, b, result);
#else
	int64		res = (int64) a * (int64) b;

	if (res > PG_INT32_MAX || res < PG_INT32_MIN)
	{
		*result = 0x5EED;		/* to avoid spurious warnings */
		return true;
	}
	*result = (int32) res;
	return false;
#endif
}

/*
 * INT64
 */
static inline bool add_s64_overflow(int64 a, int64 b, int64 *result)
{
#if __has_builtin(__builtin_add_overflow)
    return __builtin_add_overflow(a, b, result);
#elif defined(HAVE_INT128)
	int128		res = (int128) a + (int128) b;

	if (res > PG_INT64_MAX || res < PG_INT64_MIN)
	{
		*result = 0x5EED;		/* to avoid spurious warnings */
		return true;
	}
	*result = (int64) res;
	return false;
#else
	if ((a > 0 && b > 0 && a > PG_INT64_MAX - b) ||
		(a < 0 && b < 0 && a < PG_INT64_MIN - b))
	{
		*result = 0x5EED;		/* to avoid spurious warnings */
		return true;
	}
	*result = a + b;
	return false;
#endif
}

static inline bool sub_s64_overflow(int64 a, int64 b, int64 *result)
{
#if __has_builtin(__builtin_sub_overflow)
    return __builtin_sub_overflow(a, b, result);
#elif defined(HAVE_INT128)
	int128		res = (int128) a - (int128) b;

	if (res > PG_INT64_MAX || res < PG_INT64_MIN)
	{
		*result = 0x5EED;		/* to avoid spurious warnings */
		return true;
	}
	*result = (int64) res;
	return false;
#else
	/*
	 * Note: overflow is also possible when a == 0 and b < 0 (specifically,
	 * when b == PG_INT64_MIN).
	 */
	if ((a < 0 && b > 0 && a < PG_INT64_MIN + b) ||
		(a >= 0 && b < 0 && a > PG_INT64_MAX + b))
	{
		*result = 0x5EED;		/* to avoid spurious warnings */
		return true;
	}
	*result = a - b;
	return false;
#endif
}

static inline bool mul_s64_overflow(int64 a, int64 b, int64 *result)
{
#if __has_builtin(__builtin_mul_overflow)
    return __builtin_mul_overflow(a, b, result);
#elif defined(HAVE_INT128)
	int128		res = (int128) a * (int128) b;

	if (res > PG_INT64_MAX || res < PG_INT64_MIN)
	{
		*result = 0x5EED;		/* to avoid spurious warnings */
		return true;
	}
	*result = (int64) res;
	return false;
#else
	/*
	 * Overflow can only happen if at least one value is outside the range
	 * sqrt(min)..sqrt(max) so check that first as the division can be quite a
	 * bit more expensive than the multiplication.
	 *
	 * Multiplying by 0 or 1 can't overflow of course and checking for 0
	 * separately avoids any risk of dividing by 0.  Be careful about dividing
	 * INT_MIN by -1 also, note reversing the a and b to ensure we're always
	 * dividing it by a positive value.
	 *
	 */
	if ((a > PG_INT32_MAX || a < PG_INT32_MIN ||
		 b > PG_INT32_MAX || b < PG_INT32_MIN) &&
		a != 0 && a != 1 && b != 0 && b != 1 &&
		((a > 0 && b > 0 && a > PG_INT64_MAX / b) ||
		 (a > 0 && b < 0 && b < PG_INT64_MIN / a) ||
		 (a < 0 && b > 0 && a < PG_INT64_MIN / b) ||
		 (a < 0 && b < 0 && a < PG_INT64_MAX / b)))
	{
		*result = 0x5EED;		/* to avoid spurious warnings */
		return true;
	}
	*result = a * b;
	return false;
#endif
}

/*
 * INT128
 */
static inline bool add_s128_overflow(int128 a, int128 b, int128 *result)
{
#if __has_builtin(__builtin_add_overflow)
    return __builtin_add_overflow(a, b, result);
#else
	// Not implemented
	*result = -1;
	return true;
#endif
}

static inline bool sub_s128_overflow(int128 a, int128 b, int128 *result)
{
#if __has_builtin(__builtin_sub_overflow)
    return __builtin_sub_overflow(a, b, result);
#else
	// Not implemented
	*result = -1;
	return true;
#endif
}

static inline bool mul_s128_overflow(int128 a, int128 b, int128 *result)
{
#if __has_builtin(__builtin_mul_overflow)
    return __builtin_mul_overflow(a, b, result);
#else
	// Not implemented
	*result = -1;
	return true;
#endif
}

#endif
