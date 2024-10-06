#ifndef NUMERIC_UTILS_H
#define NUMERIC_UTILS_H

#include "utils/numeric.h"

Numeric uint16_to_numeric(uint16 val, char* buf, size_t buf_len);
Numeric uint32_to_numeric(uint32 val, char* buf, size_t buf_len);
Numeric uint64_to_numeric(uint64 val, char* buf, size_t buf_len);
Numeric uint128_to_numeric(uint128 val, char* buf, size_t buf_len);

Numeric int128_to_numeric(int128 val, char* buf, size_t buf_len);

#endif //NUMERIC_UTILS_H
