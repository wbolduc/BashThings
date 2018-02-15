#!/bin/bash
pwd
cp $1 test__copy.c
sed -E -i 's/int[ \t]+main[ \t]*\(/int studentMain\(/1' test__copy.c
gcc -Wall -std=c99 test__main.c -o test.out
./test.out
rm test.out test__copy.c
