#!/bin/bash

# Define input files
motif_file="$1"
fastq_file="$2"

# Define output directory
output_dir="$3"

# Check if the correct number of input parameters have been specified
if [ $# -ne 3 ]; then
  echo "Usage: $0 <motif_file> <stitched_fastq_file> <output_dir>"
  exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

# Loop over each 12 nt motif in the motif file
while read -r motif; do

  # Define output filename based on the motif
  output_file="${output_dir}/${motif}.fastq"

  # Use grep to find all matches of the motif in the fasta file
  grep -B 1 -A 2 "AACA${motif}AAAGAA" "$fastq_file" > "$output_file"

  # Count the number of matches and print to the console
  num_matches=$(grep -c "AACA${motif}AAAGAA" "$fastq_file")
  echo "${motif}: ${num_matches} matches"

done < "$motif_file"

