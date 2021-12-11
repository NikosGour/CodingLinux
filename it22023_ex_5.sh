#!/bin/bash

#Function used to map Months to a number for printing format 
function month_abv_to_num()
{
    if [ $# -ne 1 ]
        then
        echo bug
        exit -1
    fi

    case $1 in
        Jan) return 1;;
        Feb) return 2;;
        Mar) return 3;;
        Apr) return 4;;
        May) return 5;;
        Jun) return 6;;
        Jul) return 7;;
        Aug) return 8;;
        Sep) return 9;;
        Oct) return 10;;
        Nov) return 11;;
        Dec) return 12;;
        *) exit -1
    esac
}

#Given a line from command last prints the date in format = YYYY-MM-DD
function echo_date()
{
    if [ $# -ne 1 ]
        then
        echo bug
        exit -1
    fi

    #pass the line to awk and print the correct col
    echo "$(awk '{print $8}'<<<$1)-$(month_abv_to_num $(awk '{print $5}'<<<$1))$?-$(awk '{print $6}'<<<$1)"
}

#Get all the loggins by:
#   1) Calling last with -F to also get the year
#   2) Using awk discard every line that is a reboot instead of a user
#   3) Cut the last line with head because it is always this "wtmp begins Wed Oct 20 16:54:29 2021"
loggins=$(last -F| awk '{if ($1 != "reboot") print $0}' | head -n -1)

#set previous to the first line and print the date
prev=$(head -1 <<<$loggins)
echo_date "$prev"

#Use while read so we can iterate line by line
while read loggin
do
    if  [ "$(awk '{print $5,$6,$8}'<<<$loggin)" == "$(awk '{print $5,$6,$8}'<<<$prev)" ]
    #if month day and year are the same for the current line and the previous add a star
        then
            echo -n "*" 
    #else add the new date and add a star , also update previous
        else
            echo
            echo_date "$loggin"
            echo -n "*"
            prev=$loggin 
    fi

done <<<$loggins
echo