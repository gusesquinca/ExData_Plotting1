plot3 <- function()
{
#First part of the code is to Getting the Data
#=============================================
library(lubridate) 	#for later data subsetting
library(dplyr) 		#for data filtering

create the directory where the file will be downloaded
if (!file.exists("data_plot")) { 
   dir.create("data_plot") 
}

#downloading the file from the url
url <- ("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
setInternet2(TRUE)
download.file(url, "data_plot//power.zip")

#decompress the file to be able to read it
unzip("exdata-data-household_power_consumption.zip", "household_power_consumption.txt")

#read the file, ensuring to remove NA's and leaving the data as is ("character")
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, as.is = TRUE, na.strings = TRUE)
data$Date <- dmy(data$Date)  #giving format to date column
sub_data <- filter(data, Date > "2007-01-31" & Date <= "2007-02-02") #filtering with the Date column

#add a column to the data base with time and date together
sub_data$Date <- as.character(sub_data$Date)
Datetime <- paste(sub_data$Date," ", sub_data$Time)
subdata %>% mutate(Datetime = ymd_hms(Datetime))

#Second step plotting the data
#======================================================
sub_data$Sub_metering_1 <- as.numeric(sub_data$Sub_metering_1)	#changing value format of the variable for plotting
sub_data$Sub_metering_2 <- as.numeric(sub_data$Sub_metering_1)	#changing value format of the variable for plotting
sub_data$Sub_metering_3 <- as.numeric(sub_data$Sub_metering_1)	#changing value format of the variable for plotting

plot(Datetime, sub_data$Sub_metering_1, type = "l", ylab = "Energy sub metering")
points(Datetime, sub_data$Sub_metering_2, type = "l", col = "red")
points(Datetime, sub_data$Sub_metering_3, type = "l", col = "blue")
legend("topright", pch = "_", pt.cex = 2, col = c("black","red","blue"), legend = c("Sub_meterin_1", "Sub_metering_2", "Sub_metering_3"))

#Third step copying the graph to png file, look for it on your working directory
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()
}


