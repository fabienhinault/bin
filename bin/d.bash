#!/bin/bash
# transforme un timestamp en date au format iso 8601
# exemple:
# $ d 1500000000000
# 2017-07-14T04:40:00+02:00

TS=$1
if (( TS > 1000000000000 ))
then
  TS=$(( $TS / 1000 ))
fi
date --iso-8601=seconds -d "@$TS"
