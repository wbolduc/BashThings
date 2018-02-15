#!/bin/bash
subDir=$1
for Submission in $subDir*.c;
do
	Compiled=${Submission%%.c}
	echo "--------------------${Compiled}--------------------"
	gcc -Wall -std=c99 "${Submission}" -o "${Compiled}".out
	echo "---------------------------------------------------"
	cat $Submission
	echo "////////////////////////${Compiled}////////////////////////////"
	./tester.sh $Submission
	echo "///////////////////////DONE TA TEST////////////////////////////"
	echo "++++++++++++++++++++${Compiled}++++++++++++++++++++"
	read -p "Next person..."
	rm ${Compiled}.out
	clear
done
