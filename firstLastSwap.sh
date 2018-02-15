#!/bin/bash
for FileName in *_
do
	#remove suffix
	Name=${FileName:0:-30}
	echo $Name

	#create Name array (all space delimited strings)
	Name=($(echo ${Name} | grep -o -P "[^_]*"))

	#assumes first name is only 1 name
	First=${Name[0]}
	#assumes last name is made of all subsequent names
	Last=${Name[@]:1}

	#swap spaces
	LastFirst="${Last}__${First}"
	#remove spaces
	LastFirst=${LastFirst// /_}

	#renameFile
	mv "${FileName}" "${LastFirst}"
done
