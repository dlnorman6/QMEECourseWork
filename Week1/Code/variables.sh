#!/bin/bash
# Author: Danielle Norman
# Date: Oct 2018
# Shows the use of variables

MyVar='some string'
echo 'the current value of the variable is' $MyVare
echo 'Please enter a new string'
read MyVar
echo 'the current value of the variable is' $MyVar
## Reading multiple values
echo 'Enter two numbers separated by space(s)'
read a b
echo 'you entered' $a 'and' $b '. Their sum is:'
mysum=`expr $a + $b`
echo $mysum
