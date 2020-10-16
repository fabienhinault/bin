#!/bin/bash

sed -i~$(date --utc +%Y-%m-%d_%H_%M_%S) "s/$(jq '.id' $1)/\"$(uuidgen)\"/g" $1
