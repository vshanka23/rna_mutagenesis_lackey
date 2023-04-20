#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Error: Incorrect number of input arguments."
    echo "Usage: $0 input_fasta_file output_file"
    exit 1
fi

input_fasta=$1
output_file=$2

if [ ! -f "$input_fasta" ]; then
    echo "Error: Input fasta file $input_fasta not found."
    exit 1
fi

# Read the first sequence from the input fasta file
first_sequence=$(head -n 2 $input_fasta | tail -n 1)

# Define the motifs to be aligned
motifs=("TCGAATGCGC" "ATATAA" "TAATGATATGGTTTG" "AAACTCTTGATTAT" "GACCGGAGTCGAGTGACTCCAACA")

# Find the position of the last match for each motif
positions=()
for motif in "${motifs[@]}"
do
    position=$(echo "$first_sequence" | grep -b -o -i "$motif" | awk -F: '{print $1 + length($2)}' | tail -n 1)
    if [ -z "$position" ]; then
        position="NA"
    fi
    positions+=("$position")
done

# Write the positions to the output file
echo -e "${positions[@]}" | tr ' ' '\t' > "$output_file"

