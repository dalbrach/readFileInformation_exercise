#!/bin/bash

#find, sort and print all .fastq.gz filepaths in the 'HiC/' folder with the '../raw-data/HPRC_Annotation_PhaseI/ portion removed.  Next replace all '/' with 'tab'.  Next paste all 'R1' and 'R2' files in the same line (into column 3).  Next, remove all occurrances of " HiC'tab' with 'tab', then cut out columns 1 and 4.  Next, duplicate column 2 into column 2 to create a column for the replicate info.  Next, in column 2, replace any filename indicating replicate 1 or 2 with '1' or '2'.  Output filename 'HiC_manifest_reads.txt.

paste <(find ../raw-data/HPRC_Annotation_PhaseI/ -name *.fastq.gz | grep "HiC/" | sort | sed 's:../raw-data/HPRC_Annotation_PhaseI/::g' | sed 's:/:\t:g' |  paste -s -d' \n' | sed 's: HiC\t:\t:g' | cut -f2,3,5 | awk '{print $1"\t"$2"\t"$2"\t"$3}' | awk -F'\t' -vOFS='\t' '{ gsub(".......-1.........................", "1", $2) ; gsub(".......-2.........................", "2", $2) ; gsub (".......-1........................", "1", $2) ; gsub(".......-2........................", "2", $2) ;  print}'1 | uniq ) > HiC_manifest_reads.txt


#find, sort and print all .fastq.gz filepaths in the 'ATAC-Seq/' folder with the '../raw-data/HPRC_Annotation_PhaseI/ portion removed.  Next replace all '/' with 'tab'. Cut out all columns except 2 and 3.   Next paste all 'R1' and 'R2' files in the same line (into column 3). Any occurrance of a certain string appended to filename removed and replaced with 'tab'.  Next, duplicate column 2 into column 2 to create a column for the replicate info.  Next, in column 2, replace any filename indicating replicate A or B with '1' or '2'.  Next, rows containing barcode indexing (I1 and I2) are removed.  Output filename ATACseq_manifest_reads.txt 

paste <(find ../raw-data/HPRC_Annotation_PhaseI/ -name *.fastq.gz | grep "ATAC-Seq/" | sort | sed 's:../raw-data/HPRC_Annotation_PhaseI/::g' | sed 's:/:\t:g' | cut -f2,3 | paste -s -d' \n' | sed 's: HG0....:\t:g' | awk '{print $1"\t"$2"\t"$2"\t"$3}' |  awk -F'\t' -vOFS='\t' '{ gsub(".................-A-..........................................", "A", $2) ; gsub(".................-B-..........................................", "B", $2) ; gsub("..........-A-.........................................", "A", $2) ; gsub("..........-B-.........................................", "B", $2) ; gsub("..........HG0....A-.........................................", "A", $2) ; gsub ("..........HG0....B-.........................................", "B", $2) ; gsub (".........-A-.........................................", "A", $2) ; gsub (".........-B-.........................................", "B", $2) ; print}'1 | grep -v "_I1_" | grep -v "_I2_") > ATACseq_manifest_reads.txt

#find, sort and print all .fastq.gz filepaths in the 'ONT_cDNA/' folder with the '../raw-data/HPRC_Annotation_PhaseI/ portion removed. Next replaced all '/' with 'tab' and cut all columns except 2, 4 and 5 and then removed all occurances of just 'tab' with 'tab'tab'.  Output filename is ONTcDNA_manifest_reads.txt

paste <(find ../raw-data/HPRC_Annotation_PhaseI/ -name *.fastq.gz | grep "ONT_cDNA/" | sort | sed 's:../raw-data/HPRC_Annotation_PhaseI/::g' | sed 's:/:\t:g' | cut -f2,4,5 | sed 's:\t:\t\t:1') > ONTcDNA_manifest_reads.txt

#find, sort and print all .fastq.gz filepaths in the 'RNA-Seq/' folder with the '../raw-data/HPRC_Annotation_PhaseI/ portion removed.  Next replace all '/' with 'tab'.  Next, remove all columns except 2 and 4.  Next paste all 'R1' and 'R2' files in the same line (into column 3). Remove appended strings in cells.  Next, duplicate column 2 into column 2 to create a column for the replicate info.  Next, in column 2, replace any filename indicating replicate 1 or 2 with '1' or '2'. Output filename is RNAseq_manifest_reads.txt.

paste <(find ../raw-data/HPRC_Annotation_PhaseI/ -name *.fastq.gz | grep "RNA-Seq/" | sort | sed 's:../raw-data/HPRC_Annotation_PhaseI/::g' | sed 's:/:\t:g' | cut -f2,4 |  paste -s -d' \n' | sed 's:.gz.HG002:.gz:g' | sed 's:L003_R1.fastq.gz.HG.....:L003_R1.fastq.gz:g' | awk '{print $1"\t"$2"\t"$2"\t"$3}' |  awk -F'\t' -vOFS='\t' '{ gsub("hg....._1.......................................................................", "1", $2) ; gsub("hg....._2.......................................................................", "2", $2) ; gsub("hg......................................................","", $2) ; gsub("......................","", $2) ; gsub(".......","", $2) ; print }'1)  > RNAseq_manifest_reads.txt

#Cat all files together

cat HiC_manifest_reads.txt ATACseq_manifest_reads.txt ONTcDNA_manifest_reads.txt RNAseq_manifest_reads.txt > full_manifest_list.txt

#remove files HiC_manifest_reads.txt ATACseq_manifest_reads.txt ONTcDNA_manifest_reads.txt RNAseq_manifest_reads.txt

rm HiC_manifest_reads.txt ATACseq_manifest_reads.txt ONTcDNA_manifest_reads.txt RNAseq_manifest_reads.txt
