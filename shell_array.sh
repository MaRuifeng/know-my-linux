#!/bin/bash -e

##########################################################################################
# A few simple tests on shell array and string for basic understanding. 
#
# Author:
#  Ruifeng Ma <ruifengm@sg.ibm.com>
# Date:
#  2018-Jun-01
##########################################################################################


declare -a arr=('one' 'two' 'three four')
str='one two three four'

echo -e ">>> Quoted string not broken into words by the for loop."
for s in "${str}"
do
	echo "${s}"
done

echo -e ">>> Unquoted string broken into words by the for loop."
for s in ${str} 
do
	echo "${s}"
done

echo -e ">>> Each element of array as a quoted string"
for a in "${arr[@]}"
do
	echo "${a}"
done

echo -e ">>> Each element of array as an unquoted string"
for a in ${arr[@]}
do
	echo "${a}"
done

echo -e "End of script."
