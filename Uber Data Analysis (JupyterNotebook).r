# install.packages("package_name") in R console
library(ggplot2)
# library(ggthemes)
library(lubridate)
library(dplyr)
library(tidyr)
library(DT)
library(scales)

# Creating vector of colors for the plots
colors = c("#CC1011", "#665555", "#05a399", "#cfcaca", "#f5e840", "#0683c9", "#e075b0")
colors

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

# Print the first 6 rows of the data
head(data)

# Readable format for the DateTime
data$Date.Time <- as.POSIXct(data$Date.Time, format="%m/%d/%Y %H:%M:%S")
data$Time <- format(as.POSIXct(data$Date.Time, format = "%m/%d/%Y %H:%M:%S"), format="%H:%M:%S")
data$Date.Time <- ymd_hms(data$Date.Time)
head(data)
