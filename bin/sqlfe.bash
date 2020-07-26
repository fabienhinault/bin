#!/bin/bash

/home/fabien/bin/backup.sh $1
vim $1
psql "${DB_STRING}" -f $1
/home/fabien/bin/backup.sh $1
