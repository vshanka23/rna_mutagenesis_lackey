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

# Extract the target sequences from the input file
grep -B 1 "GGACACGACTCGAGTAGAGTCGAATGCGC...ATATAA...TAATGATATGGTTTG...GTTTCTACCAAGAGCCTTAAACTCTTGATTAT...GTCTGTCGCTTTATCCGAAATTTTATAAAGAGAAGACTCATGAATTACTTTGACCTGCCGACCGGAGTCGAGTGACTCCAACA............AAAGAAACAACAACAACAAC" "$1" > "$2.tmp"

# Remove lines containing "--" from the temporary file
sed -i '/--/d' "$2.tmp"

# Rename the temporary file to the final output file
mv "$2.tmp" "$2"
