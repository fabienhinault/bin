#!/bin/bash

psql "${DB_STRING}" -f $1
/home/fabien/bin/backup.sh $1
