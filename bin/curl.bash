#!/bin/bash

AUTH_HOST=$1
REALM=$2
USER=$3
PASS=$4
HOST=$5
URL_PATH=$6
DATA_PATH=$7
VERB=$8
CLIENT_ID=$9

TOKEN=$(curl -d "client_id=${CLIENT_ID}" -d "username=$USER" -d "password=$PASS" -d 'grant_type=password' "${AUTH_HOST}/realms/$REALM/protocol/openid-connect/token" | jq '.access_token' | tr -d '"')

echo $TOKEN

echo ${HOST}/${URL_PATH}


curl -v -X "${VERB}" -H "Authorization: Bearer ${TOKEN}" -H  "accept: */*" -H  "Content-Type: application/json" --data "@${DATA_PATH}${URL_PATH}/${VERB}.json" "${HOST}/${URL_PATH}" 

/home/fabien/bin/backup.sh ${DATA_PATH}${URL_PATH}/${VERB}.json
