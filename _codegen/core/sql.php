<?php

declare(strict_types=1);

function genSqlExpectedPaddedValue(string $col, string $value, bool $padVal): string
{
    $maxLen = max(strlen($col), strlen($value));

    $sep = str_repeat("-", $maxLen + 2);

    $col   = " " . str_pad($col, $maxLen, pad_type: STR_PAD_BOTH) . " ";

    if ($padVal) {
        $value = " " . str_pad($value, $maxLen, pad_type: STR_PAD_LEFT);
    } else {
        $value = " " . $value;
    }

    return "$col\n$sep\n$value\n(1 row)\n\n";
}


function genSqlExpectedPaddedValues(string $col, array $values, bool $padVal): string
{
    $valsCnt = count($values);
    if ($valsCnt === 1) {
        return genSqlExpectedPaddedValue($col, $values[0], $padVal);
    }

    $valuesMaxLen = 0;
    foreach ($values as $value) {
        if (($valLen = strlen($value)) > $valuesMaxLen) {
            $valuesMaxLen = $valLen;
        }
    }

    $maxLen = max(strlen($col), $valuesMaxLen);

    $sep = str_repeat("-", $maxLen + 2);

    $col   = " " . str_pad($col, $maxLen, pad_type: STR_PAD_BOTH) . " ";

    $valuesStr = "";

    foreach ($values as $value) {
        if ($padVal) {
            $value = " " . str_pad($value, $maxLen, pad_type: STR_PAD_LEFT);
        } else {
            $value = " " . $value;
        }

        $valuesStr .= $value . "\n";
    }

    return "$col\n$sep\n$valuesStr($valsCnt rows)\n\n";
}
