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
sed -n '1~4s/^@/>/p;2~4p' "$1" > "$2"
