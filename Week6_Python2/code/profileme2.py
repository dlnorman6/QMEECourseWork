## More efficient version of profileme.py

def my_squares(iters):
    out = [i ** 2 for i in range(iters)] # list comp 
    return out

def my_join(iters, string):
    out = ''
    for i in range(iters):
        out += "," + string # explicit string concatenation
    return out

def run_my_funcs(x,y):
    print(x,y)
    my_squares(x)
    my_join(x,y)
    return 0

run_my_funcs(10000000,"My string")

