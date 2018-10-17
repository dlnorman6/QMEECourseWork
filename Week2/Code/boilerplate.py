#!/usr/bin/env python3

""" Description: boilerplate for python"""

__appname__ = 'boilerplate'
__author__ = 'Danielle Norman (daniellenorman6@gmail.com)'
__version__ = '0.0.1'
__license__ = ''

## Imports ##
import sys # module to interface our program with the OS

## Constants ##


## Functions ##
def main(argv):
    """ Main entry point of the program """
    print('This is a boilerplate') # Note: indented
    return 0

if __name__ == "__main__":
    """Makes sure the "main" function is called from command line"""
    status = main(sys.argv)
    sys.exit(status)
    