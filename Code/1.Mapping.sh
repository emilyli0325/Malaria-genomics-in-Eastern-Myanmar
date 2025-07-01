#!/bin/bash
export PATH=$PATH:/opt/gridengine/bin/lx-amd64
echo "mapping ${1}..."

/master/xli/software/bwa3/bwa-0.7.15/bwa mem /data/infectious/malaria_XUE/sWGA/Index/Pfal3D7_hg19.fa /master/xli/raw.data/sWGA.military.08242021/19047-35/${1}.R1.fastq.gz /master/xli/raw.data/sWGA.military.08242021/19047-35/${1}.R2.fastq.gz -t 12 -M -R "@RG\tID:${1}\tLB:${1}\tPL:ILLUMINA\tPM:HISEQ\tSM:${1}" > SAM/${1}.sam

/master/fcheval/local/bin/java -jar /master/xli/software/picard/picard.jar SortSam \
     INPUT=SAM/${1}.sam \
     OUTPUT=sorted.bam/${1}.sorted.bam \
     SORT_ORDER=coordinate

/master/fcheval/local/bin/java -jar /master/xli/software/picard/picard.jar MarkDuplicates \
     INPUT=sorted.bam/${1}.sorted.bam \
     OUTPUT=dedup.sorted.bam/${1}.dedup.sorted.bam \
     METRICS_FILE=metrics/${1}.metrics.txt

cd dedup.sorted.bam

/master/fcheval/local/bin/java -jar /master/xli/software/picard/picard.jar BuildBamIndex \
     INPUT=${1}.dedup.sorted.bam

cd ..

echo "BQSR ${1}..."	 
	/master/fcheval/local/bin/java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar\
		 -T BaseRecalibrator\
		 -R /data/infectious/malaria_XUE/sWGA/Index/Pfal3D7_hg19.fa\
		 -I dedup.sorted.bam/${1}.dedup.sorted.bam\
		 -knownSites /master/xli/Index/Known_sites/3d7_hb3.combined.final.karo.sort.vcf\
		 -knownSites /master/xli/Index/Known_sites/7g8_gb4.combined.final.karo.sort.vcf\
		 -knownSites /master/xli/Index/Known_sites/hb3_dd2.combined.final.karo.sort.vcf\
		 -o BQSR/${1}.recal.table
	/master/fcheval/local/bin/java -jar /master/xli/software/GATK/GenomeAnalysisTK.jar\
		 -T PrintReads\
		 -R /data/infectious/malaria_XUE/sWGA/Index/Pfal3D7_hg19.fa\
		 -I dedup.sorted.bam/${1}.dedup.sorted.bam\
		 -BQSR BQSR/${1}.recal.table\
		 -o recal.bam/${1}.recal.bam 

    /master/fcheval/local/bin/java -jar /master/xli/software/IGV/IGVTools/igvtools.jar count \
         recal.bam/${1}.recal.bam \
         TDF/${1}.tdf \
         /master/xli/igv/genomes/Pf3D7_v9.0.genome
		 
echo "Variant ploidy 2 calling ${1}..."
	/master/fcheval/local/bin/java -Xmx20g -jar /master/xli/software/GATK/GenomeAnalysisTK.jar\
         -T HaplotypeCaller\
         -R /data/infectious/malaria_XUE/sWGA/Index/Pfal3D7_hg19.fa\
		 -L /master/xli/Index/Known_sites/Genome.intervals\
         -I recal.bam/${1}.recal.bam\
         --emitRefConfidence BP_RESOLUTION\
         -o g.vcf.ploidy2/${1}.ploidy2.g.vcf\
         --useNewAFCalculator \
         --sample_ploidy 2 \
         --dontUseSoftClippedBases \
         --num_cpu_threads_per_data_thread 12
		 
echo "${1} Variant ploidy 2 calling done!"

done
