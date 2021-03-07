#!/bin/bash

# 1. SATCOMP 2020 Main benchmarks
if true; then
echo "=============================GENERATING SATCOMP2020============================"
mkdir -p sc2020
cd sc2020

uri_file="../sc2020-main.uri"

cat $uri_file | while read URL
do
	FILE=${URL##*/}
	CNF_FILE=${FILE::-3}
	if [ ! -f "$CNF_FILE" ]; then
		wget -q --show-progress $URL
		unxz $FILE
	fi
done

cd ..
fi

# 2. Crypto benchmarks 
if false; then
echo "=============================GENERATING CRYPTO==============================="
./make_encoder.sh

mkdir -p crypto
cd crypto

ROUNDS=20
NUM_INSTANCES=50
CTR=1

while [ $CTR -le $NUM_INSTANCES ]
do
	./../crypto-encoding --function sha1 --rounds $ROUNDS --target random > "sha256-$ROUNDS-preimage$CTR.cnf" 2>/dev/null
	echo "Instance $CTR done"
	CTR=$((CTR+1))
done

cd ..

fi

# 3. Hard combinatorial benchmarks
if false; then
echo "===========================GENERATING COMBINATORIAL============================="

wget -q --show-progress "https://baldur.iti.kit.edu/sat-competition-2016/downloads/crafted16.zip"
unzip "crafted16.zip"

# rm "crafted16.zip"

fi
