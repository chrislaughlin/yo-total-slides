#####################################################
# Some R code to get you going for the
# 2018 Melbourne Datathon
#####################################################

#install and load required libraries
#install.packages('data.table')
library(data.table)

#tell R where it can find the data
ScanOnFolderMaster <- '../../raw-data/samp_0/scanontransaction'
ScanOffFolderMaster <- '../../raw-data/samp_0/scanofftransaction'

mySamp <- 0

ScanOnFolder <- sub("x",mySamp,ScanOnFolderMaster)
ScanOffFolder <- sub("x",mySamp,ScanOffFolderMaster)

#list the files
onFiles <- list.files(ScanOnFolder,recursive = TRUE,full.names = TRUE)
offFiles <- list.files(ScanOffFolder,recursive = TRUE,full.names = TRUE)

#how many
allFiles <- union(onFiles,offFiles)
cat("\nthere are", length(allFiles),'files')


#------------------------------------
#read in a file and take a look
#------------------------------------
myFile <- onFiles[1]
cmd <- paste0("gzip -dc ", myFile)
dt <- fread(cmd,nrow=10000)

#these are the column names
colnames(dt) <- c('Mode','BusinessDate','DateTime','CardID','CardType','VehicleID','ParentRoute','RouteID','StopID')

#take a look
head(dt, 5)

# #summary stats
# summary(dt)
#
# #lets plot some distributions of the numerics
# hist(dt$Mode,col='blue')
# hist(dt$CardID,col='blue')
# hist(dt$CardType,col='blue',breaks=max(dt$CardType))
# hist(dt$VehicleID,col='blue')
# hist(dt$RouteID,col='blue')
# hist(dt$StopID,col='blue')
#
# #one field is clearly a date time
# dt$DateTime <- as.POSIXct(dt$DateTime)
# plot(dt$DateTime)
# hist(dt$DateTime,breaks=1000)
#
#
#
#
# #----------------------------------------
# # scan through the files and extract
# # a sample of specific rows and columns
# #----------------------------------------
#
# first <- TRUE
# count <- 0
#
# #we won't look at all the files
# #myFiles <- onFiles
# myFiles <- onFiles[1:10]
#
# for (myOn in myFiles){
#
#   cmd <- paste0("gzip -dc ", myOn)
#
#   #grab only 3 columns
#   dt <- fread(cmd,select = c(3,4,9))
#
#   #create a sample based on column 4 values
#   #note the samples are already sampled!
#   dt <- subset(dt,V4 %% 100 == mySamp)
#
#   #stack the records together
#   if (first == TRUE){
#     allON <- dt
#     first <- FALSE
#   } else {
#     l = list(dt,allON)
#     allON <- rbindlist(l)
#   }
#
#   count <- count + 1
#   cat('\n',count,' of ',length(myFiles))
#
# }
#
#
# cat('\n there are ', format(nrow(allON),big.mark = ","),'rows')
#
# colnames(allON) <- c('DateTime','CardID','StopID')
#
# allON
# summary(allON)
#
# hist(allON$CardID,col='blue')
#
#
# #one field is clearly a date time
# allON[,DateTime := as.POSIXct(DateTime,tz='Australia/Sydney')]
# allON[,unixTime := as.numeric(DateTime)]
# hist(allON$unixTime,breaks=1000)
#
# #write the file
# fwrite(allON,'C:/allon.txt')
#
#
#
# #----------------------------------
# # now add the locations
# #----------------------------------
#
# sl <- fread('D:/MelbDatathon2018/stop_locations.txt')
#
#
# #take a look
# sl
#
# #just keep the columns that look useful
# sl <- subset(sl,select=c('V1','V10','V11'))
# colnames(sl) <- c('StopID','lat','long')
#
#
#
# #merge the location onto the tap on data
# setkey(sl,StopID)
# setkey(allON,StopID)
#
# dt <- merge(allON,sl)
#
# #find the cards that have the most tap ons
# busy_travellers <- as.numeric(names(sort(table(dt$CardID),decreasing=TRUE)[1:50]))
#
# #take a subset of just these busy travellers
# bt <- subset(dt,CardID %in% busy_travellers )
#
# #finally a map
# plot(bt$lat,bt$long,col=factor(bt$CardID),pch=19,main="busy travellers")
