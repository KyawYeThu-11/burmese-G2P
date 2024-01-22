#!/bin/bash
if [ "$#" -ne 1 ]; then
    echo "Usage: ./evaluate.sh [ver1|ver2]"
    echo "ver1: preprocessing ver1.txt"
    echo "ver2: preprocessing ver2.txt"
    exit 1
fi

if [ "$1" = 'ver1' ]; then
# preprearing training data
    cut -f 3,4 ./myg2p.ver1.txt | shuf > shuf
elif [ "$1" = 'ver2' ]; then
    cut -f 3,5 ./myg2p.ver2.0.txt | shuf > shuf
fi

head -n 19830 ./shuf > ./shuf.train

# perl ../scripts/insert-slash.pl ./shuf.train > ./myg2p.dictver1.train
perl ../scripts/insert-slash.pl ./shuf.train | tr ':' '_' > ./myg2p.dictver1.train # replacing ":" with "_"
python3 ../scripts/ch2col2.py ./myg2p.dictver1.train > ./myg2p.dictver1.train.col
cat myg2p.dictver1.train.col | python3 ../crfsuite/chunking.py > train

# preparing testing data
tail -n 4957 ./shuf > ./shuf.test
# perl ../scripts/insert-slash.pl ./shuf.test > ./myg2p.dictver1.test
perl ../scripts/insert-slash.pl ./shuf.test | tr ':' '_' > ./myg2p.dictver1.test # replacing ":" with "_"
python3 ../scripts/ch2col2.py ./myg2p.dictver1.test > ./myg2p.dictver1.test.col
cat myg2p.dictver1.test.col | python3 ../crfsuite/chunking.py > test

# removing temporary files
rm shuf shuf.train shuf.test myg2p.dictver1.train.col myg2p.dictver1.test.col