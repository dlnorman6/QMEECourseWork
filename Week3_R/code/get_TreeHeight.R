# This function calculates heights of trees given ddistance of each tree from its base and angle to its top, using the trigonometic formula

# height = distance * tan(radians)

# ARGUMENTS
# degrees: the angle of elevation of the tree
# distance: the distance from base of tree (e.g. metres)

# OUTPUT
# THe heights of the trees, same units as distance

a <- commandArgs(trailingOnly=TRUE)
trees <- read.csv(a, header=TRUE)

distance <- trees[2]
degrees <- trees[3]

radians <- degrees * pi / 180
height <- distance * tan(radians)

trees <- cbind(trees,height)
colnames(trees)[4] <- "Tree.Height.m"

file = basename(a)
title = paste("../results/InputFileName_", file)
write.csv(trees, title)


