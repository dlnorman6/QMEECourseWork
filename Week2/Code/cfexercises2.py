#!/usr/bin/env python3

"""Some functions illustrating control flow"""

__appname__ = 'cfexercises2.py'
__author__ = 'Danielle Norman (daniellenorman6@gmail.com)'
__version__ = '0.0.1'

## Imports ##
import sys

def foo1(x):
    """Returns the square root of x"""
    s = x ** 0.5
    return "The square root of %d is %f" % (x,s)

def foo2(x,y): 
    """Returns the largest value in the pair"""
    if x > y:
        return "%f is larger than %f" % (x,y)
    return "%f is larger than %f" % (y,x)

def foo3(x, y, z):
    """Reorders such that the largest value appears at the end"""
    x1 = x; y1 = y; z1 = z
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return "The largest number in [%f,%f,%f] is %f" %(x1, y1, z1, z)

def foo4(x):
    """Returns x!"""
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return "%f! is %f" % (x,result)

def foo5(x):
    """Calculates x! recursively""" 
    if x == 1:
        return 1
    return x * foo5(x-1)

def foo6(x):
    """Calculates the factorial of x"""
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x-1
    return facto

def main(argv):
    print(foo1(16))
    print(foo2(2,3))
    print(foo2(3,2))
    print(foo3(8,9,7))
    print(foo3(9,8,7))
    print(foo4(5))
    print(foo5(5))
    print(foo6(5))
    return 0

if __name__ == "__main__":
    """Makes sure the "main" function is called from command line"""
    status = main(sys.argv)
    sys.exit(status)

