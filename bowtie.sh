#!/bin/bash
bowtie-build $1 lambda_virus
export REF=lambda_virus
bowtie -p 8 -x $REF -1 $2_R1_001.fastq.gz -2 $2_R2_001.fastq.gz -S $2.sam