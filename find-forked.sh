#!/bin/bash

set -e

ZCOINCLI=${ZCOINCLI:-'zcoin-cli -testnet'}
ZERO='0'

l=1
r=$($ZCOINCLI getblockcount)

function checkblock {
	(curl -sf https://testexplorer.zcoin.io/insight-api-zcoin/block/$1 > /dev/null && echo 0) || echo 1
}

while [ "$(($l+1))" -ne "$r" ]
do
	block=$(($l+$r));
	block=$(($block/2))
	hash=$($ZCOINCLI getblockhash $block)
	res=$(checkblock $hash)
	if [ $res = $ZERO  ]
	then
		l=$block
	else
		r=$block
	fi
done

echo last valid $l $($ZCOINCLI getblockhash $l)
echo forked at $r $($ZCOINCLI getblockhash $r)
