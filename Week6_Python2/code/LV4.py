import scipy as sc
import scipy.integrate as integrate # "as integrate" defines name to be integrate
from scipy.stats import norm
import sys
import matplotlib.pylab as p 

def main(argv):
    r = sys.argv[1]
    a = sys.argv[2]
    z = sys.argv[3]
    e = sys.argv[4]

    ## Time vector
    t = sc.linspace(0,15,1000) # note time units are arbitrary

    ## Initial values
    K = 50
    R0 = 10
    C0 = 5
    RC0 = sc.array([[R0,C0]])
    eps = norm.rvs(size=len(t)-1)

    ## Initialise population densities storage
    pops = sc.concatenate((RC0,sc.zeros((len(t)-1,2))),axis=0)
    
    ## Propagate system forward from IC
    for i in range(len(t)):
        R = pops[i,0]
        C = pops[i,1]
        Rt1 = R*(1 + (r+eps[i])*(1-R/K) - a*C)
        Ct1 = C*(1- z + e*a*R)
        pops[i+1,:] = sc.array([[Rt1,Ct1]])

    ## Plotting
    f1 = p.figure()
    p.plot(t, pops[:,0], 'g-', label='Resource density') # Plot
    p.plot(t, pops[:,1]  , 'b-', label='Consumer density')
    p.grid()
    p.legend(loc='best')
    p.xlabel('Time')
    p.ylabel('Population density')
    p.title('Consumer-Resource population dynamics')
    p.text(8,10,'r='+str(r)+', a='+str(a)+', z='+str(z)+', e='+str(e))
    p.show()# To display the figure
          
    print("Final resource density: ", pops[-1,0])
    print("Final consumer density: ", pops[-1,1])

if (__name__ == "__main__"):
    status = main(sys.argv)  


