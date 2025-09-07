#!/bin/bash

# Define the source and output paths as variables for clarity
SOURCE_PREFIX="/home/spirit/Desktop/Programs/Thesis/MicroHs-ghc/tests/"
OUTPUT_PREFIX="/home/spirit/Desktop/Programs/Thesis/test-results/"

echo "Starting mhs command execution for .wat files..."

# Check if any .wat files exist in the directory
shopt -s nullglob
files=(*.wat)
shopt -u nullglob

if [ ${#files[@]} -eq 0 ]; then
    echo "No .wat files found in the current directory."
    exit 1
fi

# Loop through all files ending with .wat
for file in "${files[@]}"
do
    # 1. Strip the "-wasmgc.wat" suffix from the filename
    stripped_filename="${file%-wasmgc.wat}"

    # 2. Construct the full path for the input file
    input_path="${SOURCE_PREFIX}${stripped_filename}.hs"
    
    # 3. Construct the full path for the output file
    output_path="${OUTPUT_PREFIX}${stripped_filename}.wasm"
    
    echo "Processing $file..."

    # 4. Run the mhs command
    mhs -v -temccBinarySize "$input_path" -o "$output_path"

    echo "---"
done

echo "Mhs emccBinarySize command execution complete."
