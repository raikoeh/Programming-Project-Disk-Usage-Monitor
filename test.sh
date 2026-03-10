#!/bin/bash

# Making variables for script and temporary folder used for test
SCRIPT="./disk_monitor.sh" 
TEST_DIR="./test_env"

mkdir -p "$TEST_DIR/data" "$TEST_DIR/results" "$TEST_DIR/tmp" # make temporary subdirectories

# Create sample files
dd if=/dev/zero of="$TEST_DIR/data/file1.bin" bs=1M count=10 &>/dev/null # 10MB file
dd if=/dev/zero of="$TEST_DIR/results/file2.bin" bs=1M count=2 &>/dev/null # 2MB file
dd if=/dev/zero of="$TEST_DIR/tmp/file3.bin" bs=1M count=1 &>/dev/null # 1MB file

# Track number of passes and fails
pass_count=0
fail_count=0

# Test function with arguments
run_test() {
    TEST_NAME=$1
    COMMAND=$2
    EXPECTED=$3

    OUTPUT=$(eval "$COMMAND") # executes string as command

    if echo "$OUTPUT" | grep -q "$EXPECTED"; then
        echo "[PASS] $TEST_NAME" # Reports pass
        pass_count=$((pass_count+1))
    else
        echo "[FAIL] $TEST_NAME" # Reports fail
        echo "Expected to find: $EXPECTED" # Reports other info to understand why the test failed
        echo "Actual output:"
        echo "$OUTPUT"
        fail_count=$((fail_count+1))
    fi
}

echo "Running Disk Monitor Tests"
echo "--------------------------"

# =========================
# Test 1: Normal Input
# =========================

run_test \
"Normal directories test" \
"$SCRIPT 80 $TEST_DIR/data $TEST_DIR/results $TEST_DIR/tmp" \
"Directories Checked: 3"


# =========================
# Test 2: Empty directory
# =========================

mkdir -p "$TEST_DIR/empty"

run_test \
"Empty directory test" \
"$SCRIPT 80 $TEST_DIR/empty" \
"$TEST_DIR/empty"


# =========================
# Test 3: Invalid directory
# =========================

run_test \
"Invalid directory test" \
"$SCRIPT 80 $TEST_DIR/does_not_exist" \
"not a valid input"

# Report summary of the tests
echo
echo "Tests Passed: $pass_count"
echo "Tests Failed: $fail_count"

rm -rf "$TEST_DIR" # Deletes the test environment
