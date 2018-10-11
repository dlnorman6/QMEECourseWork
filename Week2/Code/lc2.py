#!/usr/bin/env python3

"""Creates a list of [month,rainfall] tuples in which rainfall was greater than 100mm according to 1910 rainfall data from the metoffice, and a separate list of months in which rainfall was less than 50mm. The same lists are created using list comprehension and conventional loops."""

__appname__ = 'lc2.py'
__author__ = 'Danielle Norman (daniellenorman6@gmail.com)'
__version__ = '0.0.1'

## Data
# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.
 
# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

## Script

## (1) create list of [month, rainfall] tuples where rainfall > 100mm using list comprehension

rain100plus_lc = [row for row in rainfall if row[1] > 100]
print(rain100plus_lc)

## (2) create list of months in which rainfall < 50mm using list comprehension

rain50less_lc = [row[0] for row in rainfall if row[1] < 50]
print(rain50less_lc)

## (3) repeat (1) and (2) above using conventional loops

rain100plus = [] # initialise list for records of rain >100mm
for row in rainfall: # cycle through rainfall data
    if row[1] > 100: 
        rain100plus.append(row) # append month and rainfall entry to list
print(rain100plus)

rain50less = [] # initialise list for records of rain <50mm
for row in rainfall: # cycle through rainfall data
    if row[1] < 50:
        rain50less.append(row[0]) # append month only to list
print(rain50less)


