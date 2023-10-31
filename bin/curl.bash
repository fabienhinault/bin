#!/bin/bash

set -euo pipefail

AUTH_URL=$1
shift
USER=$1
shift
HOST=$1
shift
URL_PATH=$1
SUBSTITUTED_PATH=$URL_PATH
shift
DATA_PATH=$1
shift
VERB=$1
shift

TMPDIR=$(mktemp --directory)
cp "${DATA_PATH}/${URL_PATH}/${VERB}.json" "$TMPDIR/${VERB}.json"

iSubst=0
while [ "$#" -gt "0" ]
do
    SUBSTITUTED_PATH=${SUBSTITUTED_PATH/_/$1}
    sed --in-place=~$iSubst "s/\"{$iSubst}\"/$1/g" "$TMPDIR/${VERB}.json"
    shift
    ((iSubst++)) || true
done

if [ -z "${PASS+x}" ]
then
    read -sp "$USER's password" PASS
    export PASS
    echo
fi

if [ -z "${SECRET+x}" ]
then
    read -sp "client secret" SECRET
    export SECRET
    echo
fi



TOKEN=$(curl -d "client_id=${CLIENT_ID}" -d "username=$USER" -d "password=$PASS" -d 'grant_type=password' "${AUTH_URL}" | jq '.access_token' | tr -d '"')


curl -v -X "${VERB}" -H "Authorization: Bearer ${TOKEN}" -H  "accept: */*" -H  "Content-Type: application/json" --data "@$TMP_DIR/${VERB}.json" "${HOST}/${SUBSTITUTED_PATH}" 

backup.sh ${DATA_PATH}${URL_PATH}/${VERB}.json
