#!/bin/bash

AUTH_HOST=$1
REALM=$2
USER=$3
PASS=$4
RABBIT_HOST=$5
EXCHANGE=$6
ROUTING_KEY=$7
METHOD=$8
PAYLOAD_PATH=$9
CLIENT_ID=${10}
DATA_PATH=${11}
RABBIT_USER=${12}
RABBIT_PASS=${13}

TOKEN=$(curl -d "client_id=${CLIENT_ID}" -d "username=$USER" -d "password=$PASS" -d 'grant_type=password'\
 "${AUTH_HOST}/realms/$REALM/protocol/openid-connect/token" | jq '.access_token' | tr -d '"')

jq ". + {headers: {method: \"$METHOD\", authorization: \"Bearer $TOKEN\"}}\
 + {properties: (.properties + {headers: {method: \"$METHOD\", authorization: \"Bearer $TOKEN\"}})}\
 + {payload: $(jq 'tojson' ${DATA_PATH}/${EXCHANGE}/${ROUTING_KEY}/$METHOD/payload.json)} + {name: \"$EXCHANGE\"}\
 + {routing_key: \"${ROUTING_KEY}\"" ${DATA_PATH}/skel.json | \
curl -v --user ${RABBIT_USER}:${RABBIT_PASS} "${RABBIT_HOST}/api/exchanges/%2F/$EXCHANGE/publish' --data "$(</dev/stdin)"

/home/fabien/bin/backup.sh ${DATA_PATH}/${EXCHANGE}/${ROUTING_KEY}/$METHOD/payload.json
