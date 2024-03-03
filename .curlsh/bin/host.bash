
export HOST=$1
mkdir --parent $CURLSH_DIR/hosts/$HOST
. $CURLSH_DIR/hosts/env
. $CURLSH_DIR/hosts/$HOST/env
if [ "$AUTH_USER" = "user" ] || [ "$AUTH_USER" = "admin" ]
then
    . $CURLSH_DIR/bin/ssh_pass.bash
fi

