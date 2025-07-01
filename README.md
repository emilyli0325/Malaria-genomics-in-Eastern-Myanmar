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
#########  genetic distance (1-IBD proportion)
> dim(dist_matrix)
[1] 1726 1726
> dist_matrix[1:5,1:5]
            METF.HRP.1 METF.HRP.11 METF.HRP.13 METF.HRP.14 METF.HRP.15
METF.HRP.1       0.000       0.975       1.000       1.000       0.913
METF.HRP.11      0.975       0.000       0.982       0.969       0.940
METF.HRP.13      1.000       0.982       0.000       0.988       0.960
METF.HRP.14      1.000       0.969       0.988       0.000       0.989
METF.HRP.15      0.913       0.940       0.960       0.989       0.000

#########  geographic distance (km) 
> dim(geo_dist)
[1] 1726 1726
> geo_dist[1:5,1:5]
            METF.HRP.1 METF.HRP.11 METF.HRP.13 METF.HRP.14 METF.HRP.15
METF.HRP.1        0.00        7.63       27.29       19.02       55.54
METF.HRP.11       7.63        0.00       23.13       25.52       51.06
METF.HRP.13      27.29       23.13        0.00       46.03       28.26
METF.HRP.14      19.02       25.52       46.03        0.00       74.17
METF.HRP.15      55.54       51.06       28.26       74.17        0.00

#########  temporal distance (days)
> dim(dis.temporal)
[1] 1726 1726
> dis.temporal[1:5,1:5]
            METF.HRP.1 METF.HRP.11 METF.HRP.13 METF.HRP.14 METF.HRP.15
METF.HRP.1           0         491        1126         422          33
METF.HRP.11        491           0         635          69         458
METF.HRP.13       1126         635           0         704        1093
METF.HRP.14        422          69         704           0         389
METF.HRP.15         33         458        1093         389           0


