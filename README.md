# Impact of degenerate tri-nucleotide quartet and chemical treatment on RNA structure
## Pipeline built using snakemake
![Pipeline Schematic (WIP)](https://github.com/vshanka23/rna_mutagenesis_lackey/blob/main/rnamut_pipeline_v1-01.jpg)
### Directory structure
There are 4 main directories, each corresponding to a section of the pipeline. Each section consists of its own snakemake workflow components.
1. Library: This directory comprises the snakemake workflow and associated scripts to run the part of the pipeline the generate the tri-nucleotide quartet and the 12 nucleotide barcode sequence. These serve as the reference points for the non-WT analysis. The barcodes from this snakemake workflow will be used to extract sequences from the chemical treated non-WT samples. Briefly, this pipeline does the following:
    * Merges FASTQ files across lanes for forward and reverse paired-end reads separately.
    * Runs [FLASH](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3198573/) to stitch paired-end reads to generate full length sequences.
    * Filters the stiched reads for specific lengths (this needs to be modified such that it automatically checks the histogram files from the FLASH step to identify modes).
    * Converts FASTQs to FASTAs in order to do build the template library and extract degeneracy and barcode sequences.
    * Uses the gene specific template to pull out sequences of interest (this is currently manually hard coded and will need to be setup such that the template is one of the inputs).
    * Re-filters to maintain a consistent length. Without this step, there were slight wobbles of 1-3 nucleotide in length.
    * Aligns using [MAFFT](https://mafft.cbrc.jp/alignment/software/) (multiple sequence aligner) so that positional information can be used to extract sequences. The steps also includes a linearizer and a QC step to remove empty lines.
    * Uses the first sequence of the aligned FASTA to build an address of 5 numbers. 4 of the 5 numbers correspond to the tri-nucleotide quartet and the fifth for the 12 nucleotide barcode.
    * Uses the positional address and the aligned FASTA from the previous steps to create an index of degenerate tri-nucleotide quartets and a list of barcodes. The output FASTA file will contain the tri-nucleotide quartet identity and the 12 nucleotide barcode concated together with "_" as each sequences header info (ex: >xxx_xxx_xxx_xxx_xxxxxxxxxxxx).
    * Removes complete sequence duplicates in the FASTA file and in the barcode file. Most importantly, it creates a library of FASTA files by splitting the output from the previous step based on their 12 nucleotide barcode identity. These files are named based on this barcode and placed in the "library" subdirectory.
    
   To run this workflow, please modify the `library.yaml` file to point to a specific sample prefix (sample to use for creating the initial library), the location of the FASTQ file corresponding to the sample prefix, a destination location to hold the analysis and output files and the location of "library" script from this git repo. Do not forget to give execute permission for the bash scripts.

   **The last two steps will need to be modified such that sequences with the SAME tri-nucleotide combination but with DIFFERENT 12 nucleotide barcodes should be lumped together into a single FASTQ(!) file for [Shapemapper](https://github.com/Weeks-UNC/shapemapper2) analysis (this will serve as the --unmodified input parameter). This WILL happen because the degeneracies have been limited to 2 of the 4 possible nucleotides for each position of the tri-nucleotide quartets and there are more barcodes possible with 12 nucleotide (2<sup>12</sup>=4096 vs 4<sup>12</sup>=16,777,216)**
2. Mutated_library: This directory comprises the snakemake workflow and associated scripts to generate the FASTQ files for the mutated (--modified) library to run [shapemapper](https://github.com/Weeks-UNC/shapemapper2). This is done by extracting sequences from this chemical treated non-WT set using the barcodes from "Library" snakemake workflow. Briefly, this pipeline does the following:
    * Merges FASTQ files across lanes for forward and reverse paired-end reads separately.
    * Runs [FLASH](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3198573/) to stitch paired-end reads to generate full length sequences.
    * Creates the mutated library from the barcode file from "Library" snakemake workflow and the stitched FASTQ files from the previous [FLASH](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3198573/) step.
    * Runs [shapemapper](https://github.com/Weeks-UNC/shapemapper2) by using the FASTA file for each tri-nucleotide degeneracy combo as the --target, the FASTQ file with the same set of tri-nucleotide degeneracies from the --target but with different barcodes as the --unmodified and finally, the mutated library from the previous step corresponding to those barcodes as the --modified. **This is incomplete!! The current iteration of this workflow is missing the Snakefile and the final steps need to be modified to include the --unmodified FASTQs***
3. WT_library: This WIP directory will contain the WT counterpart scripts to "Library" workflow.
4. WT_mutated_library: This WIP directory will contain the WT counterpart scripts to "Mutated_library" workflow.
