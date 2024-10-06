<?php

declare(strict_types=1);

require_once __DIR__ . '/../core/index.php';

function genRangeFuncs(Type $type): string
{
    $subDiffFuncName = getRangeSubDiffFuncName($type);
    $canonicalFuncName = getRangeCanonicalFuncName($type);

    return <<<C
PG_FUNCTION_INFO_V1($subDiffFuncName);
Datum $subDiffFuncName(PG_FUNCTION_ARGS)
{
    $type->name		v1 = $type->pgGetArgMacro(0);
    $type->name		v2 = $type->pgGetArgMacro(1);

    PG_RETURN_FLOAT8((float8) v1 - (float8) v2);
}

PG_FUNCTION_INFO_V1($canonicalFuncName);
Datum $canonicalFuncName(PG_FUNCTION_ARGS)
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
        $type->name		bnd = $type->fromDatum(lower.val);

        /* Handle possible overflow manually */
        if (unlikely(bnd == {$type->getMaxConstC()}))
            OUT_OF_RANGE_ERR($type->pgName);
            // ereturn(escontext, (Datum) 0,
                    // (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                     // errmsg("bigint out of range")));
        lower.val = $type->toDatum(bnd + 1);
        lower.inclusive = true;
    }

    if (!upper.infinite && upper.inclusive)
    {
        $type->name		bnd = $type->fromDatum(upper.val);

        /* Handle possible overflow manually */
        if (unlikely(bnd == {$type->getMaxConstC()}))
            OUT_OF_RANGE_ERR($type->pgName);
            // ereturn(escontext, (Datum) 0,
                    // (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),
                     // errmsg("bigint out of range")));
        upper.val = $type->toDatum(bnd + 1);
        upper.inclusive = false;
    }

#if PG_VERSION_NUM >= 160000
    PG_RETURN_RANGE_P(range_serialize(typcache, &lower, &upper, false, escontext));
#else
    PG_RETURN_RANGE_P(range_serialize(typcache, &lower, &upper, false));
#endif
}
C;

}

$header = <<<C
// WARNING: This file is generated, do not edit

#include "postgres.h"

#if PG_VERSION_NUM >= 120000

#include "utils/rangetypes.h"

#include "uint_utils.h"
#include "int_utils.h"

C;

@mkdir("ranges");

foreach ([...UINT_TYPES, INT128] as $LEFT_TYPE) {
    $buf = $header . "\n";

    $buf .= genRangeFuncs($LEFT_TYPE) . "\n\n";

    $buf .= "#endif\n";

    $file = "ranges/{$LEFT_TYPE->name}.c";
    file_put_contents($file, $buf);
    echo "$file successfully generated\n";
}
