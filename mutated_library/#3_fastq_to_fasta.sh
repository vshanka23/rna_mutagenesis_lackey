#!/bin/bash

# Check if the correct number of arguments were passed
if [ "$#" -ne 2 ]; then
    echo "ERROR: Missing input parameters. Usage: $0 input_file output_file"
    exit 1
fi

# Check if the input file exists
if [ ! -f "$1" ]; then
    echo "ERROR: Input file not found."
    exit 1
fi

# Convert the input file from FASTQ to FASTA format
awk 'BEGIN {FS = "\t" ; OFS = "\n"} {header = ">"$1 ; seq = $2 ; print header, seq}' "$1" > "$2"
