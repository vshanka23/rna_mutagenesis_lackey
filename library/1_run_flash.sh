#!/bin/bash

# Check if the correct number of arguments were passed
if [ "$#" -ne 3 ]; then
    echo "ERROR: Missing input parameters. Usage: $0 input_file_R1 input_file_R2 output_file_prefix"
    exit 1
fi

# Check if the input files exist
if [ ! -f "$1" ] || [ ! -f "$2" ]; then
    echo "ERROR: Input files not found."
    exit 1
fi

# Run FLASH to merge overlapping paired-end reads
module add flash
echo "flash "$1" "$2" -M 150 -O -d -o "$3""
flash "$1" "$2" -M 150 -O -o "$3"
