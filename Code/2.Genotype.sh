##################################################
##### METF Myan samples ##########################
##################################################

#### B1-B6
# Genotype_diploid_core genome
java -Xmx60g -jar /master/xli/software/GATK/GenomeAnalysisTK.jar -T GenotypeGVCFs \
-R /data/infectious/malaria_XUE/sWGA/Index/Pfal3D7_hg19.fa \
-L /master/xli/Index/Known_sites/Core_Genome.intervals \
--max_alternate_alleles 6 --variant_index_type LINEAR --variant_index_parameter 128000 \
-V /data/infectious/malaria_XUE/sWGA/sequence.before.2018/Batch_1/g.vcf.ploidy2/Batch_1.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.before.2018/Batch_2_TAM/g.vcf.ploidy2/Batch_2_1.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.before.2018/Batch_2_TAM/g.vcf.ploidy2/Batch_2_2.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.before.2018/Batch_2_TAM/g.vcf.ploidy2/Batch_2_3.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.042019/g.vcf.ploidy2/Batch_4_1.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.042019/g.vcf.ploidy2/Batch_4_2.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.042019/g.vcf.ploidy2/Batch_4_7.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.042019/g.vcf.ploidy2/Batch_4_3.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.042019/g.vcf.ploidy2/Batch_4_4.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.042019/g.vcf.ploidy2/Batch_4_5.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.042019/g.vcf.ploidy2/Batch_4_6.diploid.g.vcf \
-V /master/xli/sWGA.sequence5.092019/g.vcf.ploidy2/Batch_5_1.ploidy2.g.vcf \
-V /master/xli/sWGA.sequence5.092019/g.vcf.ploidy2/Batch_5_2.ploidy2.g.vcf \
-V /master/xli/sWGA.sequence5.092019/g.vcf.ploidy2/Batch_5_3.ploidy2.g.vcf \
-V /master/xli/sWGA.sequence5.092019/g.vcf.ploidy2/Batch_5_4.ploidy2.g.vcf \
-V /master/xli/sWGA.sequence5.092019/g.vcf.ploidy2/Batch_5_5.ploidy2.g.vcf \
-V /master/xli/sWGA.sequence5.092019/g.vcf.ploidy2/Batch_5_6.ploidy2.g.vcf \
-V /master/xli/sWGA.sequence6.072020/g.vcf.ploidy2/Batch_6_1.ploidy2.g.vcf \
-V /master/xli/sWGA.sequence6.072020/g.vcf.ploidy2/Batch_6_2.ploidy2.g.vcf \
-V /master/xli/sWGA.HRP.06.2021/g.vcf.ploidy2/Batch_HRP.ploidy2.g.vcf \
-V /master/xli/sWGA.military.082021/g.vcf.ploidy2/Batch_military.ploidy2.g.vcf \
-V /master/xli/sWGA.military.082021/g.vcf.ploidy2/MP4933.ploidy2.g.vcf \
--sample_ploidy 2 -nt 20 \
-o /master/xli/Myan.2021.allMETF/Myan.allMETF.core.diploid.vcf

# Genotype_diploid_whole genome
java -Djava.io.tmpdir=/master/xli/Myan.2021.allMETF/temp/ -Xmx60g -jar /master/xli/software/GATK/GenomeAnalysisTK.jar -T GenotypeGVCFs \
-R /data/infectious/malaria_XUE/sWGA/Index/Pfal3D7_hg19.fa \
-L /master/xli/Index/Known_sites/Genome.intervals \
--max_alternate_alleles 6 --variant_index_type LINEAR --variant_index_parameter 128000 \
-V /data/infectious/malaria_XUE/sWGA/sequence.before.2018/Batch_1/g.vcf.ploidy2/Batch_1.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.before.2018/Batch_2_TAM/g.vcf.ploidy2/Batch_2_1.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.before.2018/Batch_2_TAM/g.vcf.ploidy2/Batch_2_2.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.before.2018/Batch_2_TAM/g.vcf.ploidy2/Batch_2_3.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.042019/g.vcf.ploidy2/Batch_4_1.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.042019/g.vcf.ploidy2/Batch_4_2.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.042019/g.vcf.ploidy2/Batch_4_7.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.042019/g.vcf.ploidy2/Batch_4_3.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.042019/g.vcf.ploidy2/Batch_4_4.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.042019/g.vcf.ploidy2/Batch_4_5.diploid.g.vcf \
-V /data/infectious/malaria_XUE/sWGA/sequence.042019/g.vcf.ploidy2/Batch_4_6.diploid.g.vcf \
-V /master/xli/sWGA.sequence5.092019/g.vcf.ploidy2/Batch_5_1.ploidy2.g.vcf \
-V /master/xli/sWGA.sequence5.092019/g.vcf.ploidy2/Batch_5_2.ploidy2.g.vcf \
-V /master/xli/sWGA.sequence5.092019/g.vcf.ploidy2/Batch_5_3.ploidy2.g.vcf \
-V /master/xli/sWGA.sequence5.092019/g.vcf.ploidy2/Batch_5_4.ploidy2.g.vcf \
-V /master/xli/sWGA.sequence5.092019/g.vcf.ploidy2/Batch_5_5.ploidy2.g.vcf \
-V /master/xli/sWGA.sequence5.092019/g.vcf.ploidy2/Batch_5_6.ploidy2.g.vcf \
-V /master/xli/sWGA.sequence6.072020/g.vcf.ploidy2/Batch_6_1.ploidy2.g.vcf \
-V /master/xli/sWGA.sequence6.072020/g.vcf.ploidy2/Batch_6_2.ploidy2.g.vcf \
-V /master/xli/sWGA.HRP.06.2021/g.vcf.ploidy2/Batch_HRP.ploidy2.g.vcf \
-V /master/xli/sWGA.military.082021/g.vcf.ploidy2/Batch_military.ploidy2.g.vcf \
-V /master/xli/sWGA.military.082021/g.vcf.ploidy2/MP4933.ploidy2.g.vcf \
--sample_ploidy 2 -nt 20 \
-o /master/xli/Myan.2021.allMETF/Myan.allMETF.whole.diploid.vcf

# Seperate SNP - whole
java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
-T SelectVariants \
-R /data/infectious/malaria_XUE/sWGA/Index/Pfal3D7_hg19.fa \
-V Myan.allMETF.whole.diploid.vcf \
-selectType SNP -o Myan.allMETF.whole.diploid.SNP.di.vcf

# Seperate SNP - core
java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
-T SelectVariants \
-R /data/infectious/malaria_XUE/sWGA/Index/Pfal3D7_hg19.fa \
-V Myan.allMETF.core.diploid.vcf \
-selectType SNP -o Myan.allMETF.core.diploid.SNP.di.vcf

# Seperate Indel - whole
java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
-T SelectVariants \
-R /data/infectious/malaria_XUE/sWGA/Index/Pfal3D7_hg19.fa \
-V Myan.allMETF.whole.diploid.vcf \
-selectType INDEL -o Myan.allMETF.whole.diploid.INDEL.di.vcf

# Seperate INDEL - core
java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
-T SelectVariants \
-R /data/infectious/malaria_XUE/sWGA/Index/Pfal3D7_hg19.fa \
-V Myan.allMETF.core.diploid.vcf \
-selectType INDEL -o Myan.allMETF.core.diploid.INDEL.di.vcf

# VQSR
java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
	-T VariantRecalibrator \
	-R /master/xli/Index/Pfal32_GATK_index/PlasmoDB-32_Pfalciparum3D7_Genome.fasta \
    -input Myan.allMETF.whole.diploid.SNP.di.vcf \
	--resource:dbsnp,known=true,training=true,truth=true,prior=15.0 /master/xli/Index/Known_sites/3d7_hb3.combined.final.karo.sort.vcf \
	--resource:dbsnp,known=true,training=true,truth=true,prior=15.0 /master/xli/Index/Known_sites/7g8_gb4.combined.final.karo.sort.vcf \
	--resource:dbsnp,known=true,training=true,truth=true,prior=15.0 /master/xli/Index/Known_sites/hb3_dd2.combined.final.karo.sort.vcf \
	-an QD -an FS -an SOR -an DP \
	-mode SNP \
	-tranche 100.0 -tranche 99.9 -tranche 99.0 -tranche 90.0 \
    --maxGaussians 4 \
    -recalFile recalibrate_SNP.recal \
    -tranchesFile recalibrate_SNP.tranches \
    -rscriptFile recalibrate_SNP_plots.R
	
java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
    -T ApplyRecalibration \
    -R /master/xli/Index/Pfal32_GATK_index/PlasmoDB-32_Pfalciparum3D7_Genome.fasta \
    -input Myan.allMETF.whole.diploid.SNP.di.vcf \
    -mode SNP \
    --ts_filter_level 99 \
    -recalFile recalibrate_SNP.recal \
    -tranchesFile recalibrate_SNP.tranches \
    -o Myan.allMETF.whole.diploid.SNP.VQSR.vcf 

java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
	-T VariantRecalibrator \
	-R /master/xli/Index/Pfal32_GATK_index/PlasmoDB-32_Pfalciparum3D7_Genome.fasta \
    -input Myan.allMETF.whole.diploid.INDEL.di.vcf \
	--resource:dbsnp,known=true,training=true,truth=true,prior=15.0 /master/xli/Index/Known_sites/3d7_hb3.combined.final.karo.sort.vcf \
	--resource:dbsnp,known=true,training=true,truth=true,prior=15.0 /master/xli/Index/Known_sites/7g8_gb4.combined.final.karo.sort.vcf \
	--resource:dbsnp,known=true,training=true,truth=true,prior=15.0 /master/xli/Index/Known_sites/hb3_dd2.combined.final.karo.sort.vcf \
	-an QD -an FS -an SOR -an DP \
	-mode INDEL \
	-tranche 100.0 -tranche 99.9 -tranche 99.0 -tranche 90.0 \
    --maxGaussians 4 \
    -recalFile recalibrate_INDEL.recal \
    -tranchesFile recalibrate_INDEL.tranches \
    -rscriptFile recalibrate_INDEL_plots.R
	
java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
    -T ApplyRecalibration \
    -R /master/xli/Index/Pfal32_GATK_index/PlasmoDB-32_Pfalciparum3D7_Genome.fasta \
    -input Myan.allMETF.whole.diploid.INDEL.di.vcf \
    -mode INDEL \
    --ts_filter_level 99 \
    -recalFile recalibrate_INDEL.recal \
    -tranchesFile recalibrate_INDEL.tranches \
    -o Myan.allMETF.whole.diploid.INDEL.VQSR.vcf 

# filter VQSLOD >0
export PATH=$PATH:/master/xli/software/FreeBayes/vcflib/bin
vcffilter -f "VQSLOD > 0" Myan.allMETF.whole.diploid.SNP.VQSR.vcf > Myan.allMETF.whole.diploid.SNP.VQSLOD0.vcf
vcffilter -f "VQSLOD > 0" Myan.allMETF.whole.diploid.INDEL.VQSR.vcf  > Myan.allMETF.whole.diploid.INDEL.VQSLOD0.vcf	

## select core genome loci
# SNP
java -Xmx50g -Djava.io.tmpdir=/master/xli/Myan.2021.allMETF/temp -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
-T SelectVariants \
-L /master/xli/Index/Known_sites/Core_Genome.intervals \
-R /master/xli/Index/Pfal32_GATK_index/PlasmoDB-32_Pfalciparum3D7_Genome.fasta \
-V Myan.allMETF.whole.diploid.SNP.VQSLOD0.vcf \
-selectType SNP -o Myan.allMETF.core.diploid.SNP.VQSLOD0.vcf

# INDEL
java -Xmx50g -Djava.io.tmpdir=/master/xli/Myan.2021.allMETF/temp -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
-T SelectVariants \
-L /master/xli/Index/Known_sites/Core_Genome.intervals \
-R /master/xli/Index/Pfal32_GATK_index/PlasmoDB-32_Pfalciparum3D7_Genome.fasta \
-V Myan.allMETF.whole.diploid.INDEL.VQSLOD0.vcf	 \
-selectType INDEL -o Myan.allMETF.core.diploid.INDEL.VQSLOD0.vcf

####################################################################################################
###############     Fws analysis  see code 9   ###############################################################

