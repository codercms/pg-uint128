#include "uint_utils.h"

// Function to parse uint from string
#define DEFINE_PARSE_UINT_FUNC(uint, bitSize) \
    int parse_##uint(const char *str, uint *result) \
    { \
        size_t len = strlen(str); \
\
        for (size_t i = 0; i < len; i++) { \
            if (str[i] < '0' || str[i] > '9') { \
                return -1; \
            } \
\
            /* Shift left by 10 and add the new digit */ \
            /* *result * 10 + (str[i] - '0'); */ \
\
            if (mul_u##bitSize##_overflow(*result, 10, result)) { \
                /* Overflow detected */ \
                return -2; \
            } \
\
            if (add_u##bitSize##_overflow(*result, (str[i] - '0'), result)) { \
                /* Overflow detected */ \
                return -2; \
            } \
        } \
\
        return 0; \
    }

DEFINE_PARSE_UINT_FUNC(uint16, 16);
DEFINE_PARSE_UINT_FUNC(uint32, 32);
DEFINE_PARSE_UINT_FUNC(uint64, 64);
DEFINE_PARSE_UINT_FUNC(uint128, 128);


static const char *smallsString =
        "00" "01" "02" "03" "04" "05" "06" "07" "08" "09"
        "10" "11" "12" "13" "14" "15" "16" "17" "18" "19"
        "20" "21" "22" "23" "24" "25" "26" "27" "28" "29"
        "30" "31" "32" "33" "34" "35" "36" "37" "38" "39"
        "40" "41" "42" "43" "44" "45" "46" "47" "48" "49"
        "50" "51" "52" "53" "54" "55" "56" "57" "58" "59"
        "60" "61" "62" "63" "64" "65" "66" "67" "68" "69"
        "70" "71" "72" "73" "74" "75" "76" "77" "78" "79"
        "80" "81" "82" "83" "84" "85" "86" "87" "88" "89"
        "90" "91" "92" "93" "94" "95" "96" "97" "98" "99";


// Function to convert uint to a decimal string using Golang approach
// inspired by formatBits in strconv/itoa.go
#define DEFINE_UINT_TO_STRING_FUNC(uint, need_buf_size) \
    char* uint##_to_string(uint value, char *buffer, size_t buffer_size) \
    { \
        char *ptr; \
        \
        if (buffer_size < need_buf_size) { \
            return NULL; /* Not enough space */ \
        } \
        \
        ptr = buffer + buffer_size - 1; /* Start from the end of the buffer */ \
        *ptr = '\0'; /* Null-terminate the string */ \
        \
        /* Handle zero case explicitly */ \
        if (value == 0) { \
            *(--ptr) = '0'; \
            return ptr; \
        } \
        \
        /* Use a loop to process two digits at a time */ \
        while (value >= 100) { \
            uint8_t remainder = value % 100; /* Use uint8_t for remainder */ \
            value /= 100; \
            \
            /* Prepend the two digits to the string */ \
            ptr -= 2; \
            ptr[0] = smallsString[remainder * 2]; \
            ptr[1] = smallsString[remainder * 2 + 1]; \
        } \
        \
        /* Handle the last one or two digits */ \
        if (value < 10) { \
            *(--ptr) = (char) (value + '0'); /* For single-digit numbers */ \
        } else { \
            ptr -= 2; \
            ptr[0] = smallsString[value * 2]; \
            ptr[1] = smallsString[value * 2 + 1]; /* For two-digit numbers */ \
        } \
        \
        return ptr; /* Return the pointer to the start of the string */ \
    }

DEFINE_UINT_TO_STRING_FUNC(uint128, 41);
DEFINE_UINT_TO_STRING_FUNC(uint64, 21);
DEFINE_UINT_TO_STRING_FUNC(uint32, 11);
DEFINE_UINT_TO_STRING_FUNC(uint16, 6);
