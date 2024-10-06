#include "int_utils.h"
#include "uint_utils.h"

// Function to parse int128 from string
int parse_int128(const char *str, int128 *result)
{
    size_t len = strlen(str);
    bool is_negative = false;
    int uint_res = 0;

    *result = 0;

    if (len == 0) {
        return 0;
    }

    // Check for negative sign
    if (str[0] == '-') {
        is_negative = true;
        str++;  // Move to the next character
    } else if (str[0] == '+') {
        str++;  // Move to the next character
    }

    if ((uint_res = parse_uint128(str, (uint128 *)result)) != 0) {
        // Overflow detected
        return uint_res;
    };

    if (is_negative) {
        // If result equals INT128_MIN, we can't safely negate it
        if (*(uint128*)result > (uint128)INT128_MAX + 1ULL) {
            // Detected overflow if the unsigned value is larger than INT128_MAX + 1
            return -3;
        }

        // Safely negate the result
        *result = -(*result);

        return 0;
    }

    // Check if the value parsed exceeds INT128_MAX (positive overflow)
    if (*(uint128*)result > INT128_MAX) {
        return -3;  // Overflow detected for positive range
    }

    return 0;
}

static const char *int128_min_str = "-170141183460469231731687303715884105728";

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

// Function to convert int128 to a decimal string using Golang approach
// inspired by formatBits in strconv/itoa.go
char *int128_to_string(int128 value, char *buffer, size_t buffer_size)
{
    char *ptr;
    bool is_negative = false;

    if (buffer_size < INT128_STRBUFLEN) {
        return NULL; // Not enough space
    }

    ptr = buffer + buffer_size - 1; // Start from the end of the buffer
    *ptr = '\0'; // Null-terminate the string

    // Handle zero case explicitly
    if (value == 0) {
        *(--ptr) = '0';
        return ptr;
    }

    // Check if the number is negative
    if (value < 0) {
        // Special case for INT128_MIN
        if (value == INT128_MIN) {
            // Write the string representation of INT128_MIN directly
            size_t len = strlen(int128_min_str);

            // Adjust ptr to point to where the number will go
            ptr -= len;
            strcpy(ptr, int128_min_str);

            return ptr;
        }

        is_negative = true;
        value = -value; // Make it positive for processing
    }

    // Use a loop to process two digits at a time
    while (value >= 100) {
        uint8_t remainder = value % 100; // Use uint8_t for remainder
        value /= 100;

        // Prepend the two digits to the string
        ptr -= 2;
        ptr[0] = smallsString[remainder * 2];
        ptr[1] = smallsString[remainder * 2 + 1];
    }

    // Handle the last one or two digits
    if (value < 10) {
        *(--ptr) = (char) (value + '0'); // For single-digit numbers
    } else {
        ptr -= 2;
        ptr[0] = smallsString[value * 2];
        ptr[1] = smallsString[value * 2 + 1]; // For two-digit numbers
    }

    // Add negative sign if the number is negative
    if (is_negative) {
        *(--ptr) = '-';
    }

    return ptr; // Return the pointer to the start of the string
}
