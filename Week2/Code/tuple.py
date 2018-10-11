#!/usr/bin/env python3

"""Prints the tuples given in a list of tuples on separate lines."""

__appname__ = 'tuple.py'
__author__ = 'Danielle Norman (daniellenorman6@gmail.com)'
__version__ = '0.0.1'

## Data
birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

# Birds is a tuple of tuples of length three: latin name, common name, mass.
# write a (short) script to print these on a separate line or output block by species 
# Hints: use the "print" command! You can use list comprehension!

# ANNOTATE WHAT EVERY BLOCK OR IF NECESSARY, LINE IS DOING! 

for row in birds:
    print(row)
    print("")