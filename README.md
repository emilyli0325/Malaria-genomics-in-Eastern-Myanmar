# Malaria-genomics-in-Eastern-Myanmar

Impact of intensive control on malaria population genomics in Eastern Myanmar

The malaria elimination program in Kayin State (Myanmar) utilizes malaria posts for rapid detection and treatment together with mass drug administration (MDA) in high transmission villages, and has reduced transmission by 97%. We examined the impact of control on parasite genomic parameters, using 2270 genome sequenced Plasmodium falciparum infections from 283 malaria posts, sampled over 58-months (2015 - 2020). Parasites were genetically depauperate: 1781 single-genotype infections comprised 166 unique genomes (≥90% identity by descent, IBD), while nine families (≥45% IBD) accounted for 66.9% of parasites sampled. Parasite effective population size decreased over the study period, but there was minimal change in artemisinin resistance alleles until 2020, when just one predominant genotype (carrying kelch13-R561H) remained. We observed sustained localized transmission of unique parasite genotypes revealing transmission chains: this resulted in positive correlations in parasite relatedness for ≤20 km. MDA resulted in parasite founder effects, providing genomic evidence for the efficacy of this control tool. These results reveal changes in population structure driven by control, and rapid shifts in allele frequency in a parasite population close to elimination.

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

9. Updated Fws analysis
This is an R implementation of the Fws calculation, adapted from the Python version used in the Pf8 dataset (www.malariagen.net/data_package/open-dataset-plasmodium-falciparum-v80/).


# Data
genetic distance (1-IBD proportion)

geographic distance (km) 

temporal distance (days)

# [DOI: 10.5281/zenodo.15791463](https://doi.org/10.5281/zenodo.15791462)
