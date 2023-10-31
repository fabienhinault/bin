#!/bin/bash

AUTH_URL=$1
USER=$2
HOST=$3
URL_PATH=$4
VERB=$5

if [ -z "$PASS" ]
then
    read -sp "$USER's password" PASS
    export PASS
    echo
fi

if [ -z "$SECRET" ]
then
    read -sp "client secret" SECRET
    export SECRET
    echo
fi


TOKEN=$(curl -d 'client_id=client' -d "username=$USER" -d "password=$PASS" -d 'grant_type=password' "${AUTH_HOST}/realms/$REALM/protocol/openid-connect/token" | jq '.access_token' | tr -d '"')

CSRF=$(curl -v -H  "accept: */*" "${HOST}/csrf" | jq ".token" | tr -d '"')

curl -v -X "${VERB}" -H "Authorization: Bearer ${TOKEN}" -H "X-XSRF-TOKEN: $CSRF" -H "Origin:$HOST" -H  "accept: */*" -H  "Content-Type: application/json" "${HOST}/${URL_PATH}" 
