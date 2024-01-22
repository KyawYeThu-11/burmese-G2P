#!/bin/bash
# preparing ground truth testing data
perl ../scripts/extract.pl ./myg2p.dictver1.test w > myg2p.dictver1.test.word
perl ../scripts/extract.pl ./myg2p.dictver1.test t > myg2p.dictver1.test.tag
perl ../scripts/mk-pair.pl ./myg2p.dictver1.test.word ./myg2p.dictver1.test.tag > ./test.groundtruth

if [ "$#" -ne 2 ]; then
    echo "Usage: ./evaluate.sh [e|p] [model]"
    echo "e: evaluate the model"
    echo "p: predict using the model"
    echo "model: the model to be used"
    exit 1
fi

if [ "$1" = '-e' ]; then
    # preprocessing predicted result to compare against ground truth
    # crfsuite tag -m ./g2p.model2 ./test | tee ./test1.out
    crfsuite tag -m "$2" ./test > ./test.out
    perl ../scripts/ch2line.pl ./test.out > ./test.out.line
    perl ../scripts/mk-pair.pl ./myg2p.dictver1.test.word ./test.out.line > ./test.out.line.wordtag

    # evaluating
    perl ../scripts/gradepos.pl ./test.groundtruth ./test.out.line.wordtag

    # removing temporary files
    rm ./myg2p.dictver1.test.word ./myg2p.dictver1.test.tag ./test.out ./test.out.line 

elif [ "$1" = '-p' ]; then
    perl ../scripts/extract.pl ./myg2p.dictver1.test p > myg2p.dictver1.test.placeholder
    python3 ../scripts/ch2col2.py ./myg2p.dictver1.test.placeholder > ./myg2p.dictver1.test.col
    cat myg2p.dictver1.test.col | python3 ../crfsuite/chunking.py > predict

    # preprocessing predicted result to compare against ground truth
    echo "Making predictions..."
    crfsuite tag -m "$2" ./predict > ./predict.out
    perl ../scripts/ch2line.pl ./predict.out > ./predict.out.line
    perl ../scripts/mk-pair.pl ./myg2p.dictver1.test.word ./predict.out.line > ./predict.out.line.wordtag

    #removing temporary files
    rm ./myg2p.dictver1.test.word ./myg2p.dictver1.test.placeholder ./myg2p.dictver1.test.col ./predict ./predict.out ./predict.out.line
fi