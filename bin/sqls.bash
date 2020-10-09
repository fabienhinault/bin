#!/bin/bash

sed "s/{}/$2/" $1 | psql "${DB_STRING}" 
