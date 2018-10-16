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