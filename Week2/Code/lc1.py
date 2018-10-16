#!/usr/bin/env python3

"""Creates three separate sets containing the latin name, common name, and body mass, respectively, for bird data given in the form of tuples [latin name, common name, body mass]. In part 1, the sets are formed via list comprehensions, and in part 2, through the use of for loops."""

__appname__ = 'lc1.py'
__author__ = 'Danielle Norman (daniellenorman6@gmail.com)'
__version__ = '0.0.1'

## Data
birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

##### Script
## (1): using list comprehensions

birds_latin_lc = set([row[0] for row in birds]) # extract latin names
print(birds_latin_lc)

birds_common_lc = set([row[1] for row in birds]) # extract common names
print(birds_common_lc)

birds_mass_lc = set([row[2] for row in birds]) # extract body masses
print(birds_mass_lc)

## (2): using conventional for loops

birds_latin = set() # initialise set for latin names
for row in birds: # loop over data set
    birds_latin.add(row[0]) # extract latin names
print(birds_latin)

birds_common = set() # initialise set for common names
for row in birds: # loop over data set
    birds_common.add(row[1]) # extract common names
print(birds_common)

birds_mass = set() # initialise set for body masses
for row in birds: # loop over data set
    birds_mass.add(row[2]) # extract body mass
print(birds_mass)