# load gpdd data consisting of 3 columns each containing 147 rows
# columns are: common.name, lat, long
load("../data/GPDDFiltered.RData")
library(maps)
map(database="world") # draw world map
points(gpdd$long, gpdd$lat, col="red", cex=0.2) # add locations for which we have gpdd data

## Most of the time series are from locations in the UK or the west coast of North America, which could bias any analysis