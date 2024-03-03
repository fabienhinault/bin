#!/bin/bash
export SUB_PATH=$1
shift

echo $HOST

. $CURLSH_DIR/paths/$CURLSH_PATH/$SUB_PATH/env
. $CURLSH_DIR/bin/substitute_path.bash $CURLSH_PATH/$SUB_PATH $@
. usecurl.bash GET | jq "$JQ_FILTER" | $CURLSH_DISPLAY 

