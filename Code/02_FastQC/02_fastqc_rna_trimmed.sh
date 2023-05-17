#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 10
#SBATCH -t 05:00:00
#SBATCH -J FastQC_rna_raw
#SBATCH --mail-type=ALL
#SBATCH --mail-user alex.ajangu.6940@student.uu.se

#modules
module load bioinfo-tools
module load FastQC
module list

#Path variables
SRCDIR=/domus/h1/alaj6940/Genome_Analysis_Project_2_Ajangu/Analysis/02_rna_processing/
rna_trimmed=/domus/h1/alaj6940/Genome_Analysis_Project_2_Ajangu/Data/2_Christel_2017/RNA_trimmed_reads/*

# code
fastqc -o /domus/h1/alaj6940/Genome_Analysis_Project_2_Ajangu/Analysis/02_rna_processing/ -t 10 /domus/h1/alaj6940/Genome_Analysis_Project_2_Ajangu/Data/2_Christel_2017/RNA_trimmed_reads/*


