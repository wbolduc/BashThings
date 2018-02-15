#!/bin/bash
TESTFILES=../testCases
for f in *.c; do mv "$f" "${f// /_}"; done
for f in *.c; do mv "$f%" "${f/_[0-9]_assignsubmission_file_/}"; done
      
    

clear

for f in *_;
do
	echo $f
	echo "---------------------------------------------------------------"
	cd $f
	gcc *.c -Wall -std=c99
	ls
	echo "---------------------------------------------------------------"
	cat program7.c

	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	for tst in "$TESTFILES"/*.txt
	do
		echo $tst
		./a.out < "$TESTFILES"/"$tst"
	done
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"



	echo $f
	read -p "Next person..."
	cd ..
	clear
done
