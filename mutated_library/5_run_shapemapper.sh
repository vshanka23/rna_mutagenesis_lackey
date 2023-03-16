#!/bin/bash

# Set up input variables
motif_file=$1
dir1=$2
dir2=$3

# Create output directory for shapemapper results
mkdir -p shapemapper_output

# Loop through each motif in the motif file
while read motif; do
  # Define input file names
  input_file1="$dir1/$motif.fasta"
  input_file2="$dir2/$motif.fasta"
  
  # Check if input files exist
  if [ ! -f "$input_file1" ] || [ ! -f "$input_file2" ]; then
    echo "Input file(s) for $motif not found."
    continue
  fi
  
  # Create output directory for current motif
  motif_dir="shapemapper_output/$motif"
  mkdir -p "$motif_dir"
  
  # Run shapemapper analysis and save results in output directory
##NEED TO ADD unmodified which is just a FASTQ of the target. Need to pool 
  shapemapper --target "$input_file1" --sample --modified "$input_file2" --out "$motif_dir"
done < "$motif_file"

