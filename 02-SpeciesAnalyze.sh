#!/bin/bash
# Script: 02-analyze_species.sh
# Description: This script uses MIDAS to analyze species abundance in paired-end sequencing data.

# Set the input directory and database path
input_dir=[path_to_input_files]  # Replace [path_to_input_files] with the actual path to your input files
database_dir=[path_to_bee_gut_database]  # Replace [path_to_bee_gut_database] with the actual path to your bee gut database

# Create a directory to store MIDAS results
mkdir -p results/midas

# Iterate through each sample listed in the file containing absolute paths to input files
for input_file in $(cat [path_to_samplelist_absolute_paths])  # Replace [path_to_samplelist_absolute_paths] with the actual path to your sample list with absolute paths
do
    # Extract the sample name from the input file path
    i=$(basename "$input_file" | cut -d "_" -f 1)

    # Run MIDAS to analyze species abundance
    run_midas.py species results/midas/${i} -1 ${input_file}_1.fq.gz -2 ${input_file}_2.fq.gz -d ${database_dir}
done

# Create a directory to store merged MIDAS results
mkdir -p results/merge

# Merge MIDAS species profiles for each sample
merge_midas.py species results/midas/ results/merge -t dir -d ${database_dir}

# Iterate through each sample listed in the file containing absolute paths to input files again
for input_file in $(cat [path_to_samplelist_absolute_paths])  # Replace [path_to_samplelist_absolute_paths] with the actual path to your sample list with absolute paths
do
    # Extract the sample name from the input file path
    i=$(basename "$input_file" | cut -d "_" -f 1)

    # Copy the species profile to the merge directory
    cp results/midas/${i}/species/species_profile.txt results/merge/${i}_species_profile.txt
done

# The results are stored in the "results/midas" and "results/merge" directories.
# Adjust paths and options based on your specific file organization and database location.

