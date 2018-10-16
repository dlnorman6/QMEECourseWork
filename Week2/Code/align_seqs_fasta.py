#!/usr/bin/env python3

"""Aligns two sequences of DNA saved in separate files. Default files are fasta files saved in the data directory. The best alignment and corresponding number of base matches (score) is outputted to file."""

__appname__ = 'align_seqs_fasta.py'
__author__ = 'Danielle Norman (daniellenorman6@gmail.com)'
__version__ = '0.0.1'

import csv
import sys
import pdb
import doctest

def calculate_score(s1, s2, l1, l2, startpoint):
    """Calculates the number of base matches, i.e. score, in two DNA sequences for each possible starting position"""    
    # startpoint is the point at which we want to start
    matched = "" # contains string for alignment
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            # if its matching the character
            if s1[i + startpoint] == s2[i]:
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    return score

def main(argv): 
    if len(sys.argv) > 1: # if files specified, open
        f1 = open(sys.argv[1],'r')
        f2 = open(sys.argv[2],'r')
    else: # else use default files
        f1 = open('../../Week1/Data/407228326.fasta','r')
        f2 = open('../../Week1/Data/407228412.fasta','r')
    
    g = open('../results/FastaAligned.csv','w') # output file
    csvwrite = csv.writer(g)

    ## Extract sequences from files
    seq1 = ''
    for row in f1:
        if row.startswith('>'):
            continue
        seq1 = seq1 + row
    seq1 = seq1.replace("\n","")

    seq2 = ''
    for row in f2:
        if row.startswith('>'):
            continue
        seq2 = seq2 + row
    seq2 = seq2.replace("\n","")
 
    # assign the longest sequence s1, with length l1 and the shortest to s2, with length l2
    l1 = len(seq1)
    l2 = len(seq2)
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1 

    # now try to find the best match (highest score)
    my_best_align = None
    my_best_score = -1

    for i in range(l1):
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2
            my_best_score = z

    csvwrite.writerow([my_best_align])
    csvwrite.writerow([s1])
    csvwrite.writerow(["Best score:", my_best_score])
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)    
