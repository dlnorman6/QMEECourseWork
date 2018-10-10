#!/bin/bash
# Author: Danielle Norman
# Date: Oct 2018
# Description: concatenates files $1 and $2 into $3

cat $1 > $3
cat $2 >> $3
echo "Merged File is"
cat $3
