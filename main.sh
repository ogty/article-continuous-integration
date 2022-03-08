#!/bin/bash -

FILENAME=$1

if [[ -e $FILENAME ]]
then
    awk -f main.awk $FILENAME
else
    echo "File does not exist"
fi
