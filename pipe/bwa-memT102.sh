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
    -a \
    -t ${threadN} \
    -x pacbio \
    db/bwaDB/ref.fa \
    ${readDir}/${readID}.fastq.gz \
    2>  result/${readID}.bwa-memT102.bam.log \
    | samtools view -bS \
    -o  result/${readID}.bwa-memT102.bam

bash pipe/samtools-flagstat.sh ${threadN} ${readID}.bwa-memT102 bam
