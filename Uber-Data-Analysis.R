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


