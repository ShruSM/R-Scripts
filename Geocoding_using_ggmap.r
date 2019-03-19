######install the required packages#########
install.packages("ggmap")
install.packages("devtools")
library(ggmap)

##SET WORKING DIRECTORY##
setwd("C:\\Folder\\Folder\\Documents\\Folder\\Geocoding")
devtools::install_github("dkahle/ggmap")

####Obatin google key by activating geocoding API and creating new credential key######
register_google(key = "Google API key")     ## Looks something like this: WqDiSyAwfuiT5mwNmHXUN9Idd1V56MB1C4LZlFAE

###READ DATA: csv file with addresses. sample: 2401 S University Dr, Fort Worth, TX 76109 ###
data <- read.csv("addresses.csv", header=TRUE, stringsAsFactors = FALSE)
address_list <- unique(data$addresses)

###CREATING A DATA FRAME TO APPEND VALUES TO ###
address <- vector()
lat <- vector()
long <- vector()

###GEOCODE ###
for (i in 1:length(address_list)) 
{
  coord <- geocode(address_list[i])
  address <- append(address,address_list[i])
  lat <- append(lat,coord[2])
  long <- append(long,coord[1])
}

data_frame=data.frame(cbind(address,lat,long),stringsAsFactors=FALSE)

###Write output to file
write.table(data_frame, geocoding_results.txt, row.names = F, sep = "\t" )
