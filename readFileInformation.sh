#!/bin/bash

paste <(find ../raw-data/HPRC_Annotation_PhaseI/ -name *.fastq.gz | grep "HiC/" | sort | sed 's:../raw-data/HPRC_Annotation_PhaseI/::g' | sed 's:/:\t:g' | sed 's: ::g' | cut -f2,3 | paste -s -d' \n' | tr " " "\t" | cut -f1-2,4 ) > HiC_reads.txt
 
#finds filepaths for fastq.gz files in the HiC folder and creates a sorted file named HiC_reads.txt, removes part of the pathname, adds tabs to replace '/' and removes a column

paste <(find ../raw-data/HPRC_Annotation_PhaseI/ -name *.fastq.gz | grep "ATAC-Seq/" | sort | sed 's:../raw-data/HPRC_Annotation_PhaseI/::g' | sed 's:/:\t:g' | cut -f2,3 | grep -v "_I1_" | grep -v "_I2_" | paste -s -d' \n' | tr " " "\t" | cut -f1-2,4 | awk 'grep _S*_' $4 ) > ATACseq_reads.txt

#finds filepaths for fastq.gz files in the ATAC-Seq folder and creates a sorted file named ATACSeq_reads.txt, removes part of the pathname, adds tabs to replace '/' and removes a column

paste <(find ../raw-data/HPRC_Annotation_PhaseI/ -name *.fastq.gz | grep "ONT_cDNA/" | sort | sed 's:../raw-data/HPRC_Annotation_PhaseI/::g' | sed 's:/:\t:g' | cut -f2,4 ) > ONTcDNA_reads.txt

#finds filepaths for fastq.gz files in the ONT_cDNA folder and creates a sorted file named ONTcDNA_reads_{DATE}.txt with the 'HPRC_Annotation_PhaseI/ portion removed.

paste <(find ../raw-data/HPRC_Annotation_PhaseI/ -name *.fastq.gz | grep "RNA-Seq/" | sort | sed 's:../raw-data/HPRC_Annotation_PhaseI/::g' | sed 's:/:\t:g' | cut -f2,4 | grep -v "_S1_" | grep -v "_S2_" | paste -s -d' \n' | tr " " "\t" | cut -f1-2,4 ) > RNAseq_reads.txt
