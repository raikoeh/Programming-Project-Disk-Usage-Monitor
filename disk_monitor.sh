#!/bin/bash

# ========== Setup ==========

THRESHOLD="$1"
Total_size=0
Warnings=0
Checked=0
DIRECTORY=2

validate() {
  if [ "$#" -lt 2 ]; then
      echo "Usage: $0 <threshold_percent> <directory1> [directory2 ...]"
      exit 1
  fi
  
  
  while [ "$DIRECTORY" -le "$#" ]; do # while directory = or < number of arguments, DIR is current directory
    DIR=${!DIRECTORY}

    if [ ! -d "$DIR" ]; then # filter out non-directory inputs
        echo "Error: $DIR is not a valid input, skipping $DIR"
        DIRECTORY=$((DIRECTORY + 1))
        continue # move onto next argument
    fi 


    DIRECTORY=$((DIRECTORY+1))

  done
}


# ========== Disk Usage Analysis  ==========
analysis() {

  echo "=== Disk Usage Report ==="

  for DIR in "$@"
  do # directories in all arguments

    size_bytes=$(du -sb "$DIR" | cut -f1) # prints directory disk usage in bytes

    size_human=$(du -sh "$DIR" | cut -f1) # prints directory disk usage in human readable

    total=$(df -h "$DIR" | tail -1) # prints human readable disk filesystem size

    percent=$((size_bytes * 100 / total)) # change later, tentative
    
    if [ "$percent" -ge "$THRESHOLD" ]; then
	echo "$DIR     $size_human [WARINING: exceeds ${THRESHOLD}% threshold.]" # if percent exceeds threshold
	Warnings=$((Warnings+1))
    else
	echo "$DIR     $size_human"
    fi

    Total_size=$((Total_size + size_bytes))
    Checked=$((Checked + 1))

  done

  }


# ========== Main Pipeline ==========

validate "$@"
analysis "$@"

echo "Total: $total"
echo "Directories Checked: $Checked"
echo "Warnings: $Warnings"
