#!/bin/bash -l                                                                                          
#SBATCH -A uppmax2023-2-8                                                                                                             
#SBATCH -M snowy                                                                                                                      
#SBATCH -p core                                                                                                                       
#SBATCH -n 4                                                                                                                          
#SBATCH -t 00:30:00                                                                                                                   
#SBATCH -J quast_AA                                                                                                           
#SBATCH --mail-type=ALL                                                                                                               
#SBATCH --mail-user alaj6940@student.uu.se                                                               

# Load modules
module load bioinfo-tools 
module load quast

#paths
canu_product=/domus/h1/alaj6940/Genome_Analysis_Project_2_Ajangu/Analysis/01_genome_assembly/Canu_Chirstel_17.contigs.fasta
reference=/domus/h1/alaj6940/Genome_Analysis_Project_2_Ajangu/Data/2_Christel_2017/reference/OBMB01.fasta

# Commands

quast.py $canu_product -o . -R $reference 
