#!/bin/bash

# This script will merge FASTQ files from multiple illumina sequencer lanes for R1s and R2s separately based on a sample name prefix.

# Check for correct number of input parameters
if [ "$#" -ne 4 ]; then
    echo "Usage: ./merge_fastq.sh [PREFIX] [DIR] [R1_OUTPUT] [R2_OUTPUT]"
    exit 1
fi

# Set the sample name prefix, input directory, and output file names
PREFIX=$1
DIR=$2
R1_OUTPUT=$3
R2_OUTPUT=$4

# Check that input directory exists and is readable
if [ ! -d "${DIR}" ] || [ ! -r "${DIR}" ]; then
    echo "Error: '${DIR}' is not a readable directory."
    exit 1
fi

# Merge R1s
R1_FILES="${DIR}/${PREFIX}_L00*_R1_001.fastq.gz"

if [ ! -f "${R1_OUTPUT}" ]; then
    cat ${R1_FILES} > ${R1_OUTPUT}
    echo "Merged R1 files for ${PREFIX} successfully."
else
    echo "Error: '${R1_OUTPUT}' already exists."
    exit 1
fi

# Merge R2s
R2_FILES="${DIR}/${PREFIX}_L00*_R2_001.fastq.gz"

if [ ! -f "${R2_OUTPUT}" ]; then
    cat ${R2_FILES} > ${R2_OUTPUT}
    echo "Merged R2 files for ${PREFIX} successfully."
else
    echo "Error: '${R2_OUTPUT}' already exists."
    exit 1
fi
