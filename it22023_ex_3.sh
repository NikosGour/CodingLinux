#!/bin/bash

#Calculating the size of root and home by:
#       1) Getting the dir size from du 
#       2) Using awk to get only the size and not the file path
#       3) Doing a routine to remove the size type (G,M,K)
#       3.1) Reversing the number plus type (18G -> G81)
#       3.2) Cutting all the characters from the second character (G81 -> 81)
#       3.3) Reversing the string again to gain the number (81 -> 18) 
root_sz=$(du -sh / 2> /dev/null | awk '{print $1}' | rev | cut -c 2- | rev)
home_sz=$(du -sh $HOME 2> /dev/null | awk '{print $1}'| rev | cut -c 2- | rev)

#Calulating the percentage of home to root by:
#       1) Using bc to calculate "home_sz / root_sz * 100" (3.9 / 18 * 100 = 21.6666667)
#       2) Cutting all the characters from the dot
percentage_of_home=$(echo "$home_sz / $root_sz * 100" | bc -l | cut -c -2) 


echo "Root filesystem size: ${root_sz}G"
echo "Home directory size: ${home_sz}G"
echo "Home directory uses ${percentage_of_home}% of /"