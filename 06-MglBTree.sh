#!/bin/bash
# Script: 06-Generate_mglb_phylogeny.sh
# Description: Perform analysis on mgl operons from bacteria, including Blastp, multiple-sequence alignment, and phylogenetic tree construction.

# Set paths and filenames
mglb_query=[MglB_B10998.fasta]
custom_database=[/path/to/custom_bee_gut_database]
uniref90_database=[/path/to/uniref90_database.fasta]

# Step 1: Blastp against genomes of all Snodgrassella strains
blastp -query "${mglb_query}" -db "${custom_database}" -out "blastp_results.out" -evalue 0.0001

# Step 2: Obtain homologous sequences from UniRef 90
# Adjust the path to the UniRef 90 database
blastdbcmd -db "${uniref90_database}" -entry_batch "blastp_results.out" -out "homologous_sequences.fasta"

# Step 3: Build multiple-sequence alignments with MAFFT
mafft --localpair --maxiterate 1000 "homologous_sequences.fasta" > "aligned_sequences.fasta"

# Step 4: Build phylogenetic trees with FastTree
fasttree -nt -slow -gtr "aligned_sequences.fasta" > "phylogenetic_tree.newick"

# Step 5: Visualize phylogenetic tree using ggtree in R
# Assuming R is installed with ggtree package
Rscript -e 'library(ggtree); tree <- read.tree("phylogenetic_tree.newick"); ggtree(tree) + geom_tiplab()' -o "phylogenetic_tree.png"
