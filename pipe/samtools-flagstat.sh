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

samtools flagstat \
    --threads ${threadN} \
       result/${readID}.${fileExt} \
    1> result/${readID}.${fileExt}.flagstat \
    2> result/${readID}.${fileExt}.flagstat.log
