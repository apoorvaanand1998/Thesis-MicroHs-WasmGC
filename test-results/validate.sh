#!/bin/bash

# Define the log file name
LOG_FILE="validation.log"

# Clear the log file before starting
> "$LOG_FILE"

echo "Starting validation of .wat files. Output will be saved to $LOG_FILE"

# Loop through all files ending with .wat in the current directory
for file in *.wat
do
    # Check if the file actually exists
    if [ -e "$file" ]; then
        echo "Validating $file..."

        # Run the command and capture all output (stdout and stderr)
        # The 2>&1 redirects standard error to standard output
        OUTPUT=$(wasm-tools validate "$file" 2>&1)

        # Append the formatted result to the log file
        echo "$file - $OUTPUT" >> "$LOG_FILE"
    else
        echo "No .wat files found in the current directory. No log file will be generated."
        exit 1 # Exit with an error code
    fi
done

echo "Validation complete. Check $LOG_FILE for results."
