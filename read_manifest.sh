#!/bin/bash

paste <(find ../raw-data/HPRC_Annotation_PhaseI/ -name *.fastq.gz | grep "HiC/" | sort | sed 's:../raw-data/HPRC_Annotation_PhaseI/::g' | sed 's:/:\t:g' | sed 's: ::g' | cut -f2,3 | paste -s -d' \n' | tr " " "\t" | cut -f1-2,4 ) > HiC_reads.txt
 
#finds filepaths for fastq.gz files in the HiC folder, removes part of the pathname, adds tabs to replace '/' and removes columns.  Next combines R1 and R2 on same line. Next adds a tab-delimited column and removes unwanted column 3. Output is HiC_reads.txt

paste <(find ../raw-data/HPRC_Annotation_PhaseI/ -name *.fastq.gz | grep "ATAC-Seq/" | sort | sed 's:../raw-data/HPRC_Annotation_PhaseI/::g' | sed 's:/:\t:g' | cut -f2,3 | grep -v "_I1_" | grep -v "_I2_" | paste -s -d' \n' | tr " " "\t" | cut -f1-2,4 | awk 'grep _S*_' $4 ) > ATACseq_reads.txt

#finds filepaths for fastq.gz files in the ATAC-Seq folder and creates a sorted file, removes part of the pathname, adds tabs to replace '/' and removes a column.  Next combines R1 and R2 into single line as above. Output filename is ATACseq_reads.txt.

paste <(find ../raw-data/HPRC_Annotation_PhaseI/ -name *.fastq.gz | grep "ONT_cDNA/" | sort | sed 's:../raw-data/HPRC_Annotation_PhaseI/::g' | sed 's:/:\t:g' | cut -f2,4 ) > ONTcDNA_reads.txt

#finds filepaths for fastq.gz files in the ONT_cDNA folder and creates a sorted file with the 'HPRC_Annotation_PhaseI/ portion removed, tabs replace /, columns 1 and 3 removed. File output is ONTcDNA_reads.txt

paste <(find ../raw-data/HPRC_Annotation_PhaseI/ -name *.fastq.gz | grep "RNA-Seq/" | sort | sed 's:../raw-data/HPRC_Annotation_PhaseI/::g' | sed 's:/:\t:g' | cut -f2,4 | grep -v "_S1_" | grep -v "_S2_" | paste -s -d' \n' | tr " " "\t" | cut -f1-2,4 ) > RNAseq_reads.txt

#finds filepaths for fastq.gz files in the RNA-seq folder and creates a sorted file.  Portion of the filepath is removed, tabs replace /, columns 1 and 3 removed from the file generated a file named RNAseq_reads.txt.
