import scipy as sc
import scipy.integrate as integrate # "as integrate" defines name to be integrate
import sys
import matplotlib.pylab as p

def dCR_dt(pops,t=0,r=1.,a=0.1,z=1.5,e=0.75,K=50):
    R = pops[0]
    C = pops[1]
    dRdt = r*R*(1-R/K) - a*R*C
    dCdt = -z*C + e*a*R*C

    return sc.array([dRdt, dCdt])

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
    RC0 = sc.array([R0,C0])

    ## Numerically integrate system forward from IC
    pops, infodict = integrate.odeint(dCR_dt, RC0, t, full_output=True)

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
    # p.show()# To display the figure
    ## Save figure
    f1.savefig('../results/LV2_model.pdf') #Save figure
    
    print("Final resource density: ", pops[-1,0])
    print("Final consumer density: ", pops[-1,1])

if (__name__ == "__main__"):
    status = main(sys.argv)  


