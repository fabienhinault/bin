#!/bin/bash

if [ -e $1 ]
then
  /home/fabien/bin/backup.sh $1
else 
  mkdir -p $(dirname $1)
fi
vim $1
psql "${DB_STRING}" -f $1
/home/fabien/bin/backup.sh $1
