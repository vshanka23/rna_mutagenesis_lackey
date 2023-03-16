#!/bin/bash

# Check if the correct number of arguments were passed
if [ "$#" -ne 2 ]; then
    echo "ERROR: Missing input parameters. Usage: $0 input_file output_file"
    exit 1
fi

# Add mafft module
module add mafft

# Align the concatenated sequences using MAFFT
mafft --auto --thread 8 "${1}" > "${2}_aligned.fasta"

# Get alignment output from MAFFT and linearize it again
awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' < "${2}_aligned.fasta" > "${2}_aligned_linear.fasta"

# Remove sequence IDs from aligned file
sed '/^>/d' "${2}_aligned_linear.fasta" > "${2}"

# Remove intermediate files
rm "${2}_aligned.fasta" "${2}_aligned_linear.fasta"

