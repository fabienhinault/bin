#!/bin/bash

VERB=$1

if [ -n "${CURLSH_ENV+x}" ]
then
   env
fi 

if [ "$CURLSH_AUTH_METHOD" = "openid-connect" ]
then
    if [ -z "$PASS" ]
    then
        read -sp "$CURLSH_AUTH_USER's password" PASS
        export PASS
        echo
    fi

    if [ -n "${CURLSH_AUTH_NEED_SECRET+x}" ] 
    then
        if [ -z "$SECRET" ]
        then
            read -sp "client secret" SECRET
            export SECRET
            echo
        fi
        AUTH_SECRET_OPTION="-d \"client_secret=$SECRET\" "
    fi

    CURL_AUTH_OPTIONS=()
    for o in "${CURLSH_AUTH_OPTION_INSECURE:-}" "${CURLSH_AUTH_OPTION_VERBOSE:-}" "${CURLSH_AUTH_OPTION_SILENT:-}" 
    do
        if [ -n "$o" ]
        then
            CURL_AUTH_OPTIONS+=("$o")
        fi
    done

    TOKEN=$(curl "${CURL_AUTH_OPTIONS[@]}" $CURLSH_AUTH_INSECURE $CURLSH_AUTH_SILENT -d "client_id=$AUTH_CLIENTID" -d "username=$CURLSH_AUTH_USER" -d "password=$PASS" "${AUTH_SECRET_OPTION:-}" \
        -d 'grant_type=password' "${AUTH_URL}" | jq '.access_token' | tr -d '"')

    CURLSH_HEADER_AUTH="Authorization: Bearer ${TOKEN}"
fi


CURLSH_OPTIONS_HEADERS_ARRAY=()
for h in "${CURLSH_HEADER_CONTENT_TYPE:-}" \
         "${CURLSH_HEADER_ACCEPT:-}" \
         "${CURLSH_HEADER_USER_AGENT:-}" \
         "${CURLSH_HEADER_AUTH:-}"
do
    if [ -n "$h" ]
    then
    	CURLSH_OPTIONS_HEADERS_ARRAY+=('-H' "$h")
    fi
done

CURL_OPTIONS=()
for o in "${CURLSH_OPTION_INSECURE:-}" "${CURLSH_OPTION_VERBOSE:-}" "${CURLSH_OPTION_SILENT:-}" 
do
    if [ -n "$o" ]
    then
    	CURL_OPTIONS+=("$o")
    fi
done

curl "${CURL_OPTIONS[@]}" "${CURLSH_OPTIONS_HEADERS_ARRAY[@]}" "${CURLSH_DATA_OPTIONS[@]}" -X "${VERB}" "$PROTOCOL://${CURLSH_HOST}${CURLSH_SUBSTITUTED_PATH}" 


