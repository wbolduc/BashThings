#!/bin/bash

testDir="tests/"
#tests in this directory are in the form of Q[1..]
#test cases are .txt files piped into the student code, the .scheme is the file holding the grading Scheme
#ls tests/Q1/
#q1Grading.scheme  t1.txt  t2.txt  t3.txt


#Don't overwrite the previous mark markBook
i=0
while [ -e "markBook${i}.txt" ]
do
	i=$((i + 1))
done
markBook="markBook${i}.txt"
touch $markBook


echoPrint () {
	echo $1
	echo $1 >> $markBook
}

for StudentFolder in *__*
do
	echoPrint "=========================== $StudentFolder ==========================="
	#Check question names
	ls ${StudentFolder}
	for i in {1..5}
	do
		echoPrint "----------       Question ${i}       ----------"
		#get question Name
		Questions[i]=`echo ${StudentFolder//_/}A2Q${i}.c | sed -e 's/^./\L&\E/'`

		#check question Name and update
		if [ -e "${StudentFolder}/${Questions[i]}" ]
		then
			echoPrint "naming Scheme = 1"
		else
			upperCaseVersion=`echo ${Questions[i]} | sed 's/.*/\u&/'`
		if [ -e "${StudentFolder}/${upperCaseVersion}" ]
		then
			echoPrint "naming Scheme = .5"
			Questions[i]=${upperCaseVersion}
		else
			echoPrint "naming Scheme = 0"
		fi
		fi

		#try to compile
		gcc -Wall -std=c99 "${StudentFolder}/${Questions[i]}" -o "${StudentFolder}/q${i}" &>> $markBook
		if [ $? -ne 0 ]
		then
    		echoPrint "Compilation = 0"
    	else
			gcc -Wall -Werror -std=c99 "${StudentFolder}/${Questions[i]}" -o "${StudentFolder}/q${i}" &> /dev/null
			if [ $? -ne 0 ]
			then
    			echoPrint "Compilation = Warnings"
    		else
    			echoPrint "Compilation = 1"
			fi

			#print code
			echo "////////////////////////////////////////////////////////////////////////////"
			cat ${StudentFolder}/${Questions[i]}
			echo "////////////////////////////////////////////////////////////////////////////"
			#do test cases
			for testCase in ${testDir}Q${i}/*.txt
			do
				echo $testCase
				./${StudentFolder}/q${i} < "$testCase"
				echo
			done

			#do questions
			QuestionGrade=0
			while read -u 3 criteria
			do
				#display a grading criteria
				echo "$criteria"

				#get grade and criteria
				echo -n "Grade: "
				read grade
				echo -n "Comment: "
				read comment

				#store the grade, criteria and comment
				echo "${grade}/${criteria}" >> $markBook
				echo "Comment: ${comment}" >> $markBook

				#add up Grade
				QuestionGrade=`python -c "print ${QuestionGrade} + ${grade}"`	#yikes
			done 3< ${testDir}Q${i}/*.scheme
			#print total grade for the questions
			echoPrint "Question grade: ${QuestionGrade}"
			#final Comment
			echo -n "Final Comments: "
			read comment
			echo "Final Comment: ${comment}" > $markBook

			clear
		fi

		echoPrint ""
	done
	echoPrint ""
	echoPrint ""
done
cat $markBook
