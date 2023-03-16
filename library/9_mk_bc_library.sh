#!/bin/bash

if [[ $# -ne 6 ]]; then
  echo "Usage: $0 <output_txt> <barcode_all_txt> <output_dedup_fasta> <output_dedup_linear_fasta> <barcode_uniq_txt> <library_dir>"
  exit 1
fi

# input filenames
output_txt="$1"
barcode_all_txt="$2"

# output filenames
output_dedup_fasta="$3"
output_dedup_linear_fasta="$4"
barcode_uniq_txt="$5"
library_dir="$6"

# Removing perfect duplicates (in sequence, not in indices. There are 78 duplicates in indices)
/data/software/usearch11.0.667_i86linux32 --cluster_fast "$output_txt" -id 1.00 -centroids "$output_dedup_fasta" -uc "${output_dedup_fasta}_cluster.nc"

# Linearize the final output
awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' < "$output_dedup_fasta" > "$output_dedup_linear_fasta"

# Find unique barcodes
cat "$barcode_all_txt" | sort | uniq > "$barcode_uniq_txt"

# Create a library based on barcodes
mkdir -p "$library_dir"
cat "$barcode_uniq_txt" | while read line; do search_string="_${line}"; grep -A 1 --no-group-separator ${search_string} "$output_dedup_linear_fasta" > "${library_dir}/${line}.fasta"; done
