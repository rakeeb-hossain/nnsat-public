#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Not enough arguments"
	exit 1
fi

path=$(pwd)

if [ $1 = "glucose" ]; then
	path="$path/src/glucose4.2.1/sources/simp"
fi

exec="$path/$1"

# 1. SATCOMP benchmark
if false; then
echo "=============================SC2020 Benchmark=================================="
rm temp.txt

for cnf_file in benchmarks/sc2020/*.cnf; do
	echo "Running $cnf_file..."
	$exec < $cnf_file 2> /dev/null | tail -3 | head -1 | awk '{print $5}' >> temp.txt
	tail -1 < temp.txt
done

echo "SC2020 result:"
awk '{s += $1} END {print s}' temp.txt

fi

# 2. Crypto benchmark
if true; then
echo "=============================Crypto Benchmark=================================="

rm temp.txt

for cnf_file in benchmarks/crypto/*.cnf; do
	echo "Running $cnf_file..."
	$exec < $cnf_file | tail -3 | head -1 | awk '{print $5}' >> temp.txt 
	tail -1 < temp.txt
done

echo "Crypto result:"
awk '{s += $1} END {print s}' temp.txt

fi
