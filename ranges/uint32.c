// WARNING: This file is generated, do not edit

#include "postgres.h"

#if PG_VERSION_NUM >= 120000

#include "utils/rangetypes.h"

#include "uint_utils.h"
#include "int_utils.h"

PG_FUNCTION_INFO_V1(uint4_range_subdiff);
Datum uint4_range_subdiff(PG_FUNCTION_ARGS)
{
    uint32		v1 = PG_GETARG_UINT32(0);
    uint32		v2 = PG_GETARG_UINT32(1);

    PG_RETURN_FLOAT8((float8) v1 - (float8) v2);
}

PG_FUNCTION_INFO_V1(uint4_range_canonical);
Datum uint4_range_canonical(PG_FUNCTION_ARGS)
{
    RangeType  *r = PG_GETARG_RANGE_P(0);
#if PG_VERSION_NUM >= 160000
    Node	   *escontext = fcinfo->context;
#endif
    TypeCacheEntry *typcache;
    RangeBound	lower;
    RangeBound	upper;
    bool		empty;

    typcache = range_get_typcache(fcinfo, RangeTypeGetOid(r));

    range_deserialize(typcache, r, &lower, &upper, &empty);

    if (empty)
        PG_RETURN_RANGE_P(r);

    if (!lower.infinite && !lower.inclusive)
    {
        uint32		bnd = DatumGetUInt32(lower.val);

        /* Handle possible overflow manually */
        if (unlikely(bnd == UINT32_MAX))
            OUT_OF_RANGE_ERR(uint4);
            // ereturn(escontext, (Datum) 0,
                    // (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                     // errmsg("bigint out of range")));
        lower.val = UInt32GetDatum(bnd + 1);
        lower.inclusive = true;
    }

    if (!upper.infinite && upper.inclusive)
    {
        uint32		bnd = DatumGetUInt32(upper.val);

        /* Handle possible overflow manually */
        if (unlikely(bnd == UINT32_MAX))
            OUT_OF_RANGE_ERR(uint4);
            // ereturn(escontext, (Datum) 0,
                    // (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                     // errmsg("bigint out of range")));
        upper.val = UInt32GetDatum(bnd + 1);
        upper.inclusive = false;
    }

#if PG_VERSION_NUM >= 160000
    PG_RETURN_RANGE_P(range_serialize(typcache, &lower, &upper, false, escontext));
#else
    PG_RETURN_RANGE_P(range_serialize(typcache, &lower, &upper, false));
#endif
}

#endif
