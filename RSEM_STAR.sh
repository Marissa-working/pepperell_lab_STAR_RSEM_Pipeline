#!/bin/bash

# Note: Shell variables assignment cannot have space
RSEMgenomeDir=testing
STARgenomeDir=star
ANNOTATION=MtbNCBIH37Rv_ncRNAs_sORFs.gtf
GENOME=MtbNCBIH37Rv.fa
threads=8
nThreadsSTAR=8
read1=3151_18_S12_R1_001.fastq.gz
read2=3151_18_S12_R2_001.fastq.gz

# Replace the space in gtf file with underline
python3 clear_space.py $ANNOTATION

# STAR
mkdir $STARgenomeDir
STAR --runThreadN $threads --runMode genomeGenerate \
                        --genomeDir $STARgenomeDir --genomeFastaFiles $GENOME \
                        --sjdbGTFfile $ANNOTATION --sjdbOverhang 100 \
                        --outFileNamePrefix $STARgenomeDir
STAR --genomeDir $STARgenomeDir --readFilesIn $read1 $read2 \
                        --readFilesCommand zcat --outFilterType BySJout --outSAMunmapped Within \
                        --outSAMtype BAM SortedByCoordinate --outSAMattrIHstart 0 \
                        --outFilterIntronMotifs RemoveNoncanonical --runThreadN $nThreadsSTAR \
                        --quantMode TranscriptomeSAM --outWigType bedGraph --outWigStrand Stranded \
                        --limitBAMsortRAM 1207111982

# RSEM
mkdir $RSEMgenomeDir
rsem-prepare-reference --gtf $ANNOTATION $GENOME $RSEMgenomeDir/RSEMref
rsem-calculate-expression --bam --no-bam-output --estimate-rspd \
                        --calc-ci --seed 12345 -p $nThreadsRSEM --ci-memory 30000 --paired-end \
                        --forward-prob 0 Aligned.toTranscriptome.out.bam $RSEMgenomeDir/RSEMref Quant
