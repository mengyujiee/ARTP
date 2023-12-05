#!/bin/bash
# Script: QualityControl.sh
# Description: This script uses fastp to perform quality control on paired-end sequencing data.

# Iterate through each sample listed in the file "sample_list"
for i in $(cat sample_list)
do
    # Run fastp to perform quality control on the paired-end sequencing data
    fastp -i ${i}_1.fq.gz -I ${i}_2.fq.gz -o fastp/${i}_1.fq.gz -O fastp/${i}_2.fq.gz -h ${i}.html -w 10
done

# Note: Make sure to replace "sample_list" with the actual name of your sample list file.
# The script assumes that the input files are named in the format "sample_1.fq.gz" and "sample_2.fq.gz".
# The output files are written to the "fastp" directory, and HTML reports are generated for each sample.
# The parameter "-w 10" sets the number of CPU cores used by fastp to 10; you can adjust this based on your system.
