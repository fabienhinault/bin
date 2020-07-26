#!/bin/bash
cp -a $1 $1~$(date --utc '+%Y-%m-%d_%H_%M_%S')
