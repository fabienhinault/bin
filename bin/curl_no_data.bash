#!/bin/bash

AUTH_HOST=$1
REALM=$2
USER=$3
PASS=$4
HOST=$5
URL_PATH=$6
VERB=$7

TOKEN=$(curl -d 'client_id=web-devis' -d "username=$USER" -d "password=$PASS" -d 'grant_type=password' "${AUTH_HOST}/realms/$REALM/protocol/openid-connect/token" | jq '.access_token' | tr -d '"')

CSRF=$(curl -v -H  "accept: */*" "${HOST}/csrf" | jq ".token" | tr -d '"')

curl -v -X "${VERB}" -H "Authorization: Bearer ${TOKEN}" -H "X-XSRF-TOKEN: $CSRF" -H "Origin:$HOST" -H  "accept: */*" -H  "Content-Type: application/json" "${HOST}/${URL_PATH}" 
