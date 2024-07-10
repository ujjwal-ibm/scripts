#!/bin/bash

# Input YAML file
INPUT_YAML_FILE="input.yaml"
# Output CSV file
OUTPUT_CSV_FILE="output.csv"

# Check if the input YAML file exists
if [ ! -f "$INPUT_YAML_FILE" ]; then
  echo "Input YAML file not found!"
  exit 1
fi

# Create or empty the output CSV file
echo "key,operationId" > "$OUTPUT_CSV_FILE"

# Use yq to process the YAML file and find keys with operationId
yq eval '.. | select(has("operationId")) | .operationId as $op | path | map(tostring) | join(".") + "," + $op' "$INPUT_YAML_FILE" | awk '{print}' >> "$OUTPUT_CSV_FILE"

echo "CSV file created successfully: $OUTPUT_CSV_FILE"
