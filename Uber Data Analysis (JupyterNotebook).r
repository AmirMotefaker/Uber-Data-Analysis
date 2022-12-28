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
