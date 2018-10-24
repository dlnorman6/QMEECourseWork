### Read in data
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")

### Load lattice
library(lattice)

### Plot predator mass by feeding interaction type
pdf("../results/Pred_Lattice.pdf", 11.7, 8.3) # Open blank pdf page
print(densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data=MyDF,
    main="Predator mass by feeding interaction type"))
graphics.off()

### Plot prey mass by feeding interaction type
pdf("../results/Prey_Lattice.pdf", 11.7, 8.3) # Open blank pdf page
print(densityplot(~log(Prey.mass) | Type.of.feeding.interaction, data=MyDF,
    main="Prey mass by feeding interaction type"))
graphics.off()

### Plot ratio of prey mass over predator mass by feeding interaction type
pdf("../results/SizeRatio_Lattice.pdf", 11.7, 8.3) # Open blank pdf page
print(densityplot(~log(Prey.mass/Predator.mass) | Type.of.feeding.interaction, data=MyDF,
    main="Size ratio of prey/predator mass by feeding interaction type"))
graphics.off()

output = matrix(NA,16,4)
output[1,] = c("Data element","Feeding type","Mean","Median")
output[2:16,1] = c(rep(c("log predator mass","log prey mass","log predator-prey size ratio"),each=5))
output[2:16,2] = rep(levels(MyDF$Type.of.feeding.interaction))
output[2:6,3] <- tapply(log(MyDF$Predator.mass),MyDF$Type.of.feeding.interaction,mean)
output[2:6,4] <- tapply(log(MyDF$Predator.mass),MyDF$Type.of.feeding.interaction,median)
output[7:11,3] <- tapply(log(MyDF$Prey.mass),MyDF$Type.of.feeding.interaction,mean)
output[7:11,4] <- tapply(log(MyDF$Prey.mass),MyDF$Type.of.feeding.interaction,median)
output[12:16,3] <- tapply(log(MyDF$Prey.mass/MyDF$Predator.mass),MyDF$Type.of.feeding.interaction,mean)
output[12:16,4] <- tapply(log(MyDF$Prey.mass/MyDF$Predator.mass),MyDF$Type.of.feeding.interaction,median)
write.csv(output, "../results/PP_Results.csv")