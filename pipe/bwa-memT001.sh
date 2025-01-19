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

bwa mem \
    -t ${threadN} \
    db/bwaDB/ref.fa \
    ${readDir}/${readID}_1.fastq.gz \
    ${readDir}/${readID}_2.fastq.gz \
    2>  result/${readID}.bwa-memT001.bam.log \
    | samtools view -bS \
    -o  result/${readID}.bwa-memT001.bam

bash pipe/samtools-flagstat.sh ${threadN} ${readID}.bwa-memT001 bam
