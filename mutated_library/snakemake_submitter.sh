#!/bin/bash
#
#SBATCH --job-name=rnamut
#SBATCH --ntasks=1   
#SBATCH --partition=bigmem
#SBATCH --time=72:00:00
#SBATCH --mem=2gb
#SBATCH --output=/data/Palmetto_sync/Projects/vshanka_rnamut_dna/Ethanol_DMS/mutated/log/rnamut_output_%j.txt
#SBATCH --error=/data/Palmetto_sync/Projects/vshanka_rnamut_dna/Ethanol_DMS/mutated/log/rnamut_error_%j.txt
#SBATCH --mail-type=all
#SBATCH --mail-user=vshanka@clemson.edu

cd /data/Palmetto_sync/Projects/vshanka_rnamut_dna/Ethanol_DMS/mutated

#mkdir -p ./{log,logs_slurm}

source /opt/ohpc/pub/Software/mamba-rocky/etc/profile.d/conda.sh
source /opt/ohpc/pub/Software/mamba-rocky/etc/profile.d/mamba.sh
conda activate snakemake

#--dag | display | dot
#-p -n \

snakemake \
-s Snakefile_degen \
--profile slurm \
--configfile library.yaml \
--latency-wait 120
