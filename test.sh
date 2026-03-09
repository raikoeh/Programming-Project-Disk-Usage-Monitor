#!/bin/bash

TEST_DIR="./test_env" # creates variable TEST_DIR that points to the path ./test_env
mkdir -p "$TEST_DIR/data" "$TEST_DIR/results" "$TEST_DIR/tmp" # makes TEST_DIR a parent directory of data, results, and tmp

# Create sample files
dd if=/dev/zero of="$TEST_DIR/data/file1.bin" bs=1M count=10 &>/dev/null #creates file1.bin with size 10MB
dd if=/dev/zero of="$TEST_DIR/results/file2.bin" bs=1M count=2 &>/dev/null # file2.bin size 2MB
dd if=/dev/zero of="$TEST_DIR/tmp/file3.bin" bs=1M count=1 &>/dev/null # file3.bin size 1MB

THRESHOLD=80 # threshold set 

OUTPUT=$(./disk_monitor.sh "$THRESHOLD" "$TEST_DIR/data" "$TEST_DIR/results" "$TEST_DIR/tmp")

PASS=true

echo "$OUTPUT" | grep -q "$TEST_DIR/data" || PASS=false
echo "$OUTPUT" | grep -q "$TEST_DIR/results" || PASS=false
echo "$OUTPUT" | grep -q "$TEST_DIR/tmp" || PASS=false

if [ "$PASS" = true ]; then
    echo "All tests PASSED"
else
    echo "Some tests FAILED"
fi

rm -rf "$TEST_DIR"

