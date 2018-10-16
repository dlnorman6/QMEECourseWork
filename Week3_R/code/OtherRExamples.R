### tapply and by allow you to apply a function to subsets of a vector in a dataframe with the subsets defined by some other vector in the dataframe, usually a factor

## tapply example
x <- 1:20 # numerical vector
y <- factor(rep(letters[1:5],each=4)) # aaaabbbbccccddddeeee
tapply(x,y,sum) # sum the values in x within each subgroup (factor level) defined by y

## by example
attach(iris)
by(iris[,1:2], iris$Species, colMeans) # run colMeans on multiple columns
by(iris[,1:2], iris$Petal.Width, colMeans)

### replicate function helps to avoid loops
replicate(10, runif(5)) # 10x5 matrix (10 cols of 5)

### Note: plyr builds on the built-in apply functions by giving you control over the input and output formats. The basic format is two letters followed by ply(). The first letter refers to the format in and the second to the format out, e.g. d = data frame, a = array, l = list