#!/bin/bash

# Check there are 2 arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <threshold_percent> <directory1> [directory2 ...]"
    exit 1
fi

THRESHOLD="$1"
TOTAL_SIZE=0
