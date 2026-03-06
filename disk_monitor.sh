#!/bin/bash

# ========== Setup ==========

THRESHOLD="$1"
Total_size=0
Warnings=0
Checked=0
DIRECTORY=2
results=""

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
      if [ ! -d "$DIR" ]; then
	  continue
      fi

    size_kbytes=$(du -sk "$DIR" | cut -f1) # prints directory disk usage in bytes

    size_human=$(du -sh "$DIR" | cut -f1) # prints directory disk usage in human readable

    total=$(df "$DIR" | awk 'NR==2 {print $2}')) # prints filesystem size in kilobytes

    percent=$((size_kbytes * 100 / total)) # change later, tentative
    
    if [ "$percent" -ge "$THRESHOLD" ]; then
	echo "$DIR     $size_human [WARINING: exceeds ${THRESHOLD}% threshold.]" # if percent exceeds threshold
	Warnings=$((Warnings+1))
    else
	echo "$DIR     $size_human"
    fi

    results+="$size_kbytes|$DIR|$size_human|$Warning"$'\n'

    Total_size=$((Total_size + size_kbytes))
    Checked=$((Checked + 1))

done

echo "$results" | sort -t'|' -nr -k1 | awk -F'|' '{print $2, $3, $4}'

  }

# ========== Main Pipeline ==========

validate "$@"
analysis "$@"

echo "Total: ${Total_size}K"
echo "Directories Checked: $Checked"
echo "Warnings: $Warnings"
