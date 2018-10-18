## Calculates the correlation coefficient for a temperature time series, and associated p-value

load("../data/KeyWestAnnualMeanTemperature.RData")
print(dim(ats)) # two columns of length 100
head(ats) # first column: year, second column: temp
plot(ats) # plots annual mean temperature against year

## Extract data info
numyrs <- dim(ats)[1] # number of data points
tmp <- ats[,2] # temperature record

## Calculate correlation coefficient
cc <- cor(tmp[2:numyrs],tmp[1:(numyrs-1)])
print(cc)

## Repeat cc calculation on 10,000 permutations of the data
nos <- 10000 # number of permutations
cmat <- rep(NA,nos)
for (i in 1:nos){
    s = sample(tmp)
    cmat[i] <- cor(s[2:numyrs], s[1:(numyrs-1)])
}
pv = sum(cmat>cc)/nos # calculate p-value
print(pv)