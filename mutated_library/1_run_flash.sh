#!/bin/bash

# Check if the correct number of arguments were passed
if [ "$#" -ne 2 ]; then
    echo "ERROR: Missing input parameters. Usage: $0 input_file_prefix output_file_prefix"
    exit 1
fi

# Check if the input files exist
if [ ! -f "$1"_R1_001.fastq.gz ] || [ ! -f "$1"_R2_001.fastq.gz ]; then
    echo "ERROR: Input files not found."
    exit 1
fi

# Run FLASH to merge overlapping paired-end reads
module add flash
flash "$1"_R1_001.fastq.gz "$1"_R2_001.fastq.gz -M 150 -O -d -o "$2"
