#!/bin/bash
# Author: Danielle
# Date: Oct 2018
# Desc: counts the number of lines in a file

NumLines=`wc -l < $1`
echo "The file $1 has $NumLines lines"
echo

exit