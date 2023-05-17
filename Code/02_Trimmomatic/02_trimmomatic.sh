#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 10
#SBATCH -t 08:00:00
#SBATCH -J bwa_rna_to_dna_to_htseq
#SBATCH --mail-type=ALL
#SBATCH --mail-user alex.ajangu.6940@student.uu.se

module load bioinfo-tools
module load trimmomatic

cd /proj/genomeanalysis2023/nobackup/work/alaj6940/trimmomatic

rna=/home/alaj6940/Genome_Analysis_Project_2_Ajangu/Data/2_Christel_2017/RNA_raw_data

trimmomatic PE $rna/ERR2036629_1.fastq.gz $rna/ERR2036629_2.fastq.gz $rna/ERR2036630_1.fastq.gz $rna/ERR2036630_2.fastq.gz \
$rna/ERR2036631_1.fastq.gz $rna/ERR2036631_2.fastq.gz $rna/ERR2036632_1.fastq.gz $rna/ERR2036632_2.fastq.gz \
$rna/ERR2036633_1.fastq.gz $rna/ERR2036633_2.fastq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 MINLEN:36
