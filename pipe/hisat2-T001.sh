############################################################################################
threadN=$1
readDir=$2
readID=$3
############################################################################################

hisat2 \
    --summary-file \
    --dta \
    -x db/hisat2DB/ref \
    -1 ${readDir}/${readID}_1.fastq.gz \
    -2 ${readDir}/${readID}_2.fastq.gz \
    2>  result/${readID}.hisat2-T001.bam.log \
    | samtools view -bS \
    -o  result/${readID}.hisat2-T001.bam

bash pipe/samtools-flagstat.sh ${threadN} ${readID}.hisat2-T001 bam

#GeneMark-ETP utilizes Stringtie2 to assemble RNA-Seq data, which requires that the aligned reads (BAM files) contain the XS (strand) tag for spliced reads.
#Therefore, if you align your reads with HISAT2, you must enable the --dta option, or 
#if you use STAR, you must use the --outSAMstrandField intronMotif option. TopHat alignments include this tag by default.
