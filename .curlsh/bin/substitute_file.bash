#!/bin/bash


TMPDIR=$(mktemp --directory)
export CURLSH_SUBSTITUTED_FILE="$TMPDIR/${1##.*/}"
cp "$1" "$TMPFILE"

shift

iSubst=0
while [ "$#" -gt "0" ]
do
    sed --in-place=~$iSubst "s/\"{$iSubst}\"/$1/g" "$CURLSH_SUBSTITUTED_FILE"
    shift
    ((iSubst++)) || true
done

