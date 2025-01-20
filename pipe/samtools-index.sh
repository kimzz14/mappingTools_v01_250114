############################################################################################
threadN=$1
readID=$2
############################################################################################

if [ -z ${readID} ]; then
    echo "readID is empty."
    exit 1
fi

if [ -z ${threadN} ]; then
    echo "threadN is empty."
    exit 1
fi

samtools index \
    --threads ${threadN} \
    -c  result/${readID}.bam \
    1>  result/${readID}.bam.csi.log \
    2>  result/${readID}.bam.csi.err
