#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 10
#SBATCH -t 08:00:00
#SBATCH -J bwa_rna_to_dna_to_htseq
#SBATCH --mail-type=ALL
#SBATCH --mail-user alex.ajangu.6940@student.uu.se

# Modules
module load bioinfo-tools
module load bwa
module load samtools
module load htseq
module list

# To home dir
cd /proj/genomeanalysis2023/nobackup/work/alaj6940 

# Path variables
#dna_assembled=/home/alaj6940/Genome_Analysis_Project_2_Ajangu/Analysis/01_genome_assembly/Canu_Chirstel_17.contigs.fasta
rna_tr=/home/alaj6940/Genome_Analysis_Project_2_Ajangu/Data/2_Christel_2017/RNA_trimmed_reads
prokka_gff=/home/alaj6940/Genome_Analysis_Project_2_Ajangu/Analysis/01_genome_annotation/01_Prokka_Combined.gff
index_file=/home/alaj6940/Genome_Analysis_Project_2_Ajangu/Analysis/02_rna_aligning/canu_index.fasta

# dna_assembled to indexed file -> worked, else didn't, wont run it twice
#bwa index $dna_assembled -p canu_index.fasta

# rna alignment to assembled and indexed dna | samtools sort | htsq-count
for i in {29..33}
do
bwa mem -t 10 "$index_file" \
"$rna_tr/ERR20366${i}_P1.trim.fastq.gz" "$rna_tr/ERR20366${i}_P2.trim.fastq.gz" | samtools sort \
-o "ERR20366${i}.bam" 
htseq-count -t CDS -i ID -f bam -s no -r pos "ERR20366${i}.bam" "$prokka_gff" > "02_output_ERR20366${i}.txt"
done


