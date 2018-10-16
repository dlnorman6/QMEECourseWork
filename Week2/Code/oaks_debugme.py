#!/usr/bin/env python3

"""Identifies oaks from a dataset and saves to output file"""

__appname__ = 'oaks_debugme.py'
__author__ = 'Danielle Norman (daniellenorman6@gmail.com)'
__version__ = '0.0.1'

import csv
import sys
import pdb
import doctest

#Define function
def is_an_oak(name):
    """ Returns True if name starts with 'quercus' 
    
    >>> is_an_oak('Fagus sylvatica')
    False

    >>> is_an_oak('Quercus test')
    True

    >>> is_an_oak('Quercuss test')
    False
    """
    return name.lower().split(" ")[0] == 'quercus'

def main(argv): 
    f = open('../data/TestOaksData.csv','r')
    g = open('../results/JustOaksData.csv','w') # output file
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
    for row in taxa:
        if row[0] == 'Genus': # write header to output file
            csvwrite.writerow([row[0], row[1]])
        else:
            print(row)
            print("The genus is: ") 
            print(row[0])
            if is_an_oak(row[0]): # write oaks to output file
                print('FOUND AN OAK!')
                csvwrite.writerow([row[0], row[1]])
            print("") 

    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)