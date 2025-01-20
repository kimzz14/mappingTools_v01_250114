############################################################################################
#Iso-Seq
threadN=$1
readDir=$2
readID=$3
preset=splice #map-pb, map-ont
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

#create head before
cat db/ref.fa.fai | awk 'BEGIN {FS="\t"; OFS="\t"} {print "@SQ\tSN:"$1"\tLN:"$2}' > result/${readID}.minimap2-T112.sam

minimap2 \
    -t ${threadN} \
    -ax splice \
    -u f \
    --secondary=no \
    -C 5 \
    db/ref.fa \
    ${readDir}/${readID}.fastq.gz \
    2>  result/${readID}.minimap2-T112.sam.log \
    >>  result/${readID}.minimap2-T112.sam

bash pipe/samtools-sort.sh ${threadN} ${readID}.minimap2-T112 sam

############################################################################################
#Preset:
#    -x STR       preset (always applied before other options) []
#                 - map-ont (ont-to-ref, uses default param)
#                 - map-pb (hifi-to-ref, all defaults but does finer read fragmentation in SV-aware mapping)
#                 - map-pb-clr (clr-to-ref, sets --sv-off)
#                 - splice/splice:hq - long-read/Pacbio-CCS spliced alignment, sets --sv-off
#                 - asm5/asm10/asm20 - asm-to-ref mapping
# or mapping using minimap2
# 
#-C INT	Cost for a non-canonical GT-AG splicing (effective with --splice) [0]
#
#--secondary=yes|no
# 	Whether to output secondary alignments [yes]
#
#-u CHAR	How to find canonical splicing sites GT-AG - f: transcript strand; b: both strands; n: no attempt to match GT-AG [n]
