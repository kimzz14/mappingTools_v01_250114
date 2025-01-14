############################################################################################
threadN=128
ofile=test.N09
############################################################################################

if [ -z ${threadN} ]; then
    echo "threadN is empty."
    exit 1
fi

samtools merge \
    -@ ${threadN} \
    -o result/${ofile}.bam \
    result/in1.sam \
    result/in2.sam \
    result/in3.sam \
    result/in4.sam \
1>  result/${ofile}.log \
2>  result/${ofile}.err
