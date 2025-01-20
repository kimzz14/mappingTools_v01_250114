############################################################################################
threadN=$1
readID=$2
fileExt=$3
############################################################################################

if [ -z ${readID} ]; then
    echo "readID is empty."
    exit 1
fi

if [ -z ${threadN} ]; then
    echo "threadN is empty."
    exit 1
fi

if [ -z ${fileExt} ]; then
    echo "fileExt is empty."
    exit 1
fi

samtools sort \
    --threads ${threadN} \
    -o result/${readID}.sorted.bam \
       result/${readID}.${fileExt} \
    1> result/${readID}.sorted.bam.log \
    2> result/${readID}.sorted.bam.err

bash pipe/samtools-index.sh ${threadN} ${readID}.sorted
