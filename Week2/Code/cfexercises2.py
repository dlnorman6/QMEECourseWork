#!/usr/bin/env python3

def foo1(x): # returns the square root of x
    return x ** 0.5

def foo2(x,y):  # returns the largest value in the pair
    if x > y:
        return x
    return y

def foo3(x, y, z): # moves largest value to the end
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]

def foo4(x): # factorial
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo5(x): # a recursive function: factorial
    if x == 1:
        return 1
    return x * foo5(x-1)

foo5(10)
