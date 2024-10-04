#ifndef _INT128_H
#define _INT128_H

#include "postgres.h"

static int int128_internal_cmp(const int128 *arg1, const int128 *arg2)
{
    if (*arg1 < *arg2) return -1; // arg1 is less than arg2
    if (*arg1 > *arg2) return 1; // arg1 is greater than arg2

    return 0; // arg1 is equal to arg2
}

#endif
