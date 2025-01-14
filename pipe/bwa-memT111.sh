############################################################################################
threadN=$1
readDir=$2
readID=$3
############################################################################################

if [ -z ${readID} ]; then
    echo "readID is empty."
    exit 1
fi

if [ -z ${threadN} ]; then
    echo "threadN is empty."
    exit 1
fi

bwa mem \
    -t ${threadN} \
    -x ont2d \
    db/bwaDB/ref.fa \
    ${readDir}/${readID}.fastq.gz \
    2>  result/${readID}.bwa-memT111.bam.log \
    | samtools view -bS \
    -o  result/${readID}.bwa-memT111.bam

bash pipe/samtools-flagstat.sh ${threadN} ${readID}.bwa-memT111 bam
