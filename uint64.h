#ifndef UINT64_H
#define UINT64_H

#include "postgres.h"

static int uint64_internal_cmp(const uint64 arg1, const uint64 arg2)
{
    if (arg1 < arg2) return -1; // arg1 is less than arg2
    if (arg1 > arg2) return 1; // arg1 is greater than arg2

    return 0; // arg1 is equal to arg2
}

#endif
