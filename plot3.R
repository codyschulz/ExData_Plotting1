######################################
# Course 4: Week 1 Project -- Plot 3 #
######################################

##### Initials #####

### Remove scientific notation
options(scipen=999)

### Clear memory
rm(list=ls())

### Set working directory
setwd("G:/My Documents/Other/data_sci/course_4/ExData_Plotting1")
setwd("C:/Users/Cody/Google Drive/Data Science/course_4/ExData_Plotting1")

### Open packages
libs <- c("dplyr", "readr", "lattice", "ggplot2", "datasets")
lapply(libs, require, character.only = TRUE)

##### Download and unzip file

zipFileName <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"

zipFileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

txtFileName <- "household_power_consumption.txt"

if(!file.exists(zipFileName)) {
  download.file(
    url = zipFileUrl,
    destfile = zipFileName
  )
  if(!file.exists(txtFileName)) {
    unzip(zipFileName)
  }
}

##### Size estimate: 2 million rows * 9 columns * 8 bits/column =
##### ~ 150 megabytes

### Open data

power <- read_delim(txtFileName, delim = ";")

power1 <- power %>%
  
  mutate(
    
    ###
    datetime = paste(Date, Time),
    
    datetime1 = as.POSIXct(strptime(datetime, format = "%Y-%m-%d %T")),
    
    ### Convert date to date
    Date = as.Date(Date, format = "%d/%m/%Y"),
    
    ### Extract weekday
    weekday = weekdays(Date)
    
  ) %>%
  
  ### Subset to 2007-02-01 and 2007-02-02
  filter(Date %in% c(as.Date("2007-02-01"), as.Date("2007-02-02"))) %>%
  
  mutate(datetime = paste(Date, Time))%>% 
  
  mutate(datetime1 = as.POSIXct(strptime(datetime, format = "%Y-%m-%d %T")))


### Make a histogram of Global Active Power
png("plot3.png")
with(power1, {
  plot(
    datetime1,
    Sub_metering_1,
    type = "l",
    ylab = "Energy by sub metering",
    xlab = ""
  )
  lines(
    datetime1, 
    Sub_metering_2,
    col = "red"
  )
  lines(
    datetime1,
    Sub_metering_3,
    col = "blue"
  )
})
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

