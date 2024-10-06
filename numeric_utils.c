#include "postgres.h"
#include "utils/numeric.h"
#include "utils/builtins.h"
#include "uint_utils.h"
#include "int_utils.h"
#include "numeric_utils.h"

// LOCAL_FCINFO(numeric_in_fcinfo, 3);
//
// void static inline init_numeric_in()
// {
//     static bool initialized = false;
//
//     if (!initialized) {
//         // elog(INFO, "initializing numeric_in");
//
//         initialized = true;
//
//         InitFunctionCallInfoData(*numeric_in_fcinfo, NULL, 3, InvalidOid, NULL, NULL);
//
//         numeric_in_fcinfo->args[1] = (NullableDatum) { ObjectIdGetDatum(InvalidOid), false };
//         numeric_in_fcinfo->args[2] = (NullableDatum) { Int32GetDatum(-1), false };
//     }
// }

Numeric uint16_to_numeric(uint16 val, char* buf, size_t buffer_size)
{
    char *num_str = uint16_to_string(val, buf, buffer_size);

    return DatumGetNumeric(
        DirectFunctionCall3(
            numeric_in,
            CStringGetDatum(num_str),
            ObjectIdGetDatum(0),
            Int32GetDatum(-1)
        )
    );
}

Numeric uint32_to_numeric(uint32 val, char* buf, size_t buffer_size)
{
    char *num_str = uint32_to_string(val, buf, buffer_size);

    return DatumGetNumeric(
        DirectFunctionCall3(
            numeric_in,
            CStringGetDatum(num_str),
            ObjectIdGetDatum(0),
            Int32GetDatum(-1)
        )
    );
}

Numeric uint64_to_numeric(uint64 val, char* buf, size_t buffer_size)
{
    // init_numeric_in();

    // numeric_in_fcinfo->args[0] = (NullableDatum) { CStringGetDatum(num_str), false };

    // return DatumGetNumeric(numeric_in(numeric_in_fcinfo));

    char *num_str = uint64_to_string(val, buf, buffer_size);

    // Actually I don't see any minor performance difference between reuse of initialized function call context
    // and initializing new one everytime. So DirectFunctionCall is used, because it's much portable
    return DatumGetNumeric(
        DirectFunctionCall3(
            numeric_in,
            CStringGetDatum(num_str),
            ObjectIdGetDatum(0),
            Int32GetDatum(-1)
        )
    );
}

Numeric uint128_to_numeric(uint128 val, char* buf, size_t buffer_size)
{
    char *num_str = uint128_to_string(val, buf, buffer_size);

    return DatumGetNumeric(
        DirectFunctionCall3(
            numeric_in,
            CStringGetDatum(num_str),
            ObjectIdGetDatum(0),
            Int32GetDatum(-1)
        )
    );
}

Numeric int128_to_numeric(int128 val, char* buf, size_t buffer_size)
{
    char *num_str = int128_to_string(val, buf, buffer_size);

    return DatumGetNumeric(
        DirectFunctionCall3(
            numeric_in,
            CStringGetDatum(num_str),
            ObjectIdGetDatum(0),
            Int32GetDatum(-1)
        )
    );
}
