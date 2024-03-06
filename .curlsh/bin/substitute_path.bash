#!/bin/bash

SUBSTITUTED_PATH=$1
shift
iSubst=0

while [ "$#" -gt "0" ]
do
    SUBSTITUTED_PATH=${SUBSTITUTED_PATH/_/$1}
    shift
    ((iSubst++)) || true
done
export SUBSTITUTED_PATH
