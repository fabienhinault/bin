#!/bin/bash

# convertit une date au format iso en timestamp (seconde)
# exemple:
# $ date_iso_to_timestamp.bash 2017-07-14T04:40:00
# 1500000000

date -d "$*" "+%s"
