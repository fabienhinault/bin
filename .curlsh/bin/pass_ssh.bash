#!/bin/bash

if [ "$AUTH_USER" = "admin" ]
then
    if [[ "$HOST" = auth.* ]]
    then
        PATTERN=...
    else
        PATTERN=...
    fi
fi
if [ "$AUTH_USER" = "user" ]
then
    PATTERN=...
fi
PASS=$(ssh -I $CURLSH_AUTH_PASS_SSH_KEY $CURLSH_AUTH_PASS_SSH_HOST grep "$PATTERN" | tail -n 1 | sed ...)

