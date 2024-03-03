#!/bin/bash

VERB=$1

if [ -n "$CURLSH_ENV" ]
then
   env
fi 

if [ "$CURLSH_AUTH_METHOD" = "openid-connect" ]
then
    if [ -z "$PASS" ]
    then
        read -sp "$AUTH_USER's password" PASS
        export PASS
        echo
    fi

    if [ -n "$CURLSH_AUTH_NEED_SECRET" ] 
    then
        if [ -z "$SECRET" ]
        then
            read -sp "client secret" SECRET
            export SECRET
            echo
        fi
        AUTH_SECRET_OPTION="-d \"client_secret=$SECRET\" "
    fi


    TOKEN=$(curl $AUTH_CURL_OPTIONS -d "client_id=$AUTH_CLIENTID" -d "username=$AUTH_USER" -d "password=$PASS" $AUTH_SECRET_OPTION \
        -d 'grant_type=password' "${AUTH_URL}" | jq '.access_token' | tr -d '"')

    CURL_AUTH_OPTION="-H \"Authorization: Bearer ${TOKEN}\" "
fi

CURLSH_HEADERS_ARRAY=( "$CURLSH_HEADER_CONTENT_TYPE" \
    "$CURLSH_HEADER_ACCEPT" \
    "$CURLSH_HEADER_USER_AGENT" )

CURLSH_OPTIONS_HEADERS_ARRAY=( '-H' "$CURLSH_HEADER_CONTENT_TYPE" \
    '-H' "$CURLSH_HEADER_ACCEPT" \
    '-H' "$CURLSH_HEADER_USER_AGENT" )

CURL_OPTIONS="$CURLSH_OPTION_CONTENT_TYPE \
$CURLSH_OPTION_ACCEPT \
$CURL_AUTH_OPTION \
$CURLSH_DATA_OPTIONS \
$CURLSH_OPTION_INSECURE \
$CURLSH_OPTION_VERBOSE \
$CURLSH_OPTIONS"

curl $CURL_OPTIONS ${CURLSH_OPTIONS_HEADERS_ARRAY[@]} -X "${VERB}" "$PROTOCOL://${HOST}/${CURLSH_SUBSTITUTED_PATH}" 


