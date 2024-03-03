#!/bin/bash
SUB_PATH=$1
shift

PATH_DIR=$CURLSH_DIR/paths/$CURLSH_PATH/$SUB_PATH
. $PATH_DIR/env
. $CURLSH_DIR/bin/substitute_path.bash $CURLSH_PATH/$SUB_PATH $@
. $CURLSH_DIR/bin/substitute_file.bash "$PATH_DIR/POST" $@
CURLSH_DATA_OPTIONS="-d @$CURLSH_SUBSTITUTED_FILE"
. usecurl.bash "$SUB_PATH" POST | jq "$JQ_FILTER" | $CURLSH_DISPLAY 


