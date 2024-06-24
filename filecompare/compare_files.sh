#!/bin/bash

# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 file1 file2"
    exit 1
fi

file1=$1
file2=$2
missing_in_file1=$(pwd)"/filecompare/comparison/missing_in_file1.txt"
missing_in_file2=$(pwd)"/filecompare/comparison/missing_in_file2.txt"

# Sort the input files
sorted_file1=$(mktemp)
sorted_file2=$(mktemp)
sort "$file1" > "$sorted_file1"
sort "$file2" > "$sorted_file2"

# Use comm to compare sorted files
# -2 suppresses lines unique to file2 (column 2)
# -3 suppresses lines that are common (column 3)
comm -23 "$sorted_file2" "$sorted_file1" > "$missing_in_file1"
# -1 suppresses lines unique to file1 (column 1)
comm -13 "$sorted_file2" "$sorted_file1" > "$missing_in_file2"

# Clean up temporary sorted files
rm "$sorted_file1" "$sorted_file2"

echo "Lines missing in $file1 have been saved to $missing_in_file1"
echo "Lines missing in $file2 have been saved to $missing_in_file2"
