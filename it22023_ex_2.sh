#!/bin/bash

#prints Usage of the command
function help()
{
    echo "Usage: ./it22023_ex_2.sh [DIR] [SIZE]"
    exit 1
}

#Check that all the params are given correctly
if [ $# -ne 2 ]
    then help
fi

#All the files found with size bigger than the input given, for iteration
files="$(find $1 -type f -size +$2)"

#for every file
for i in $files
    do
        #print the file size
        du -sh $i
        #remove the file if yes given else do nothing
        rm -i $i
    done