#!/bin/bash

# convertit une date au format iso 8601 en timestamp (milliseconde)
# exemple:
# $tsk 2017-07-14T04:40:00+02:00
# 1500000000000

printf '%s000\n' $(date -d "$*" "+%s")
