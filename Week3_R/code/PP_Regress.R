MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")

pdf("../results/PP_Regress_Figure.csv")
../results/PP_Regress_Results.csv

# perform linear regression
my_lm <- summary(lm(log(Predator.mass)~log(Prey.mass)),data =MyDF)
require(ggplot2)
qplot(log(Prey.mass),log(Predator.mass),
    facets = Type.of.feeding.interaction ~.,
    data = MyDF,
    xlab = "Prey Mass in grams", 
    ylab = "Predator Mass in grams",
    geom = c("point", "smooth"),
    colour=Predator.lifestage, shape= I(3))
    + geom_smooth(method = "lm",fullrange = TRUE)
