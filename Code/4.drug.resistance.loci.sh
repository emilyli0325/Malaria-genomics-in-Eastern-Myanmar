
################################################################################################
###############################        kelch13     #############################################
# METF
java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
   -T SelectVariants \
   -R /master/xli/Index/Pfal32_GATK_index/PlasmoDB-32_Pfalciparum3D7_Genome.fasta \
   -L Pf3D7_13_v3:1724817-1726997 \
   -V Myan.allMETF.core.diploid.SNP.VQSLOD0.ann.vcf \
   --sample_file METF.single.list \
   -o drug.resistance.loci/Myan.allMETF.SNP.kelch13.ann.vcf

cd drug.resistance.loci

java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
-T VariantsToTable \
-R /master/xli/Index/Pfal32_GATK_index/PlasmoDB-32_Pfalciparum3D7_Genome.fasta \
-V Myan.allMETF.SNP.kelch13.ann.vcf \
-F CHROM -F POS -F REF -F ALT -F EFF \
-GF GT \
-o Myan.allMETF.SNP.kelch13.ann.GT

################################################################################################
###############################        pfcrt     ###############################################

java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
   -T SelectVariants \
   -R /master/xli/Index/Pfal32_GATK_index/PlasmoDB-32_Pfalciparum3D7_Genome.fasta \
   -L Pf3D7_07_v3:403,222-406,317 \
   -V Myan.allMETF.core.diploid.SNP.VQSLOD0.ann.vcf \
   --sample_file METF.single.list \
   -o drug.resistance.loci/Myan.allMETF.SNP.pfcrt.ann.vcf

cd drug.resistance.loci

java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
-T VariantsToTable \
-R /master/xli/Index/Pfal32_GATK_index/PlasmoDB-32_Pfalciparum3D7_Genome.fasta \
-V Myan.allMETF.SNP.pfcrt.ann.vcf \
-F CHROM -F POS -F REF -F ALT -F EFF \
-GF GT \
-o Myan.allMETF.SNP.pfcrt.ann.GT

################################################################################################
###############################        pfaat1     ###############################################

java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
   -T SelectVariants \
   -R /master/xli/Index/Pfal32_GATK_index/PlasmoDB-32_Pfalciparum3D7_Genome.fasta \
   -L Pf3D7_06_v3:1213948-1216005 \
   -V Myan.allMETF.core.diploid.SNP.VQSLOD0.ann.vcf \
   --sample_file METF.single.list \
   -o drug.resistance.loci/Myan.allMETF.SNP.aat1.ann.vcf

cd drug.resistance.loci

java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
-T VariantsToTable \
-R /master/xli/Index/Pfal32_GATK_index/PlasmoDB-32_Pfalciparum3D7_Genome.fasta \
-V Myan.allMETF.SNP.aat1.ann.vcf \
-F CHROM -F POS -F REF -F ALT -F EFF \
-GF GT \
-o Myan.allMETF.SNP.aat1.ann.GT
