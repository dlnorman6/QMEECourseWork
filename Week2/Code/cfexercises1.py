#!/usr/bin/env python3

"""Control flow examples: for and while loops"""

# Desc: number of hello's printed
for i in range(3,17): #14
    print('hello')

for j in range(12): #4
    if j % 3 == 0:
        print('hello')

for j in range(15): #5
    if j % 5 == 3:
        print('hello')
    elif j % 4 == 3:
        print('hello')

z = 0
while z != 15: #5
    print('hello')
    z = z + 3

z = 12
while z < 100: #8
    if z == 31:
        for k in range(7):
            print('hello')
    elif z == 18:
        print('hello')
    z = z + 1
