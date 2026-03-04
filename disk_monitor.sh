#!/bin/bash

# Check there are 2 arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <threshold_percent> <directory1> [directory2 ...]"
    exit 1
fi

THRESHOLD="$1"
TOTAL_SIZE=0

# Loop over directories to measure size
DIRECTORY=2 # start at 2 since the directory is the second argument, skips threshold argument
while [ $DIRECTORY -le $# ]; do # while directory = or < number of arguments, DIR is current directory
    DIR=${!DIRECTORY}

    if [ ! -d "$DIR" ]; then # filter out non-directory inputs
	echo "Error: $DIR is not a valid input, skipping $DIR"
	DIRECTORY=$((DIRECTORY + 1))
	continue # move onto next argument
    fi 
