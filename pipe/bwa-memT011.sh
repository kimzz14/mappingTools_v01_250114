############################################################################################
threadN=$1
readDir=$2
readID=$3
############################################################################################

if [ -z ${threadN} ]; then
    echo "threadN is empty."
    exit 1
fi

if [ -z ${readDir} ]; then
    echo "readDir is empty."
    exit 1
fi

if [ -z ${readID} ]; then
    echo "readID is empty."
    exit 1
fi

#pair-end
bwa mem \
    -t ${threadN} \
    db/bwaDB/ref.fa \
    ${readDir}/${readID}-P_1.fastq.gz \
    ${readDir}/${readID}-P_2.fastq.gz \
    2>  result/${readID}.bwa-memT011-pe.bam.log \
    | samtools view -bS \
    -o  result/${readID}.bwa-memT011-pe.bam

bash pipe/samtools-flagstat.sh ${threadN} ${readID}.bwa-memT011-pe bam

#single-end 1
bwa mem \
    -t ${threadN} \
    reference/ref.fa \
    ${readDir}/${readID}-U_1.fastq.gz \
    2>  result/${readID}.bwa-memT011-se.1.bam.log \
    | samtools view -bS \
    -o  result/${readID}.bwa-memT011-se.1.bam
    
bash pipe/samtools-flagstat.sh ${threadN} ${readID}.bwa-memT011-se.1 bam

#single-end 2
bwa mem \
    -t ${threadN} \
    reference/ref.fa \
    ${readDir}/${readID}-U_2.fastq.gz \
    2>  result/${readID}.bwa-memT011-se.2.bam.log \
    | samtools view -bS \
    -o  result/${readID}.bwa-memT011-se.2.bam
    
bash pipe/samtools-flagstat.sh ${threadN} ${readID}.bwa-memT011-se.2 bam

#merge
samtools merge \
    -o  result/${readID}.bwa-memT011.bam \
        result/${readID}.bwa-memT011-pe.bam \
        result/${readID}.bwa-memT011-se.1.bam \
        result/${readID}.bwa-memT011-se.2.bam \
    1>  result/${readID}.bwa-memT011.bam.log \
    2>  result/${readID}.bwa-memT011.bam.err

bash pipe/samtools-flagstat.sh ${threadN} ${readID}.bwa-memT011 bam
