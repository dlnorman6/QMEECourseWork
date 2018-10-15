#!/usr/bin/env python3

import csv
import sys
import pdb
import doctest

# function that computes a score
# by returning the number of matches 
# starting from arbitrary startpoint
def calculate_score(s1, s2, l1, l2, startpoint):
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
    # print("." * startpoint + matched)           
    # print("." * startpoint + s2)
    # print(s1)
    # print(score)
    # print("")

    return score

def main(argv): 
    if len(sys.argv) > 1:
        f1 = open(sys.argv[1],'r')
        f2 = open(sys.argv[2],'r')
    else:
        f1 = open('../../Week1/Data/407228326.fasta','r')
        f2 = open('../../Week1/Data/407228412.fasta','r')
    
    g = open('../Results/FastaAligned.csv','w')
    csvwrite = csv.writer(g)

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
 
    # These are the two sequences to match
    # seq = []
    # for row in data:
    #     seq.append(row)
    # seq2 = seq[0][0]
    # seq1 = seq[1][0]

    # assign the longest sequence s1, and the shortest to s2
    # l1 is the length of the longest, l2 that of the shortest

    l1 = len(seq1)
    l2 = len(seq2)
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1 # swap the two lengths

    # now try to find the best match (highest score)
    my_best_align = None
    my_best_score = -1

    for i in range(l1):
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2
            my_best_score = z

    csvwrite.writerow(my_best_align)
    csvwrite.writerow(s1)
    csvwrite.writerow(["Best score:", my_best_score])
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)    
