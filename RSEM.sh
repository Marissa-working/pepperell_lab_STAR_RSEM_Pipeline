#!/bin/bash

# Note: Shell variables assignment cannot have space
BAM=$1.Aligned.toTranscriptome.out.bam
GENOME=$2
ANNOTATION=$3
RSEMgenomeDir=rsem
threads=8
nThreadsRSEM=8

# RSEM, require Aligned.toTranscriptome.out.bam file
mkdir $RSEMgenomeDir
rsem-prepare-reference --gtf $ANNOTATION $GENOME $RSEMgenomeDir/RSEMref
rsem-calculate-expression --bam --no-bam-output --estimate-rspd \
                        --calc-ci --seed 12345 -p $nThreadsRSEM --ci-memory 30000 --paired-end \
                        --forward-prob 0 $BAM $RSEMgenomeDir/RSEMref Quant