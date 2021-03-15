#!/bin/bash

if [ $# -lt 3 ]; then
	echo "Not enough arguments"
	exit 1
fi

path=$(pwd)

if [ $1 = "glucose" ]; then
	path="$path/src/glucose4.2.1/sources/simp"
fi

exec="$path/$1"
temp_file=$(mktemp)

# 1. SATCOMP benchmark
if false; then
echo "=============================SC2020 Benchmark=================================="

echo "$1 $2 $3" > $temp_file

for cnf_file in benchmarks/sc2020/*.cnf; do
	echo "Running $cnf_file..."
	$exec $2 $3 < $cnf_file 2> /dev/null | tail -3 | head -1 | awk '{print $5}' >> $temp_file
	tail -1 < $temp_file
done

echo "SC2020 result:"
awk '{s += $1} END {print s}' $temp_file

rm $temp_file

fi

# 2. Crypto benchmark
if true; then
echo "=============================Crypto Benchmark=================================="

echo "$1 $2 $3" > $temp_file

for cnf_file in benchmarks/crypto/*.cnf; do
	echo "Running $cnf_file..."
	$exec $2 $3  < $cnf_file | tail -3 | head -1 | awk '{print $5}' >> $temp_file
	tail -1 < $temp_file
done

echo "Crypto result:"
awk '{s += $1} END {print s}' $temp_file

rm $temp_file

fi
