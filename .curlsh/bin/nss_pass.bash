#!/bin/bash

URL=$1
USER=$2

PASS=$( nss-passwords -d "$CURLSH_NSS_PROFILE_DIR" "$URL"| grep "$USER" | cut -d '|' -f 4 | sed "s/^ *//" | sed "s/ *$//" )

if [ -n "$PASS" ]
then
    export PASS
fi
