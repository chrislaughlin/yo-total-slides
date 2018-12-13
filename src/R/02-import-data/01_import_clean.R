######################################################################
## PACKAGES
######################################################################

# TODO: separate this into 01
library(readr)
library(data.table)
library(tidyr)
library(dplyr)
library(lubridate)
library(stringr)
library(beepr)
library(magrittr)
library(ggplot2)
library(ggmap)
library(RColorBrewer)


## set your own working directory
setwd("/Users/ellenitoumpas/Dropbox/DATA/DATATHON/datathon/melbourne-datathon/")


######################################################################
## IMPORT FILES (except touch on and touch off)
######################################################################

# TODO: separate this into 02

calendar <- read.table("calendar.txt", sep="|", header=FALSE, col.names = c("DateSequence", "Date" ,"CalendarYear" ,"FinancialYear" ,"FinancialMonth" ,"CalendarMonth" ,"CalendarMonthSeq" ,"CalendarQuarter" ,"FinancialQuarter" ,"CalendarWeek" ,"FinancialWeek" ,"DayType" ,"DayTypeCategory", "DayTypeCategoryMore","WeekdaySeq" ,"WeekDay" ,"FinancialMonthSeq" ,"FinancialMonthName" ,"MonthNumber" ,"ABSWeek" ,"WeekEnding" ,"QuarterName"))
car_speeds <- read_csv("car_speeds/melbourne_vehicle_traffic.csv")
card_type <- read.table("card_types.txt", sep="|", header=FALSE, col.names = c("Card_SubType_ID" , "Card_SubType_Desc", "Payment_Type", "Fare_Type", "Concession_Type", "MI_Card_Group"))
stoplocations <- read.table("stop_locations.txt", sep="|", fill = TRUE, col.names=c("StopLocationID" , "StopNameShort", "StopNameLong", "StopType", "SuburbName", "PostCode", "RegionName", "LocalGovernmentArea", "StatDivision", "GPSLat", "GPSLong"))


######################################################################
## IMPORT TXT FILES IN SUBFOLDERS - COPIED FROM ORGANISERS NOTES
######################################################################

#tell R where it can find the data
ScanOnFolderMaster <- 'Samp_X/ScanOnTransaction'
ScanOffFolderMaster <- 'Samp_X/ScanOffTransaction'

# define if we want sample 0 or sample 1
mySamp <- 1

ScanOnFolder <- sub("X",mySamp,ScanOnFolderMaster)
ScanOffFolder <- sub("X",mySamp,ScanOffFolderMaster)

#list the files
onFiles <- list.files(ScanOnFolder,recursive = TRUE,full.names = TRUE)
offFiles <- list.files(ScanOffFolder,recursive = TRUE,full.names = TRUE)

#how many touch off files we have
cat("\nthere are", length(offFiles),'files')

# set up an empty dataframe for all of touch off data
scanOff_all_samp1 <- data.frame(Mode=integer(),
                                BusinessDate=character(),
                                DateTime=character(),
                                CardID = integer(),
                                CardType = integer(),
                                VehicleID = integer(),
                                ParentRoute = character(),
                                RouteID = integer(),
                                StopID = integer(),
                   stringsAsFactors=FALSE)

scanOn_all_samp1 <- data.frame(Mode=integer(),
                                BusinessDate=character(),
                                DateTime=character(),
                                CardID = integer(),
                                CardType = integer(),
                                VehicleID = integer(),
                                ParentRoute = character(),
                                RouteID = integer(),
                                StopID = integer(),
                                stringsAsFactors=FALSE)

#---------------------------------------------------
#read in all touch off files and collate to one file
#---------------------------------------------------

for (i in 1:157){
  
  # which file are we importing
  myFile <- offFiles[i]
 
  # import file
  cmd <- paste0("gzip -dc ", myFile)
  dt <- fread(cmd,nrow=10000,sep="|",fill=TRUE)
 
  # bind imported file to the main dataframe
  scanOff_all_samp1 <- rbind(as.data.frame(scanOff_all_samp1), as.data.frame(dt))
   
}

colnames(scanOff_all_samp1) <- c('Mode','BusinessDate','DateTime','CardID','CardType','VehicleID','ParentRoute','RouteID','StopID')
head(scanOff_all_samp1)
beep()

#---------------------------------------------------
#read in all touch on files and collate to one file
#---------------------------------------------------


for (i in 1:157){
  # which file are we importing
  myFile <- onFiles[i]
 
  # import file
  cmd <- paste0("gzip -dc ", myFile)
  dt <- fread(cmd,nrow=10000,sep="|",fill=TRUE)
 
  # bind imported file to the main dataframe
  scanOn_all_samp1 <- rbind(as.data.frame(scanOn_all_samp1), as.data.frame(dt))
 
}
colnames(scanOn_all_samp1) <- c('Mode','BusinessDate','DateTime','CardID','CardType','VehicleID','ParentRoute','RouteID','StopID')

beep()


write.csv(scanOn_all_samp1, file = "all_scanOff_scanOn/all_scanOn_samp1.csv", row.names=FALSE)
write.csv(scanOff_all_samp1, file = "all_scanOff_scanOn/all_scanOff_samp1.csv", row.names=FALSE)

# TODO: save this into data folder




######################################################################
## 01. CLEAN FILES
######################################################################

# TODO: separate this into 03


all_scanOn_samp0 <- read_csv("all_scanOff_scanOn/all_scanOn_samp0.csv", col_names = TRUE)
all_scanOff_samp0 <- read_csv("all_scanOff_scanOn/all_scanOff_samp0.csv", col_names = TRUE)
all_scanOn_samp1 <- read_csv("all_scanOff_scanOn/all_scanOn_samp1.csv", col_names = TRUE)
all_scanOff_samp1 <- read_csv("all_scanOff_scanOn/all_scanOff_samp1.csv", col_names = TRUE)

head(all_scanOn_samp0)
head(all_scanOff_samp0)
head(all_scanOn_samp1)
head(all_scanOff_samp1)


######################################################################
## LOOKING AT CAR SPEEDS DATA
######################################################################

# TODO: separate this into 04


head(car_speeds)

## remove [ and ] from mean_speed and std_speed columns
######################################################################
car_speeds$mean_speed <-  gsub("\\[","", car_speeds$mean_speed)
car_speeds$mean_speed <-  gsub("]","", car_speeds$mean_speed)
car_speeds$std_speed <-  gsub("\\[","", car_speeds$std_speed)
car_speeds$std_speed <-  gsub("]","", car_speeds$std_speed)


# seperate 120 records from mean_speed and std_speed
######################################################################
car_speeds_separate <- separate(data=car_speeds, col=mean_speed,into = paste0("mean_speed_",1:120), sep=",")
car_speeds_separate <- separate(data=car_speeds_separate, col=std_speed,into = paste0("std_speed_",1:120), sep=",")


# check datatypes of each column
######################################################################
str(car_speeds_separate)


# change datatape of all columns from character to number
######################################################################
cols_to_change = c(4:ncol(car_speeds_separate))
for(i in cols_to_change){
  car_speeds_separate[[i]] <-  as.numeric(car_speeds_separate[[i]])
}

#check datatype of each column again
######################################################################
str(car_speeds_separate)


# checking typos/ data entry errors or data import errors
######################################################################


# sanity checks - what are impossible values - check max and min speeds
######################################################################

cols_to_change <- c(4:123)

impossible_results_meanspeed <- vector()

for(i in cols_to_change){
  max_speed <-  max(car_speeds_separate[[i]])
  # min_speed <-  min(car_speeds_separate[[i]])
  # print(paste0("Maximum mean speed for column ",colnames(car_speeds_separate[i]), " is ", max_speed))
  # print(paste0("Minimum mean speed for column ",colnames(car_speeds_separate[i]), " is ", min_speed))
  if (min_speed == -1){
    impossible_results_meanspeed<-c(impossible_results_meanspeed,colnames(car_speeds_separate[i]))
  }
}

print("All the results that have a -1 value for minimum mean car speed is: ")
impossible_results_meanspeed
length(impossible_results_meanspeed)


# sanity checks - what are impossible values - check std_speeds
######################################################################




# where are these latitude and longitudes??
# are some of the max speed locations possible?? A lot of 100+ speeds
######################################################################
# getting the map
mapgilbert <- get_map(location = c(lon = mean(max_dataframe$lon), lat = mean(max_dataframe$lat)), zoom = 9.5,
                      maptype = "roadmap", scale = 2)

# creating a dataframe with lat and lon but max_speed is 'empty' or filled with 0
max_dataframe <- data.frame(lat = car_speeds_separate$lat, lon = car_speeds_separate$lon, max_speed = 0, colour = '0')
max_dataframe$colour <- as.character(max_dataframe$colour)

# now populate the max_speed
cols_to_change = c(1:nrow(car_speeds_separate))


# selects the maximum car speed for that lat/ lon coordinate and then associates a colour for it
for(i in cols_to_change){
  max_dataframe$max_speed[i] <- (max(car_speeds_separate[i,4:123]))
  if (max_dataframe$max_speed[i] < 20) {
    max_dataframe$colour[i] <- "#7a82f9"
    #print("20")
  } else if (20 <= max_dataframe$max_speed[i] & max_dataframe$max_speed[i] < 40) {
    max_dataframe$colour[i] <-  "#9e6bd5"
    #print("40")
  } else if (40 <= max_dataframe$max_speed[i] & max_dataframe$max_speed[i] < 60) {
    max_dataframe$colour[i] <- "#b055ac"
    #print("60")
  } else if (60 <= max_dataframe$max_speed[i] & max_dataframe$max_speed[i] < 80) {
    max_dataframe$colour[i] <-  "#b73f82"
    #print("80")
  } else if (80 <= max_dataframe$max_speed[i] & max_dataframe$max_speed[i] < 100) {
    max_dataframe$colour[i] <- "#b82655"
    #print("100")
  } else if (max_dataframe$max_speed[i] >= 100){
    max_dataframe$colour[i] <- "#b40000"
    #print("more")
  }
}

# TODO: separate this into 05


# plotting the map with some points on it
ggmap(mapgilbert) + geom_point(data = max_dataframe, aes(x = lon, y = lat, fill = colour, alpha = 0.8), size=1, shape = 21) + guides(fill=guide_legend(title="Maximum speeds", title.position="top",label=TRUE))



# add a legend so you can see what the 'max' speeds are for this area
# labels=(c("0 - 20", "20 - 40", "40 - 60", "60 - 80", "80 - 100", "100 +"))
# export as a jpeg so we can see it larger




## mean speed - time series plot for 1st row
######################################################################

## NOT WORKING YET

# data_temp <- data.frame(time = seq(1, 120), speed = t(car_speeds_separate[1,4:123]))
#
# # Graph cars using blue points overlayed by a line
# plot(data_temp, type="o", col="blue")
#
# # Create a title with a red, bold/italic font
# title(main="Autos", col.main="red", font.main=4)

# check and replace missing values
######################################################################



# check and replace outliers
######################################################################



# what locations are those lat / long speeds
######################################################################





######################################################################
## LOOKING AT SAMP_0 TOUCH ON DATA
######################################################################

# check all datatypes of each column

# TODO: separate this into 04


str(all_scanOn_samp0)
class(all_scanOn_samp0$Mode)
class(all_scanOn_samp0$BusinessDate)
class(all_scanOn_samp0$DateTime)
class(all_scanOn_samp0$CardType)
class(all_scanOn_samp0$VehicleID)
class(all_scanOn_samp0$ParentRoute)
class(all_scanOn_samp0$RouteID)
class(all_scanOn_samp0$StopID)

# mutate/split any columns that are incorrect (each value should be in its own column)
# checking typos/ data entry errors or data import errors
# check extra whitespace on values
# check text upper/ lower case
# check sanity checks
# check and replace missing values
# check and replace outliers


######################################
## FOR EACH DATASET
######################################
# check all datatypes of each column
# mutate/split any columns that are incorrect (each value should be in its own column)
# checking typos/ data entry errors or data import errors
# check extra whitespace on values
# check text upper/ lower case
# check sanity checks
# check and replace missing values
# check and replace outliers




str(calendar)
