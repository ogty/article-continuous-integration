#!/bin/bash -

START=$1
END=$2
FILENAME=$3

if [[ -e $FILENAME ]]
then
    awk -v start=\"$START\" -v end=\"$END\" -f ./aci.awk $FILENAME
else
    echo "File does not exist"
fi
