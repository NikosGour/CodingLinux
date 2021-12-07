#!/bin/bash

#Change Directory into /home/user
cd ~

#Variable file because it is used in multiple places
file=".hd_size"

#create the file
touch $file

#append the date into the file
date >> $file

#append the size of the home/user into the file
#use flags -h to make the command display the size in KB/MB/GB.
#          -s to only show the home/user dir instead of every nested dir/file
du -hs ~ >> $file

#put separation line
echo "************" >> $file
