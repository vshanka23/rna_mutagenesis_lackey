#!/bin/sh
# properties = {"type": "single", "rule": "merge_lanes", "local": false, "input": ["/data/gsl/bsl/vshanka/vshanka_riboswitch_dna/FASTQ/Ribo82922-1_S1_L001_R1_001.fastq.gz", "/data/gsl/bsl/vshanka/vshanka_riboswitch_dna/FASTQ"], "output": ["/data/Palmetto_sync/Projects/vshanka_rnamut_dna/Ethanol_DMS/Ribo82922-1_S1.R1_merged.fastq.gz", "/data/Palmetto_sync/Projects/vshanka_rnamut_dna/Ethanol_DMS/Ribo82922-1_S1.R2_merged.fastq.gz"], "wildcards": {}, "params": {"script": "/data/Palmetto_sync/Projects/vshanka_rnamut_dna/pipeline/bash_scripts/0_merge_lanes.sh", "prefix": "Ribo82922-1_S1"}, "log": [], "threads": 1, "resources": {"cpus": 2, "mem_mb": 16000, "time_min": 14400}, "jobid": 10, "cluster": {}}
 cd /data/Palmetto_sync/Projects/vshanka_rnamut_dna/pipeline/bash_scripts/library && \
/opt/ohpc/pub/Software/mamba-rocky/envs/snakemake/bin/python3.9 \
-m snakemake /data/Palmetto_sync/Projects/vshanka_rnamut_dna/Ethanol_DMS/Ribo82922-1_S1.R1_merged.fastq.gz --snakefile /data/Palmetto_sync/Projects/vshanka_rnamut_dna/pipeline/bash_scripts/library/Snakefile_degen \
--force -j --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /data/Palmetto_sync/Projects/vshanka_rnamut_dna/pipeline/bash_scripts/library/.snakemake/tmp.2ckd6wfu /data/gsl/bsl/vshanka/vshanka_riboswitch_dna/FASTQ/Ribo82922-1_S1_L001_R1_001.fastq.gz /data/gsl/bsl/vshanka/vshanka_riboswitch_dna/FASTQ --latency-wait 120 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
 --configfiles /data/Palmetto_sync/Projects/vshanka_rnamut_dna/pipeline/bash_scripts/library/library.yaml  --allowed-rules merge_lanes --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /opt/ohpc/pub/Software/mamba-rocky/envs/snakemake/bin \
--mode 2  && touch /data/Palmetto_sync/Projects/vshanka_rnamut_dna/pipeline/bash_scripts/library/.snakemake/tmp.2ckd6wfu/10.jobfinished || (touch /data/Palmetto_sync/Projects/vshanka_rnamut_dna/pipeline/bash_scripts/library/.snakemake/tmp.2ckd6wfu/10.jobfailed; exit 1)

