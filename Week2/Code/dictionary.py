#!/usr/bin/env python3

"""Creates a dictionary from a list of tuples of form [taxa, order] such that sets of taxa are matched to each order"""

__appname__ = 'dictionary.py'
__author__ = 'Danielle Norman (daniellenorman6@gmail.com)'
__version__ = '0.0.1'

## Data

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic 
# derived from  taxa so that it maps order names to sets of taxa. 
# E.g. 'Chiroptera' : set(['Myotis lucifugus']) etc. 

# ANNOTATE WHAT EVERY BLOCK OR IF NECESSARY, LINE IS DOING! 

# ALSO, PLEASE INCLUDE A DOCSTRING AT THE BEGINNING OF THIS FILE THAT 
# SAYS WHAT THE SCRIPT DOES AND WHO THE AUTHOR IS

# Write your script here:

## Script
orders = set() # initialise list of orders
for row in taxa: # extract orders from tuples
    orders.add(row[1])
order = list(orders) # change to list so that it can be indexed in next loop

taxa_dic = {} # initialise dictionary
for o in order: # loop through orders
    tmp = set()
    for row in taxa: # loop through taxas
        if row[1] == o: # if species belongs to order
            tmp.add(row[0])
    taxa_dic[o] = tmp # add order and set of taxas to dictionary

print(taxa_dic)