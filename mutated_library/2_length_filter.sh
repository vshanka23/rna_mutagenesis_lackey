#!/bin/bash

# Check if the correct number of arguments were passed
if [ "$#" -ne 4 ]; then
    echo "ERROR: Missing input parameters. Usage: $0 input_file output_file min_length max_length"
    exit 1
fi

# Check if the input file exists
if [ ! -f "$1" ]; then
    echo "ERROR: Input file not found."
    exit 1
fi

# Set the input and output file names
input_file="$1"
output_file="$2"
min_length="$3"
max_length="$4"

# Filter the input file based on sequence length
awk -v min="$min_length" -v max="$max_length" 'BEGIN {FS = "\t" ; OFS = "\n"} {header = $0 ; getline seq ; getline qheader ; getline qseq ; if (length(seq) >= min && length(seq) <= max) {print header, seq, qheader, qseq}}' "$input_file" > "$output_file"

echo "Filtered sequences written to $output_file."
