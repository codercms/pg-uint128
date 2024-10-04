#include "int_utils.h"

// Function to parse int128 from string
int parse_int128(const char *str, int128 *result)
{
    size_t len = strlen(str);
    bool is_negative = false;

    *result = 0;

    if (len == 0) {
        return 0;
    }

    // Check for negative sign
    if (str[0] == '-') {
        is_negative = true;
        str++;  // Move to the next character
        len--;
    } else if (str[0] == '+') {
        str++;  // Move to the next character
        len--;
    }

    for (size_t i = 0; i < len; i++) {
        if (str[i] < '0' || str[i] > '9') {
            return -1;
        }

        // Shift left by 10 and add the new digit
        *result = *result * 10 + (str[i] - '0');
    }

    if (is_negative) {
        *result = -(*result);
    }

    return 0;
}

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
char *int128_to_string_v2(int128 value, char *buffer, size_t buffer_size)
{
    char *ptr;
    bool is_negative = false;

    if (buffer_size < 41) {
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
