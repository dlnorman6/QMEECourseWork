# Runs the stochastic (with gaussian fluctuations) Ricker Eqn. Second section contains a vectorised version. Time taken is outputted for both

rm(list=ls())

stochrick<-function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)
{
  #initialize
  N<-matrix(NA,numyears,length(p0))
  N[1,]<-p0
  
  for (pop in 1:length(p0)) #loop through the populations
  {
    for (yr in 2:numyears) #for each pop, loop through the years
    {
      N[yr,pop]<-N[yr-1,pop]*exp(r*(1-N[yr-1,pop]/K)+rnorm(1,0,sigma))
    }
  }
 return(N)

}

# plot(stochrick(p0=1), type="l") # plot for a single population
print("Stochastic Ricker takes:")
print(system.time(res2<-stochrick()))

######## Vectorised version #########

stochrickvect<-function(p0=runif(1000,.5,1.5),r=1.2,K=1,sigma=0.2,numyears=100)
{
  #initialize
  N<-matrix(NA,numyears,length(p0))
  N[1,]<-p0
  z <- matrix(rnorm(length(p0)*(numyears-1),0,sigma),numyears-1,length(p0)) # random numbers to be added at each iteration 
  
  for (yr in 2:numyears) # loop through the years
  {
    N[yr,]<-N[yr-1,]*exp(r*(1-N[yr-1,]/K)+z[yr-1,])
  }
}

print("Vectorized Stochastic Ricker takes:")
print(system.time(res2<-stochrickvect()))

