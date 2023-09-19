#!/bin/bash

# Function to display usage instructions
usage() {
    echo "Usage: $0 -d <degen> -u <unmodified_fastq> -m <modified_fastq> -o <temp> -l <log>"
    exit 1
}

# Initialize variables
degen=""
unmodified_fastq=""
modified_fastq=""
temp=""
log=""
nproc=1

# Parse command line options
while getopts ":d:u:m:o:n:l:" opt; do
    case $opt in
        d) degen="$OPTARG" ;;
        u) unmodified_fastq="$OPTARG" ;;
        m) modified_fastq="$OPTARG" ;;
        o) temp="$OPTARG" ;;
        l) log="$OPTARG" ;;
        n) nproc="$OPTARG" ;;
        *) usage ;;
    esac
done

# Check for missing inputs
if [ -z "$degen" ] || [ -z "$unmodified_fastq" ] || [ -z "$modified_fastq" ] || [ -z "$temp" ] || [ -z "$log" ]; then
    echo "Error: Missing required input. Please provide all required parameters."
    usage
fi

# Extract individual trinucleotides from degen
trinucleotide1=${degen:0:3}
trinucleotide2=${degen:4:3}
trinucleotide3=${degen:8:3}
trinucleotide4=${degen:12:3}

# Generate template sequence
template=">template_${degen}
TAATACGACTCACTATAGGACACGACTCGAGTAGAGTCGAATGCGC${trinucleotide1}ATATAA${trinucleotide2}TAATGATATGGTTTG${trinucleotide3}GTTTCTACCAAGAGCCTTAAACTCTTGATTAT${trinucleotide4}GTCTGTCGCTTTATCCGAAATTTTATAAAGAGAAGACTCATGAATTACTTTGACCTGCCGACCGGAGTCGAGTGACTCCAACA"

template_file="template_${degen}.fasta"
printf "%s" "$template" > "$template_file"

# Execute shapemapper command
ml shapemapper
shapemapper --target "$template_file" --out "$degen" --temp "$temp" --unmodified --U "$unmodified_fastq" --modified --U "$modified_fastq" --log "$log" --overwrite --nproc "$nproc" --verbose

rm "$template_file"