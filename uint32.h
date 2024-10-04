#ifndef UINT32_H
#define UINT32_H

#include "postgres.h"

static int uint32_internal_cmp(const uint32 arg1, const uint32 arg2)
{
    if (arg1 < arg2) return -1; // arg1 is less than arg2
    if (arg1 > arg2) return 1; // arg1 is greater than arg2

    return 0; // arg1 is equal to arg2
}

#endif
