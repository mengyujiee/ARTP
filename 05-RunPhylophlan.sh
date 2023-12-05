#!/bin/bash
# Script: 05-Run_phylophlan.sh
# Description: Run PhyloPhlAn for phylogenetic analysis of a set of bacterial strains.

# Set the input directory containing sequence data or genome files
input_dir=[input_dir]

# Set the output directory for PhyloPhlAn results
output_dir=[output_dir]

# Set the PhyloPhlAn database name
database_name=[database_dir]

# Set the diversity level for tree construction (options: low, medium, high)
diversity_level="low"

# Force the use of nucleotide data instead of protein data
force_nucleotides="--force_nucleotides"

# Set the number of processors to use
num_processors="--nproc 15"

# Specify the configuration file for tree parameters and other settings
config_file="-f tree.cfg"

# Run PhyloPhlAn command
phylophlan -i ${input_dir} \
           -o ${output_dir} \
           -d ${database_name} \
           --diversity ${diversity_level} \
           ${force_nucleotides} \
           ${num_processors} \
           ${config_file}
