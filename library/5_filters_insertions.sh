#!/bin/bash

# Check if the correct number of arguments were passed
if [ "$#" -ne 4 ]; then
    echo "ERROR: Missing input parameters. Usage: $0 input_file output_file minlength maxlength"
    exit 1
fi

# Check if the input file exists
if [ ! -f "$1" ]; then
    echo "ERROR: Input file not found."
    exit 1
fi

# Load the bbmap module
module add bbmap

# Assign input and output files and parameters to variables
input_file=$1
output_file=$2
minlength=$3
maxlength=$4

# Run the reformat.sh command with the input file, output file, and parameters
reformat.sh in="$input_file" out="$output_file" minlength="$minlength" maxlength="$maxlength"
