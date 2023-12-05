#!/bin/bash
# Script: 04-amplicon.sh
# Description: Process FASTQ files to FASTA format and search for specific strings.

# Activate the conda environment
conda activate seqtk

# Convert each FASTQ file to FASTA format
for i in $(ls *.fq.gz | cut -d. -f1)
do
    seqtk seq -A ${i}.fq.gz > ${i}.fasta
done

# Define the search strings for wild type (Wt) and mutant (Mt)
search_string_wt1="tgaaacaataacatatatcctttgtcggtatgaatgatgg"
search_string_wt2="ccatcattcataccgacaaaggatatatgttattgtttca"

search_string_mt1="tgaaacaataacatatatcttttgtcggtatgaatgatgg"
search_string_mt2="ccatcattcataccgacaaaagatatatgttattgtttca"

# Get a list of all .fasta files
files=($(ls *.fasta))

# Print the header
echo -e "Sample\tWt\tMt\tAvg_lines"

# Iterate through the list of files
for file in "${files[@]}"; do
    # Use grep -E -c to count matching lines (-E enables extended regex, supporting | operator)
    count_wt=$(grep -E -c -i "$search_string_wt1|$search_string_wt2" "$file")
    count_mt=$(grep -E -c -i "$search_string_mt1|$search_string_mt2" "$file")
    total_lines=$(wc -l < "$file")

    # Calculate the average number of lines (assuming 2 lines per sequence)
    avg_lines=$((total_lines / 2))
    
    # Print the filename and corresponding counts, separated by tabs
    echo -e "$file\t$count_wt\t$count_mt\t$avg_lines"
done
