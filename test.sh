#!/bin/bash

TEST_DIR="./test_env"
mkdir -p "$TEST_DIR/data" "$TEST_DIR/results" "$TEST_DIR/tmp"

# Create sample files
dd if=/dev/zero of="$TEST_DIR/data/file1.bin" bs=1M count=10 &>/dev/null
dd if=/dev/zero of="$TEST_DIR/results/file2.bin" bs=1M count=2 &>/dev/null
dd if=/dev/zero of="$TEST_DIR/tmp/file3.bin" bs=1M count=1 &>/dev/null

THRESHOLD=0

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

