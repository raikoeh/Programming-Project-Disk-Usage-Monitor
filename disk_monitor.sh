#!/bin/bash

# ========== Validate ==========
validate() {
  if [ "$#" -lt 2 ]; then
      echo "Usage: $0 <threshold_percent> <directory1> [directory2 ...]"
      exit 1
  fi

  THRESHOLD="$1"
  TOTAL_SIZE=0

  if ! [[ "$THRESHOLD" =~ ^[0-9]+$ ]]; then
    echo "Error: Threshold must be an integer."
    exit 1
  fi
  
  DIRECTORY=2
  
  while [ "$DIRECTORY" -le "$#" ]; do # while directory = or < number of arguments, DIR is current directory
    DIR=${!DIRECTORY}

    if [ ! -d "$DIR" ]; then # filter out non-directory inputs
        echo "Error: $DIR is not a valid input, skipping $DIR"
        DIRECTORY=$((DIRECTORY + 1))
        continue # move onto next argument
    fi 

    echo "Valid directory: $DIR"

    DIRECTORY=$((DIRECTORY+1))

  done
}


# ========== Disk Usage Analysis  ==========
analysis() {
  total_size=0
  warnings=0
  directories_checked=0

  echo "=== Disk Usage Report ==="

  for DIR in "$@" # directories in all arguments
      size_bytes=$(du -sb "$DIR" | cut -f1) # prints disk usage in bytes
      size_human=$(du -sh "$DIR" | cut -f1) # prints disk usage in human readable


      percent=$((size / total)) # change later, tentative
}
# fix/add to this portion

# ========== Output ==========

if [ "$percentage" -ge "$THRESHOLD" ]; then
    echo "$DIR     $size_human [WARINING: exceeds ${THRESHOLD}% threshold.]" # if percent exceeds threshold
    warnings=$((warnings+1))

else
    echo "$DIR     $size_human" # if percent doesn't exceed threshold
fi
# revise if loop ^^
