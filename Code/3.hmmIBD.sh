
################################################################################################
###############################        IBD analysis - hard filter     #########################
###############################            METF samples               #########################
################################################################################################
cd /master/xli/Myan.2021.allMETF/filter.for.IBD
export PATH=$PATH:/master/xli/software/FreeBayes/vcflib/bin
vcffilter -f "QD > 2.0 & FS < 60.0 & SOR < 3.0" -g "DP > 3 & GQ > 90"  Myan.allMETF.core.diploid.SNP.VQSLOD0.vcf  > Myan.core.SNP.di.hardfilter-forIBD.vcf
 
java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
   -T SelectVariants \
   -R /master/xli/Index/Pfal32_GATK_index/PlasmoDB-32_Pfalciparum3D7_Genome.fasta \
   -L /master/xli/Index/Known_sites/Core_Genome.intervals \
   -V Myan.core.SNP.di.hardfilter-forIBD.vcf \
   --restrictAllelesTo BIALLELIC -nt 10 \
   --sample_file METF.single.list \
   -o Myan.core.diSNP.hardfilter.biallelic.singleInf.vcf 

### '0/1' to non-call
# HetFilter
java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
-T VariantFiltration \
-R /master/xli/Index/Pfal32_GATK_index/PlasmoDB-32_Pfalciparum3D7_Genome.fasta \
-L /master/xli/Index/Known_sites/Core_Genome.intervals \
--variant Myan.core.diSNP.hardfilter.biallelic.singleInf.vcf  \
--genotypeFilterExpression "isHet == 1" \
--genotypeFilterName "HetFilter" \
--setFilteredGtToNocall \
--out Myan.core.SNP.hardfilter.singleInf.rmHet.vcf

### count sample GT ratio
/data/infectious/malaria_XUE/sWGA/Thai_sample/Sanger.Thai.2018/Genotype.ploidy2/filter_missing_ind.sh Myan.core.SNP.hardfilter.singleInf.rmHet.vcf Myan.core.SNP.hardfilter.singleInf.rmHet.lowSamp  

vcftools --vcf Myan.core.SNP.hardfilter.singleInf.rmHet.vcf --max-missing 0.5 --maf 0.05 --recode --out Myan.core.SNP.hardfilter.singleInf.rmHet.GT0.5.maf0.05

After filtering, kept 1726 out of 1726 Individuals
After filtering, kept 13298 out of a possible 512827 Sites

## DP4, GT 0.5, MAF 0.05, remove Het, GQ 90, hardfilter
java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar \
-T VariantsToTable \
-R /master/xli/Index/Pfal32_GATK_index/PlasmoDB-32_Pfalciparum3D7_Genome.fasta \
-V Myan.core.SNP.hardfilter.singleInf.rmHet.GT0.5.maf0.05.recode.vcf \
-F CHROM -F POS -F REF -F ALT \
-GF GT \
-o Myan.core.SNP-forIBD.GT

#### format for hmmIBD in R

## data clean
setwd("C:/Users/xli.TXBIOMED/Dropbox (TX Biomed)/Emily/3.Myan/4.final.Myan.2021/3.IBD")
Input <- read.delim("Myan.core.SNP-forIBD.GT", sep="\t",header=T)

GT <- Input[,seq(5,1730,1)]
GT.A <- function(X){unlist(strsplit(as.character(X),"\\/"))[1]}

GT.Aallele <- matrix(ncol=1726,nrow=13298)
for(j in 1:1726){
GT.Aallele[,j] <- sapply(GT[,j], GT.A, simplify="array")
}

GT.Aallele[GT.Aallele== "."]<-NA
colnames(GT.Aallele)<- colnames(GT)

GT.count <- colSums(is.na(GT.Aallele))
write.csv(GT.count, "Myan.core.SNP-forIBD.count.csv")


GT.recode<-NULL
REF <- as.character(Input[,3])
ALT <- as.character(Input[,4])

for(i in c(1:1726)){
    X<-as.character(GT.Aallele[,i])
    Z<-NULL; 
	Z[which(X==REF & is.na(X)==F)]<- 0; 
	Z[which(X==ALT & is.na(X)==F)]<- 1; 
	Z[which(is.na(X)==T)]<- "-1";
    GT.recode <- cbind(GT.recode,Z)
}


GT.recode <- cbind(Input[,1:2],GT.recode)
colnames(GT.recode) <- c("chrom", "pos",gsub("\\.GT|\\.\\.GT","",colnames(GT)[1:1726]))
GT.recode.cleanChr <- GT.recode
GT.recode.cleanChr$chrom <- gsub("\\_v3|Pf3D7\\_0|Pf3D7\\_","",GT.recode$chrom)

write.table(GT.recode.cleanChr,"Myan.core.SNP.hmmIBD.input.txt",row.names=F,col.names=T,sep="\t", quote=FALSE)


#### hmmIBD
## METF
/master/xli/software/hmmIBD/hmmIBD-master/hmmIBD -i Myan.core.SNP.hmmIBD.input.txt -o Myan.core.SNP.hmmIBD

### >90% IBD
awk '{ if ($10 >= 0.90) print $0 }' Myan.core.SNP.hmmIBD.hmm_fract.txt > Myan.core.SNP.hmmIBD.hmm_fract_0.9.txt
awk '{ if ($10 > 0.35) print $0 }' Myan.core.SNP.hmmIBD.hmm_fract.txt > Myan.core.SNP.hmmIBD.hmm_fract_0.35.txt
awk '{ if ($10 > 0.15) print $0 }' Myan.core.SNP.hmmIBD.hmm_fract.txt > Myan.core.SNP.hmmIBD.hmm_fract_0.15.txt
awk '{ if ($10 < 0.75 && $10 > 0.35) print $0 }' Myan.core.SNP.hmmIBD.hmm_fract.txt > Myan.core.SNP.hmmIBD.hmm_fract_0.35-0.75.txt

## representative samples
/master/xli/software/hmmIBD/hmmIBD-master/hmmIBD -i Myan.core.SNP.hmmIBD.input.txt -o Myan.core.SNP.hmmIBD_representative -b SampleID_NONrepresentative_skip.txt
awk '{ if ($10 > 0.15) print $0 }' Myan.core.SNP.hmmIBD_representative.hmm_fract.txt > Myan.core.SNP.hmmIBD_representative.hmm_fract_0.15.txt

## representative samples 
/master/xli/software/hmmIBD/hmmIBD-master/hmmIBD -i Myan.core.SNP.hmmIBD.input.txt -o Myan.core.SNP.hmmIBD_representative -b kelch13.IBD/Non-METF.Rep.list
awk '{ if ($10 > 0.35) print $0 }' Myan.core.SNP.hmmIBD_representative.hmm_fract.txt > Myan.core.SNP.hmmIBD_representative.hmm_fract_0.35.txt
