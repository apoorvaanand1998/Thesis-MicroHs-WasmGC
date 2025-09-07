#!/bin/bash

# A script to convert all .wat files in the current directory to .wasm files.

echo "Starting conversion of .wat files to .wasm..."

# Loop through all files ending with .wat
for file in *.wat
do
  # Check if the file actually exists to handle cases where no files are found
  if [ -e "$file" ]; then
    # Get the filename without the extension
    base_name=$(basename "$file" .wat)
    
    # Run the wasm-tools parse command
    echo "Parsing $file into ${base_name}.wasm..."
    wasm-tools parse "$file" -o "${base_name}.wasm"
  else
    # This block runs if no .wat files are found
    echo "No .wat files found in the current directory."
    break
  fi
done

echo "Conversion process complete."
