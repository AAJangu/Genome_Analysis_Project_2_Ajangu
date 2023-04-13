#!/bin/bash -l

#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 12:00:00
#SBATCH -J Canu_Alex_Ajangu
#SBATCH --mail-type=ALL
#SBATCH --mail-user alaj6940@student.uu.se

# Load modules
module load bioinfo-tools
module load canu

# Commands
canu -p Canu_Chirstel_17 \
-d /domus/h1/alaj6940/Genome_Analysis_Project_2_Ajangu/Analysis/01_genome_assembly \
genomeSize=2.41m useGrid=false -pacbio /domus/h1/alaj6940/Genome_Analysis_Project_2_Ajangu/Data/DNA/DNA_raw_data/DNA_raw_data/E*
