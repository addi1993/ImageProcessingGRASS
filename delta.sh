#!/bin/bash

output=$1
etalonmap=$2
#regexp='[-+]?[0-9]*\.?[0-9]+'
regexp='[-+]?[0-9]*\.'
r.mapcalc "err = abs("$output" - "$etalonmap")"
delta=$(r.sum err)
if [[ "$delta" =~ $regexp ]]; then
	res="${BASH_REMATCH%?}"
	echo $res;
fi	
