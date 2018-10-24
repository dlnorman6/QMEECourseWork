################################################################
## Wrangling the Pound Hill Dataset using dplyr and tidyr
################################################################

############# Load the dataset ###############
# header = false because the raw data don't have real headers
# stringsAsFactors=F ensures the data are imported "as is", i.e. characters not factors 
MyData <- as.matrix(read.csv("../data/PoundHillData.csv",header = F)) 

# header = true because we do have metadata headers
# desciption of data collected i.e. each field in data
MyMetaData <- read.csv("../data/PoundHillMetaData.csv",header = T, sep=";", stringsAsFactors = F)

############# Inspect the dataset ###############
require(dplyr)
dplyr::dim_desc(MyData) # 45 x 60
dplyr::tbl_df(MyData) # like head()
dplyr::glimpse(MyData) # displays internal structure
utils::View(MyData) # visualise in table
utils::View(MyMetaData)

############# Transpose ###############
# To get those species into columns and treatments into rows 
# for converting wide format to long format, better for analysis
MyData <- t(MyData) 
utils:View(MyData) # note column headers are not encoded as headers
dplyr::dim_desc(MyData)

############# Replace species absences with zeros ###############
# since blank cells are true absences
MyData[MyData == ""] = 0

############# Convert raw matrix to data frame ###############

TempData <- as.data.frame(MyData[-1,],stringsAsFactors = F) #stringsAsFactors = F is important!
colnames(TempData) <- MyData[1,] # assign column names from original data
rownames(TempData) <- NULL # not essential
utils::View(TempData)

############# Convert from wide to long format  ###############
require(tidyr) # load the tidyr package

?gather #check out the gather function

## gather combines the specified columns
MyWrangledData <- tidyr::gather(TempData,"Species", "Count",5:45)

## Assign correct data types to eahc column
MyWrangledData[, "Cultivation"] <- as.factor(MyWrangledData[, "Cultivation"])
MyWrangledData[, "Block"] <- as.factor(MyWrangledData[, "Block"])
MyWrangledData[, "Plot"] <- as.factor(MyWrangledData[, "Plot"])
MyWrangledData[, "Quadrat"] <- as.factor(MyWrangledData[, "Quadrat"])
MyWrangledData[, "Count"] <- as.numeric(MyWrangledData[, "Count"])

dplyr::glimpse(MyWrangledData)
utils::View(MyWrangledData)
dplyr::dim_desc(MyWrangledData) # 2419 x 6

######### Data wrangling with dplyr, tidyr #########

dplyr::filter(MyWrangledData, Count>100) # like subset()
dplyr::slice(MyWrangledData, 10:15) # look at an arbitrary set of rows
