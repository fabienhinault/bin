#!/bin/bash
# place it under ~/.local/share/nautilus/scripts/
for f in $NAUTILUS_SCRIPT_SELECTED_FILE_PATHS 
do
    cp -a $f $f~$(date --utc '+%Y-%m-%d_%H_%M_%S')
done
