#!/bin/bash

set -e

ZCOINCLI=${ZCOINCLI:-'zcoin-cli -testnet'}
ZERO='0'
ONE=1

i=$1
j=$(($2+$ONE))

while [ "$i" -lt "$j" ]
do
	hash=$($ZCOINCLI getblockhash $i)
	header=$($ZCOINCLI getblockheader $hash)
	chainwork=$(echo $header | jq -r '.chainwork')
	chainworkDec=$(printf "%d" 0x$chainwork)
	echo $i $hash $chainwork $chainworkDec
	i=$(($i+$ONE))
done
