<?php

declare(strict_types=1);

require_once __DIR__ . '/../core/index.php';

function genGenerateSeriesForType(Type $type): string
{
    $funcName = getGenSeriesFuncName($type);
    $stepFuncName = getGenSeriesStepFuncName($type);
    $supportFuncName = getGenSeriesSupportFuncName($type);

    $overflowFn = getOverflowFuncName($type, Op::Add);

    $code = <<<C
typedef struct
{
    $type->name		current;
    $type->name		finish;
    $type->name		step;
} generate_series_fctx;

PG_FUNCTION_INFO_V1($funcName);
PG_FUNCTION_INFO_V1($stepFuncName);
PG_FUNCTION_INFO_V1($supportFuncName);

/*
 * non-persistent numeric series generator
 */
Datum $funcName(PG_FUNCTION_ARGS)
{
	return $stepFuncName(fcinfo);
}

Datum $stepFuncName(PG_FUNCTION_ARGS)
{
	FuncCallContext *funcctx;
	generate_series_fctx *fctx;
	$type->name		result;
	MemoryContext oldcontext;

	/* stuff done only on the first call of the function */
	if (SRF_IS_FIRSTCALL())
	{
		$type->name		start = $type->pgGetArgMacro(0);
		$type->name		finish = $type->pgGetArgMacro(1);
		$type->name		step = 1;

		/* see if we were given an explicit step size */
		if (PG_NARGS() == 3)
			step = $type->pgGetArgMacro(2);
		if (step == 0)
			ereport(ERROR,
					(errcode(ERRCODE_INVALID_PARAMETER_VALUE),
					 errmsg("step size cannot equal zero")));

		/* create a function context for cross-call persistence */
		funcctx = SRF_FIRSTCALL_INIT();

		/*
		 * switch to memory context appropriate for multiple function calls
		 */
		oldcontext = MemoryContextSwitchTo(funcctx->multi_call_memory_ctx);

		/* allocate memory for user context */
		fctx = (generate_series_fctx *) palloc(sizeof(generate_series_fctx));

		/*
		 * Use fctx to keep state from call to call. Seed current with the
		 * original start value
		 */
		fctx->current = start;
		fctx->finish = finish;
		fctx->step = step;

		funcctx->user_fctx = fctx;
		MemoryContextSwitchTo(oldcontext);
	}

	/* stuff done on every call of the function */
	funcctx = SRF_PERCALL_SETUP();

	/*
	 * get the saved state and use current as the result for this iteration
	 */
	fctx = funcctx->user_fctx;
	result = fctx->current;

	if ((fctx->step > 0 && fctx->current <= fctx->finish) ||
		(fctx->step < 0 && fctx->current >= fctx->finish))
	{
		/*
		 * Increment current in preparation for next iteration. If next-value
		 * computation overflows, this is the final result.
		 */
		if ($overflowFn(fctx->current, fctx->step, &fctx->current))
			fctx->step = 0;

		/* do when there is more left to send */
		SRF_RETURN_NEXT(funcctx, $type->toDatum(result));
	}
	else
		/* do when there is no more left */
		SRF_RETURN_DONE(funcctx);
}

/*
 * Planner support function for generate_series($type->pgName, $type->pgName [, $type->pgName])
 */
Datum $supportFuncName(PG_FUNCTION_ARGS)
{
	Node	   *rawreq = (Node *) PG_GETARG_POINTER(0);
	Node	   *ret = NULL;

	if (IsA(rawreq, SupportRequestRows))
	{
		/* Try to estimate the number of rows returned */
		SupportRequestRows *req = (SupportRequestRows *) rawreq;

		if (is_funcclause(req->node))	/* be paranoid */
		{
			List	   *args = ((FuncExpr *) req->node)->args;
			Node	   *arg1,
					   *arg2,
					   *arg3;

			/* We can use estimated argument values here */
			arg1 = estimate_expression_value(req->root, linitial(args));
			arg2 = estimate_expression_value(req->root, lsecond(args));
			if (list_length(args) >= 3)
				arg3 = estimate_expression_value(req->root, lthird(args));
			else
				arg3 = NULL;

			/*
			 * If any argument is constant NULL, we can safely assume that
			 * zero rows are returned.  Otherwise, if they're all non-NULL
			 * constants, we can calculate the number of rows that will be
			 * returned.  Use double arithmetic to avoid overflow hazards.
			 */
			if ((IsA(arg1, Const) &&
				 ((Const *) arg1)->constisnull) ||
				(IsA(arg2, Const) &&
				 ((Const *) arg2)->constisnull) ||
				(arg3 != NULL && IsA(arg3, Const) &&
				 ((Const *) arg3)->constisnull))
			{
				req->rows = 0;
				ret = (Node *) req;
			}
			else if (IsA(arg1, Const) &&
					 IsA(arg2, Const) &&
					 (arg3 == NULL || IsA(arg3, Const)))
			{
				double		start,
							finish,
							step;

				start = $type->fromDatum(((Const *) arg1)->constvalue);
				finish = $type->fromDatum(((Const *) arg2)->constvalue);
				step = arg3 ? $type->fromDatum(((Const *) arg3)->constvalue) : 1;

				/* This equation works for either sign of step */
				if (step != 0)
				{
					req->rows = floor((finish - start + step) / step);
					ret = (Node *) req;
				}
			}
		}
	}

	PG_RETURN_POINTER(ret);
}
C;

    return $code;
}

$header = <<<C
// WARNING: This file is generated, do not edit

#include "postgres.h"
#include "int_utils.h"
#include "uint_utils.h"

#include "funcapi.h"
#include "nodes/supportnodes.h"
#include "nodes/nodeFuncs.h"
#include "optimizer/optimizer.h"

#include <math.h>

C;

@mkdir("series");

foreach ([...UINT_TYPES, INT128] as $LEFT_TYPE) {
    $buf = $header . "\n";

    $buf .= genGenerateSeriesForType($LEFT_TYPE) . "\n\n";

    $file = "series/{$LEFT_TYPE->name}.c";
    file_put_contents($file, $buf);
    echo "$file successfully generated\n";
}
