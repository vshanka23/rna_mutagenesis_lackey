#!/bin/bash

# Check the number of input parameters
if [ "$#" -ne 3 ]; then
    echo "Usage: bash extract_fastq.sh <fasta_file> <fastq_file> <output_file>"
    exit 1
fi

# Assign the input parameters to variables
fasta_file="$1"
fastq_file="$2"
output_file="$3"

# Create a temporary file to store the sequences in FASTA format
#tmp_fasta=$(mktemp)

# Convert FASTA sequences to single-line format (if not already in single line)
#awk '!/^>/{ printf "%s", $0; n = "\n" } /^>/{ print n $0; n = "" } END{ printf "%s", n }' "$fasta_file" > "$tmp_fasta"

# Create an empty output file
> "$output_file"

# Read the FASTA sequences one by one
#while IFS= read -r sequence
#do
  # Extract the matching sequence from the FASTQ file
#  grep -B 1 -A 2 "$sequence" "$fastq_file" >> "$output_file"
#done < "$tmp_fasta"

while IFS= read -r sequence
do
  # Extract the matching sequence from the FASTQ file
  modified_sequence="GAGTGACTCCAACA${sequence}AAAGAAACAACAACAACAAC"
  grep -B 1 -A 2 "$modified_sequence" "$fastq_file" >> "$output_file"_tmp.fastq
done < <(awk '/^[^>]/ { printf "%s", sep $0; sep="\n" } END { printf "%s", sep }' "$fasta_file")

source /opt/ohpc/pub/Software/mamba-rocky/etc/profile.d/conda.sh
source /opt/ohpc/pub/Software/mamba-rocky/etc/profile.d/mamba.sh
conda activate fastqwiper

fastqwiper --fastq_in "$output_file"_tmp.fastq --fastq_out "$output_file"
rm -f "$output_file"_tmp.fastq

# Clean up the temporary file
#rm "$tmp_fasta"

echo "FASTQ sequences extracted and saved to $output_file."

