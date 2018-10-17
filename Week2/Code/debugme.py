#!/usr/bin/env python3

"""Illustrative function with a bug to practice debugging"""
def createabug(x):
    y = x**4
    z = 0.
    y = y/z
    return y

createabug(25)