#!/usr/bin/env python3

""" Computes the best match or matches if multiple have positions have the same score and prints all matches to output file "../Results/BetterAligned.csv:" """

import csv
import sys
import pdb
import doctest
import pickle

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
    
    g = open('../Results/BetterAligned.csv','w')
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

    f = open('../Sandbox/seqsp.p','wb')
    for i in range(l1):
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            f = open('../Sandbox/seqsp.p','wb')
            my_best_align = "." * i + s2
            my_best_score = z
            pickle.dump([my_best_score,my_best_align],f)
        elif z == my_best_score:
            my_best_align = "." * i + s2
            pickle.dump(my_best_align,f)
    f.close()
    f = open('../Sandbox/seqsp.p','rb')
    best_aligns = pickle.load(f)
    f.close() 
    print(best_aligns)   
    csvwrite.writerow(["Best score:", my_best_score])
    csvwrite.writerow(best_aligns)
    csvwrite.writerow(s1)

    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)    
