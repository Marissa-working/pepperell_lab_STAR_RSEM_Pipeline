#!/bin/bash
$RSEMgenomeDir=testing
$ANNOTATION=MtbNCBIH37Rv_ncRNAs_sORFs.gtf
$GENOME=MtbNCBIH37Rv.fa
mkdir $RSEMgenomeDir
# Specify the input file
input_file="Quant.isoforms.results"

# Use awk to extract the gene_id and TPM columns
awk -F'\t' 'NR==1 {for (i=1; i<=NF; i++) {if ($i == "gene_id") gene_id_col = i; if ($i == "TPM") tpm_col = i}} 
NR > 1 {print $gene_id_col, $tpm_col}' "$input_file"
