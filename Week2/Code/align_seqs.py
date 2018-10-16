#!/usr/bin/env python3

"""Aligns two DNA sequences stored in a single data file such that they are as similar as possible and outputs the best alignment along with its score (number of base matches) to file '../results/BestAlign.csv' """ 

__appname__ = 'align_seqs.py'
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

    # build some formatted output
    print("." * startpoint + matched)           
    print("." * startpoint + s2)
    print(s1)
    print(score)
    print("")

    return score

def main(argv): 
    f = open('../data/SeqsToAlign.csv','r')
    g = open('../results/BestAlign.csv','w')
    data = csv.reader(f)
    csvwrite = csv.writer(g)

    # These are the two sequences to match
    seq = []
    for row in data:
        seq.append(row)
    seq2 = seq[0][0]
    seq1 = seq[1][0]

    print(seq1)

    # assign the longest sequence s1, with length l1, and the shortest to s2, with length l2

    l1 = len(seq1)
    l2 = len(seq2)
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1 # swap the two lengths


    # calculate_score(s1, s2, l1, l2, 0)
    # calculate_score(s1, s2, l1, l2, 1)
    # calculate_score(s1, s2, l1, l2, 5)

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
