#!/bin/bash
TESTFILES=../testCases

for Day in *day
do
	for Section in ${Day}/*
	do
		echo $Section
		rm -v ${Section}/*.c
		unzip "${Section}/*.zip" -d ${Section}

		for fileName in ${Section}/*.c
		do
			newName="${fileName/_/!}"
			newName="${newName// /_}"
			newName="${newName%%!*}".c
			mv -v "${fileName}" "${newName}"
		done
	done
done
