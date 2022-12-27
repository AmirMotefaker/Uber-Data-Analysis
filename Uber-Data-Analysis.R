# Importing the Essential Packages
library(ggplot2)
library(ggthemes)
library(lubridate)
library(dplyr)
library(tidyr)
library(DT)
library(scales)


# Creating vector of colors for the plots
colors = c("#CC1011", "#665555", "#05a399", "#cfcaca", "#f5e840", "#0683c9", "#e075b0")
colors
# Output:
# [1] "#CC1011" "#665555" "#05a399" "#cfcaca" "#f5e840" "#0683c9" "#e075b0"


getwd()
# [1] "C:/Users/Amir/Documents/Uber-Data-Analysis"


# Read the data for each month separately 
apr <- read.csv("D:/AMIR/Programming/Data Science/R Projects/Uber Data Analysis/Dataset/uber-raw-data-apr14.csv")
may <- read.csv("D:/AMIR/Programming/Data Science/R Projects/Uber Data Analysis/Dataset/uber-raw-data-may14.csv")
june <- read.csv("D:/AMIR/Programming/Data Science/R Projects/Uber Data Analysis/Dataset/uber-raw-data-jun14.csv")
july <- read.csv("D:/AMIR/Programming/Data Science/R Projects/Uber Data Analysis/Dataset/uber-raw-data-jul14.csv")
aug <- read.csv("D:/AMIR/Programming/Data Science/R Projects/Uber Data Analysis/Dataset/uber-raw-data-aug14.csv")
sept <- read.csv("D:/AMIR/Programming/Data Science/R Projects/Uber Data Analysis/Dataset/uber-raw-data-sep14.csv")


# Combine the data together 
data <- rbind(apr, may, june, july, aug, sept)
cat("The dimensions of the data are:", dim(data))
# The dimensions of the data are: 4534327 4


# Print the first 6 rows of the data
head(data)
# Date.Time     Lat      Lon   Base
# 1 4/1/2014 0:11:00 40.7690 -73.9549 B02512
# 2 4/1/2014 0:17:00 40.7267 -74.0345 B02512
# 3 4/1/2014 0:21:00 40.7316 -73.9873 B02512
# 4 4/1/2014 0:28:00 40.7588 -73.9776 B02512
# 5 4/1/2014 0:33:00 40.7594 -73.9722 B02512
# 6 4/1/2014 0:33:00 40.7383 -74.0403 B02512

# The data contains the columns Date. 
# Time is a factor, Latitude, and Longitudes are double, and Base is a factor.
# we will format the DateTime into a more readable format using the Date Time conversion function.


# Readable format for the DateTime
data$Date.Time <- as.POSIXct(data$Date.Time, format="%m/%d/%Y %H:%M:%S")
data$Time <- format(as.POSIXct(data$Date.Time, format = "%m/%d/%Y %H:%M:%S"), format="%H:%M:%S")
data$Date.Time <- ymd_hms(data$Date.Time)
head(data)
# Date.Time     Lat      Lon   Base     Time
# 1 2014-04-01 00:11:00 40.7690 -73.9549 B02512 00:11:00
# 2 2014-04-01 00:17:00 40.7267 -74.0345 B02512 00:17:00
# 3 2014-04-01 00:21:00 40.7316 -73.9873 B02512 00:21:00
# 4 2014-04-01 00:28:00 40.7588 -73.9776 B02512 00:28:00
# 5 2014-04-01 00:33:00 40.7594 -73.9722 B02512 00:33:00
# 6 2014-04-01 00:33:00 40.7383 -74.0403 B02512 00:33:00

