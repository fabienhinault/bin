#!/bin/bash

# montre le json de stdin dans un nouvel onglet de Firefox

mkdir -p /tmp/showff
tmpfile=$(mktemp /tmp/showff/XXXXXX.json)
cat - > $tmpfile
firefox -new-tab $tmpfile
