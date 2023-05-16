#!/bin/bash

if [ "$#" -ne 5 ]; then
    echo "Error: Incorrect number of input arguments."
    echo "Usage: $0 input_fasta input_file output_file barcode_output_file"
    exit 1
fi

input_fasta=$1
input_file=$2
alignment_output_file=$3
barcode_output_file=$4
degen_output_file=$5

if [ ! -f "$input_fasta" ]; then
    echo "Error: Input fasta file $input_fasta not found."
    exit 1
fi

if [ ! -f "$input_file" ]; then
    echo "Error: Input file $input_file not found."
    exit 1
fi

# Read the values of a, b, c, d, and e from the first line of the input file
read a b c d e <<< $(head -n 1 "$input_file")

# Find the sequence and barcode for each line in the input fasta file
while read line; do
    line1=$line
    tri1=${line1:$a:3}
    tri2=${line1:$b:3}
    tri3=${line1:$c:3}
    tri4=${line1:$d:3}
    bc=${line1:$e:12}
    index=">${tri1}_${tri2}_${tri3}_${tri4}_${bc}"
    degen="${tri1}_${tri2}_${tri3}_${tri4}"
    echo $index >> $alignment_output_file
    echo $line >> $alignment_output_file
    echo ${bc} >> $barcode_output_file
    echo ${degen} >> $degen_output_file
done < $input_fasta
