#!/bin/bash

# Check if the correct number of arguments were passed
if [ "$#" -ne 4 ]; then
    echo "ERROR: Missing input parameters. Usage: $0 input_file output_file threads threadtb"
    exit 1
fi

# Assign input parameters to variables
input_file="$1"
output_file="$2"
threads="$3"
threadtb="$4"

# Add mafft module
module add mafft

# Align the concatenated sequences using MAFFT
mafft --op 10 --ep 5 --thread "$threads" --threadtb "$threadtb" --threadit 0 --reorder --anysymbol --large --retree 2 "$input_file" > "${output_file}_aligned.fasta"

# Get alignment output from MAFFT and linearize it again
awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' < "${output_file}_aligned.fasta" > "${output_file}_aligned_linear.fasta"

# Remove sequence IDs from aligned file
sed '/^>/d' "${output_file}_aligned_linear.fasta" > "$output_file"

# Remove intermediate files
rm "${output_file}_aligned.fasta" "${output_file}_aligned_linear.fasta"

