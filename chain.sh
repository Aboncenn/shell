#!/bin/bash


CHAIN=$1
if [ "$CHAIN" = "" ]
then
	echo "error: <chain> is missing"
	exit 1
fi

HOPS=$(echo $CHAIN | awk -F "," '{ print nf - 1 }')

if [ $HOPS -gt 10 ]
then
	echo "Il y à eu 10 sauts ou plus: on termine"
	exit 0
fi

CHAIN="$CHAIN$(whoami),"


NBLINE=$(wc -l < ip.lst)
RDMLINE=$(($RANDOM % $NBLINE + 1))
IP=$(sed -n "$RDMLINE p" ip.lst)

echo "$CHAIN"
echo "result: ($IP)"

ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -q $IP ./chain.sh $CHAIN 
