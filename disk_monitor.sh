#!/bin/bash

# ========== Setup ==========

THRESHOLD="$1"
Total_size=0
Warnings=0
Checked=0
DIRECTORY=2
results=""

# ========== Validate Input ==========
validate() {
  if [ "$#" -lt 2 ]; then
      echo "Usage: $0 <threshold_percent> <directory1> [directory2 ...]"
      exit 1
  fi

  # Ensure threshold is an integer
  if ! [[ "$THRESHOLD" =~ ^[0-9]+$ ]]; then
      echo "Error: threshold must be an integer."
      exit 1
  fi

  while [ "$DIRECTORY" -le "$#" ]; do
    DIR=${!DIRECTORY}

    if [ ! -d "$DIR" ]; then
        echo "Error: $DIR is not a valid input, skipping $DIR"
        DIRECTORY=$((DIRECTORY + 1))
        continue
    fi

    DIRECTORY=$((DIRECTORY + 1))
  done
}

# ========== Disk Usage Analysis ==========
analysis() {

  echo "=== Disk Usage Report ==="

  for DIR in "${@:2}"; do
      if [ ! -d "$DIR" ]; then
          continue
      fi

      # Directory size in KB and human-readable
      size_kbytes=$(du -sk "$DIR" | cut -f1)
      size_human=$(du -sh "$DIR" | cut -f1)

      # Partition total size
      total=$(df "$DIR" | awk 'NR==2 {print $2}')

      # Percentage of partition used
      percent=$((size_kbytes * 100 / total))

      warning_flag=""

      if [ "$percent" -ge "$THRESHOLD" ]; then
          warning_flag="[WARNING: exceeds ${THRESHOLD}% threshold]"
          Warnings=$((Warnings+1))
      fi

      # Save result for sorting
      results+="$size_kbytes|$DIR|$size_human|$percent|$warning_flag"$'\n'

      Total_size=$((Total_size + size_kbytes))
      Checked=$((Checked + 1))
  done

  # Sort results by size and print
  echo "$results" | sort -t'|' -nr -k1 | while IFS="|" read size dir human percent warn; do
      echo "$dir     $human ${percent}% $warn"
  done
}

# ========== Main Pipeline ==========
validate "$@"
analysis "$@"

echo
echo "Total: ${Total_size}K"
echo "Directories Checked: $Checked"
echo "Warnings: $Warnings"
