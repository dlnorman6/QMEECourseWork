## Load data: Consumer-Resource body mass ratios taken from the Ecological Archives of the ESA
MyDF <- read.csv("../data/EcolArchives-E089-51-D1.csv")
dim(MyDF) # 34931 x 15

str(MyDF)
head(MyDF)

plot(MyDF$Predator.mass,MyDF$Prey.mass)
# predator vs prey mass doesn't look very meaningful
# so take logs - body sizes across species tend to be log-normally distributed, with a lot of small species and few large ones

plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass))
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass),pch=20) # marker  = dots
plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass),pch=20,xlab = "Predator Mass (kg)",ylab = "Prey Mass (kg)") # add labels

## Plot histograms to see marginal distributions
# predators
hist(MyDF$Predator.mass) # predator mass is heavily right skewed, i.e. small masses dominate
hist(log(MyDF$Predator.mass),xlab="Predator Mass (kg)",ylab="Count",col="lightblue",border="pink")
# taking a log shows the distribution more clearly

# prey
hist(MyDF$Prey.mass) # prey mass is heavily right skewed too
hist(log(MyDF$Prey.mass),xlab="Prey Mass (kg)",ylab="Count",col="lightblue",border="pink")
# taking a log shows the distribution more clearly

## Using subplots
par(mfcol=c(2,1)) # initialise multi-panelled plot
par(mfg = c(1,1)) # specify which sub-plot to use first 
hist(log(MyDF$Predator.mass),
    xlab = "Predator Mass (kg)", ylab = "Count", 
    col = "lightblue", border = "pink", 
    main = 'Predator') # Add title
par(mfg = c(2,1)) # Second sub-plot
hist(log(MyDF$Prey.mass),
    xlab="Prey Mass (kg)",ylab="Count", 
    col = "lightgreen", border = "pink", 
    main = 'prey')
# Note: par can set other graphics parameters, e.g. margins, axis labels, etc.

## Overlaying plots
# Examine whether the mass distributions are similar by overlaying
hist(log(MyDF$Predator.mass), # Predator histogram
    xlab="Body Mass (kg)", ylab="Count", 
    col = rgb(1, 0, 0, 0.5), # Note 'rgb', fourth value is transparency
    main = "Predator-prey size Overlap",
    breaks=c(-11:13)) 
hist(log(MyDF$Prey.mass), breaks=c(-24:9), col = rgb(0, 0, 1, 0.5), add = T) # Plot prey
legend('topleft',c('Predators','Prey'),   # Add legend
    fill=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5))) # Define legend colors

##### BOXPLOTS #####
## Visual summary of data
boxplot(log(MyDF$Predator.mass), xlab = "Location", ylab = "Predator Mass", main = "Predator mass")
## Now plot mass per location
boxplot(log(MyDF$Predator.mass) ~ MyDF$Location, # Why the tilde?
    xlab = "Location", ylab = "Predator Mass",
    main = "Predator mass by location")

## Mass by feeding interaction type:
boxplot(log(MyDF$Predator.mass) ~ MyDF$Type.of.feeding.interaction,
    xlab = "Location", ylab = "Predator Mass",
    main = "Predator mass by feeding interaction type")

##### COMBINING PLOT TYPES #####
## Display mariginal distributions and scatterplot
## Note: c(xmin, xmax, ymin, ymax) specifies figure size and location in plot window
par(fig=c(0,0.8,0,0.8)) # specify figure size as proportion
 plot(log(MyDF$Predator.mass),log(MyDF$Prey.mass), xlab = "Predator Mass (kg)", ylab = "Prey Mass (kg)") # Add labels
 par(fig=c(0,0.8,0.4,1), new=TRUE)
 boxplot(log(MyDF$Predator.mass), horizontal=TRUE, axes=FALSE)
 par(fig=c(0.55,1,0,0.8),new=TRUE)
 boxplot(log(MyDF$Prey.mass), axes=FALSE)
 mtext("Fancy Predator-prey scatterplot", side=3, outer=TRUE, line=-3)

 #### LATTICE PLOTS ####
 ## Multi-panel plots
 library(lattice)
 densityplot(~log(Predator.mass) | Type.of.feeding.interaction, data=MyDF)

 #### SAVING GRAPHICS AS PDF ####
 pdf("../results/Pred_Prey_Overlay.pdf", # Open blank pdf page using a relative path
    11.7, 8.3) # These numbers are page dimensions in inches
hist(log(MyDF$Predator.mass), # Plot predator histogram (note 'rgb')
    xlab="Body Mass (kg)", ylab="Count", col = rgb(1, 0, 0, 0.5), main = "Predator-Prey Size Overlap") 
hist(log(MyDF$Prey.mass), # Plot prey weights
    col = rgb(0, 0, 1, 0.5), 
    add = T)  # Add to same plot = TRUE
legend('topleft',c('Predators','Prey'), # Add legend
    fill=c(rgb(1, 0, 0, 0.5), rgb(0, 0, 1, 0.5))) 
graphics.off(); #you can also use dev.off()

#### ggplot2 ####
## Note: ggplot2 only accepts data in data frames
## qplot: quick plotting, ggplot: fully customised plotting
## qplot assigns factor colours/markers for you and automatically adds corresponding legend
require(ggplot2) ## load the package

## Scatterplots
qplot(Prey.mass, Predator.mass, data=MyDF)
## Take logs
qplot(log(Prey.mass), log(Predator.mass), data=MyDF)
## Colour according to type of feeding interaction
qplot(log(Prey.mass), log(Predator.mass), data=MyDF, colour=Type.of.feeding.interaction)
## Change marker accordng to type of feeding interaction
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, shape = Type.of.feeding.interaction)

## Aesthetic mappings
# Compare colour assignment
qplot(log(Prey.mass), log(Predator.mass), 
    data = MyDF, colour = "red") # qplot converts to a faded shade of red
qplot(log(Prey.mass), log(Predator.mass),
    data = MyDF, colour = I("red")) # specify real red

# Compare point size assignment
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, size = 3) #with ggplot size mapping
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, size = I(3)) #no mapping

# Compare marker assignment
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, shape = 3) #will give error
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, shape= I(3))

## Setting transparency using alpha to see overlapping points
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, colour = Type.of.feeding.interaction, alpha = .5)

## Adding smoothers and regression lines
# add smoother using geom
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, geom = c("point", "smooth"))
# specify geom_smooth method as linear regression (lm)
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, geom = c("point", "smooth")) + geom_smooth(method = "lm")
# add smother for each type of interaction
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, geom = c("point", "smooth"), 
      colour = Type.of.feeding.interaction) + geom_smooth(method = "lm")
# use fullrange to extend lines
qplot(log(Prey.mass), log(Predator.mass), data = MyDF, geom = c("point", "smooth"),
      colour = Type.of.feeding.interaction) + geom_smooth(method = "lm",fullrange = TRUE)

## How does the ratio of prey/predator change according to type of interaction
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF)
# Jitter the points to get a better idea of the spread
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF, geom = "jitter")

## Boxplots
qplot(Type.of.feeding.interaction, log(Prey.mass/Predator.mass), data = MyDF, geom = "boxplot")

## Histograms and density plots
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "histogram")
# Colour according to interaction type
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "histogram", 
      fill = Type.of.feeding.interaction)
# Define binwidth (in units of x-axis)
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "histogram", 
      fill = Type.of.feeding.interaction, binwidth = 1)
# To make it easier to read, plot the smoothed density
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "density", 
      fill = Type.of.feeding.interaction)
# Make densities transparent so overlaps are visible
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "density", 
      fill = Type.of.feeding.interaction, 
      alpha = I(0.5))
# Or using colour instead of fill draws only the edge of the curve
qplot(log(Prey.mass/Predator.mass), data = MyDF, geom =  "density", 
      colour = Type.of.feeding.interaction)
# Similarly, geom=bar produces a barplot, line produces a series of points joined by a line

## Multi-faceted plots: similar to lattice
# facet by row: '~.'
qplot(log(Prey.mass/Predator.mass), facets = Type.of.feeding.interaction ~., data = MyDF, geom =  "density")
# facet by column: '.~'
qplot(log(Prey.mass/Predator.mass), facets =  .~ Type.of.feeding.interaction, data = MyDF, geom =  "density")
# facet by combination of categories
qplot(log(Prey.mass/Predator.mass), facets = .~ Type.of.feeding.interaction + Location, 
      data = MyDF, geom =  "density")
# also see facet_grid() and facet_wrap()

## Logarithmic axes: log="xy"
qplot(Prey.mass, Predator.mass, data = MyDF, log="xy",
    main = "Relation between predator and prey mass", 
    xlab = "log(Prey mass) (g)", 
    ylab = "log(Predator mass) (g)")
     + theme_bw() # suitable for black and white printing

## Saving plots
pdf("../results/MyFirst-ggplot2-Figure.pdf")
print(qplot(Prey.mass, Predator.mass, data = MyDF,log="xy",
    main = "Relation between predator and prey mass", 
    xlab = "log(Prey mass) (g)", 
    ylab = "log(Predator mass) (g)") + theme_bw())
dev.off()

#### Various geom ####
# geom specifies the geometric objects  that define graph type
## barplot
qplot(Predator.lifestage, data = MyDF, geom = "bar")
## boxplot
qplot(Predator.lifestage, log(Prey.mass), data = MyDF, geom = "boxplot")
## density
qplot(log(Predator.mass), data = MyDF, geom = "density")
## histogram
qplot(log(Predator.mass), data = MyDF, geom = "histogram")
## scatterplot
qplot(log(Predator.mass), log(Prey.mass), data = MyDF, geom = "point")
## smooth
qplot(log(Predator.mass), log(Prey.mass), data = MyDF, geom = "smooth")
## linear regression
qplot(log(Predator.mass), log(Prey.mass), data = MyDF, geom = "smooth", method = "lm")

#### ADVANCED PLOTTING: ggplot ####
# ggplot can use multiple datasets and aesthetics
## Begin with specifying data and aesthetics to graphics object p
p <- ggplot(MyDF, aes(x = log(Predator.mass),
                y = log(Prey.mass),
                colour = Type.of.feeding.interaction))
p # blank plot
## Specify geometry in order to plot graph; '+' concatenates commands
q <- p + geom_point(size=I(2), shape=I(10)) + theme_bw()
q
## Remove legend
q + theme(legend.position="none")

#### USEFUL ggplot EXAMPLES ####

## Plotting a matrix - have to reshape to dataframe
require(reshape2)
GenerateMatrix <- function(N){
    M <- matrix(runif(N*N),N,N)
    return(M)
}
M <- GenerateMatrix(10)
Melt <- melt(M)
p <- ggplot(Melt, aes(Var1, Var2, fill=value)) + geom_tile()
p
## Add a black line dividing cells
p + geom_tile(colour="black")
## Remove the legend
p + theme(legend.position="none")
## Remove all the rest
p + theme(legend.position = "none", 
     panel.background = element_blank(),
     axis.ticks = element_blank(), 
     panel.grid.major = element_blank(),
     panel.grid.minor = element_blank(),
     axis.text.x = element_blank(),
     axis.title.x = element_blank(),
     axis.text.y = element_blank(),
     axis.title.y = element_blank())
## Explore some colours
p + scale_fill_continuous(low = "yellow", high = "darkgreen")
p + scale_fill_gradient2() # white to blue/purple
p + scale_fill_gradientn(colours = grey.colors(10))
p + scale_fill_gradientn(colours = rainbow(10))
p + scale_fill_gradientn(colours = c("red", "white", "blue"))

#### PLOTTING TWO DATAFRAMES ####
## Girko's circular law: eig(M), where M is NxN, are contained in a circle in the complex plane with radius sqrt(N)
# Build function to calculate the ellipse
build_ellipse <- function(hradius, vradius){ # function that returns an ellipse
  npoints = 250
  a <- seq(0, 2*pi, length = npoints + 1)
  x <- hradius*cos(a)
  y <- vradius*sin(a)  
  return(data.frame(x = x, y = y))
}
N <- 250 # Assign size of the matrix
M <- matrix(rnorm(N * N), N, N) # Build the matrix
eigvals <- eigen(M)$values # Find the eigenvalues
eigDF <- data.frame("Real" = Re(eigvals), "Imaginary" = Im(eigvals)) # Build a dataframe
my_radius <- sqrt(N) # The radius of the circle is sqrt(N)
ellDF <- build_ellipse(my_radius, my_radius) # Dataframe to plot the ellipse
names(ellDF) <- c("Real", "Imaginary") # rename the columns
# Now plot
# Plot the eigenvalues
p <- ggplot(eigDF, aes(x = Real, y = Imaginary))
p <- p +
  geom_point(shape = I(3)) +
  theme(legend.position = "none")
# now add the vertical and horizontal line
p <- p + geom_hline(aes(yintercept = 0))
p <- p + geom_vline(aes(xintercept = 0))
# finally, add the ellipse
p <- p + geom_polygon(data = ellDF, aes(x = Real, y = Imaginary, alpha = 1/20, fill = "red"))
p

#### ANNOTATING PLOTS ####
p <- p + geom_text(data = a, aes(x = x, y = -500, label = Label))

#### MATHEMATICAL DISPLAY ####
## Create some linear regression data
x <- seq(0, 100, by = 0.1)
y <- -4. + 0.25 * x + rnorm(length(x), mean = 0., sd = 2.5)
# and put them in a dataframe
my_data <- data.frame(x = x, y = y)
# perform a linear regression
my_lm <- summary(lm(y ~ x, data = my_data))
# plot the data
p <-  ggplot(my_data, aes(x = x, y = y,colour = abs(my_lm$residual))) +
  geom_point() +
  scale_colour_gradient(low = "black", high = "red") +
  theme(legend.position = "none") +
  scale_x_continuous(
    expression(alpha^2 * pi / beta * sqrt(Theta)))
# add the regression line
p <- p + geom_abline(
  intercept = my_lm$coefficients[1][1],
  slope = my_lm$coefficients[2][1],
  colour = "red")
# throw some math on the plot
p <- p + geom_text(aes(x = 60, y = 0,
                       label = "sqrt(alpha) * 2* pi"), 
                       parse = TRUE, size = 6, 
                       colour = "blue")

p

#### ggthemes ####
## additional geom, scale and theme for ggplot
library(ggthemes)

p <- ggplot(MyDF,aes(x = log(Predator.mass), y = log(Prey.mass),
                colour = Type.of.feeding.interaction )) +
                geom_point(size=I(2), shape=I(10)) + theme_bw()

p + geom_rangeframe() + # now fine tune the geom to Tufte's range frame
        theme_tufte() # and theme to Tufte's minimal ink theme)
