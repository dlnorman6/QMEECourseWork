#!/bin/bash
# Author: Danielle
# Script: csvtospace.sh
# Desc: substitute the commas in the file with spaces
# saves the output into a .txt file
# Arguments: 1 -> comma separated file
# Date: Oct 2018

echo "Creating a space separated values file from the csv file $1 ..."
filename="$(basename "$1" .csv)" # removes path and extension
path=$(dirname "${1}") # extracts file path
path+="/" # add forward slash to separate directory and filename
newfile="$path$filename"
cat $1 | tr -s "," " " >> $newfile.txt
echo "Done!"
exit