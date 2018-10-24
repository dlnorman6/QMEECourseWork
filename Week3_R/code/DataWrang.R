################################################################
################## Wrangling the Pound Hill Dataset ############
################################################################

############# Load the dataset ###############
# header = false because the raw data don't have real headers
# stringsAsFactors=F ensures the data are imported "as is", i.e. characters not factors 
MyData <- as.matrix(read.csv("../data/PoundHillData.csv",header = F)) 

# header = true because we do have metadata headers
# desciption of data collected i.e. each field in data
MyMetaData <- read.csv("../data/PoundHillMetaData.csv",header = T, sep=";", stringsAsFactors = F)

############# Inspect the dataset ###############
head(MyData)
dim(MyData) # 45 x 60
str(MyData) # displays internal structure
fix(MyData) # visualise in table
fix(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
# for converting wide format to long format, better for analysis
MyData <- t(MyData) 
head(MyData) # note column headers are not encoded as headers
dim(MyData)

############# Replace species absences with zeros ###############
# since blank cells are true absences
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data
rownames(TempData) <- NULL # not essential

############# Convert from wide to long format  ###############
require(reshape2) # load the reshape2 package

?melt #check out the melt function

MyWrangledData <- melt(TempData, id=c("Cultivation", "Block", "Plot", "Quadrat"), variable.name = "Species", value.name = "Count")

## Assign correct data types to eahc column
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.numeric(MyWrangledData[, "Count"])

str(MyWrangledData)
head(MyWrangledData)
dim(MyWrangledData)

############# Start exploring the data (extend the script below)!  ###############

str(MyWrangledData$Species) # 41 species
str(MyWrangledData$Quadrat) # 6 quadrats within...
str(MyWrangledData$Plot) # 12 plots within...
str(MyWrangledData$Block) # 4 blocks
str(MyWrangledData$Cultivation) # 3 treatment months

######### Data wrangling with dplyr, tidyr #########
require(dplyr)
dplyr::tbl_df(MyWrangledData) # like head() but nicer
dplyr::glimpse(MyWrangledData) # like str(), but nicer
utils::View(MyWrangledData) # same as fix()
dplyr::filter(MyWrangledData, Count>100) # like subset()
dplyr::slice(MyWrangledData, 10:15) # look at an arbitrary set of rows
