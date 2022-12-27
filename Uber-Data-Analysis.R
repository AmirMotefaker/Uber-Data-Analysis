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
apr <- read.csv("C:/Users/Amir/Documents/Uber-Data-Analysis/Dataset/uber-raw-data-apr14.csv")
may <- read.csv("C:/Users/Amir/Documents/Uber-Data-Analysis/Dataset/uber-raw-data-may14.csv")
june <- read.csv("C:/Users/Amir/Documents/Uber-Data-Analysis/Dataset/uber-raw-data-jun14.csv")
july <- read.csv("C:/Users/Amir/Documents/Uber-Data-Analysis/Dataset/uber-raw-data-jul14.csv")
aug <- read.csv("C:/Users/Amir/Documents/Uber-Data-Analysis/Dataset/uber-raw-data-aug14.csv")
sept <- read.csv("C:/Users/Amir/Documents/Uber-Data-Analysis/Dataset/uber-raw-data-sep14.csv")


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

