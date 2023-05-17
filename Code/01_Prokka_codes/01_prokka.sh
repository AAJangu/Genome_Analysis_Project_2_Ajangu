#!/bin/bash -l                                                                                          
#SBATCH -A uppmax2023-2-8                                                                               
#SBATCH -M snowy                                                                                        
#SBATCH -p core                                                                                         
#SBATCH -n 15                                                                                           
#SBATCH -t 15:00:00                                                                                     
#SBATCH -J prokka                                                                            
#SBATCH --mail-type=ALL                                                                                 
#SBATCH --mail-user alex.ajangu.6940@student.uu.se                                   

#modules
module load bioinfo-tools             
module load prokka
module list 

# Set working directory                                                                       
cd $SNIC_TMP 

#Path variables
export SRCDIR=/domus/h1/alaj6940/Genome_Analysis_Project_2_Ajangu/Analysis/01_genome_annotation
dna_assembly=/domus/h1/alaj6940/Genome_Analysis_Project_2_Ajangu/Analysis/01_genome_assembly/*.contigs.fasta

# code
prokka $dna_assembly --outdir $SRCDIR --force --prefix 01_Prokka_Combined --addgenes

#echo "Done! Files in /Analysis/01_genome_annotation"
