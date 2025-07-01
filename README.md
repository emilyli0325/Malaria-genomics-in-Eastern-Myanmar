# Malaria-genomics-in-Eastern-Myanmar

Malaria parasite population genomics during an elimination program in Eastern Myanmar

We investigated parasite population genomics during an intensive malaria elimination program in Kayin State (Myanmar), in which malaria posts were used for rapid detection and treatment of malaria cases, while mass drug administration (MDA) was used in villages with high submicroscopic reservoirs. 
We collected 5014 dried blood spots from Plasmodium falciparum infected patients from 413 malaria posts, over 58-months (November 2015 - August 2020), and sequenced 2270 parasite genomes, each with geographic references (latitude and longitude)tagged by geographic location. We used identity-by-descent (IBD) relationships to examine how control efforts impact parasite population structure.
Parasites were genetically depauperate: 1726 single-genotype infections comprised 166 unique genomes (≥90% IBD), while nine families (≥45% IBD) accountaccounted for 62·5% of parasites sampled. We observed localized, temporally stable transmission of unique parasite genotypes, identifying transmission chains. Parasite relatedness was positively correlated up to approximatelyfor 20 km revealing the scale of parasite subpopulations. Kelch13 diversity was stable from 2016-2019, but only one predominant clonal genotype (kelch13-R561H) remained in 2020.  MDA resulted in parasite founder effects, providing genomic evidence for the efficacy of this malaria control tool. 
Our genomic data show that parasite population size decreased over the study period, and we observed regional distribution of parasite genotypes, which can define operational units for parasite control. One parasite genotype (kelch13-R561H) from the north rose to high frequency in 2020, because transmission was halted elsewhere in the control area. Future surveillance will reveal whether this genotype spreads to neighboring regions. Genetic drift may have a stronger impact on parasite population structure than selection in low-transmission elimination settings.

# Contents
# Code
1. Mapping.sh
Performs read alignment to the reference genome using tools such as BWA and Samtools.

2. Genotype.sh
Calls SNPs and indels from the aligned reads using GATK . The output is a VCF file containing genotype calls for all samples.

3. hmmIBD.sh
Runs the hmmIBD tool to identify IBD segments between parasite samples, providing pairwise relatedness measures.

4. drug.resistance.loci.sh
Extracts genotypes for known drug resistance loci, useful for molecular surveillance of antimalarial resistance.

5. distance.relatedness.R
Calculates genetic distances and visualizes relatedness matrices based on IBD data.

6. single.IBD.cluster.analysis.R
Performs analysis of closely related parasites.

7. Correlograms.R
Correlogram analysis of pair-wise parasite relatedness across space and time.

8. MDA.impact.R
Analyzes the impact of Mass Drug Administration on parasite population structure and diversity, using pre- and post-MDA datasets.

# Data
genetic distance (1-IBD proportion)
geographic distance (km) 
temporal distance (days)
