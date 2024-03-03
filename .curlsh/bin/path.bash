#!/bin/bash

export CURLSH_PATH=$1
PATH_DIR=$CURLSH_DIR/paths/$1
mkdir --parent $PATH_DIR
cd $PATH_DIR
if [ -f $PATH_DIR/env ]
then
    . $PATH_DIR/env
fi
