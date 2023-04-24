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


# Create individual columns for month day and year
data$day <- factor(day(data$Date.Time))
data$month <- factor(month(data$Date.Time, label=TRUE))
data$year <- factor(year(data$Date.Time))
data$dayofweek <- factor(wday(data$Date.Time, label=TRUE))
head(data)
# Date.Time     Lat      Lon   Base     Time day month year dayofweek
# 1 2014-04-01 00:11:00 40.7690 -73.9549 B02512 00:11:00   1   Apr 2014       Tue
# 2 2014-04-01 00:17:00 40.7267 -74.0345 B02512 00:17:00   1   Apr 2014       Tue
# 3 2014-04-01 00:21:00 40.7316 -73.9873 B02512 00:21:00   1   Apr 2014       Tue
# 4 2014-04-01 00:28:00 40.7588 -73.9776 B02512 00:28:00   1   Apr 2014       Tue
# 5 2014-04-01 00:33:00 40.7594 -73.9722 B02512 00:33:00   1   Apr 2014       Tue
# 6 2014-04-01 00:33:00 40.7383 -74.0403 B02512 00:33:00   1   Apr 2014       Tue


# Add Time variables as well 
data$second = factor(second(hms(data$Time)))
data$minute = factor(minute(hms(data$Time)))
data$hour = factor(hour(hms(data$Time)))


# Look at the data
head(data)
# Date.Time     Lat      Lon   Base     Time day month year dayofweek second minute hour
# 1 2014-04-01 00:11:00 40.7690 -73.9549 B02512 00:11:00   1   Apr 2014       Tue      0     11    0
# 2 2014-04-01 00:17:00 40.7267 -74.0345 B02512 00:17:00   1   Apr 2014       Tue      0     17    0
# 3 2014-04-01 00:21:00 40.7316 -73.9873 B02512 00:21:00   1   Apr 2014       Tue      0     21    0
# 4 2014-04-01 00:28:00 40.7588 -73.9776 B02512 00:28:00   1   Apr 2014       Tue      0     28    0
# 5 2014-04-01 00:33:00 40.7594 -73.9722 B02512 00:33:00   1   Apr 2014       Tue      0     33    0
# 6 2014-04-01 00:33:00 40.7383 -74.0403 B02512 00:33:00   1   Apr 2014       Tue      0     33    0



## Data Visualisation

# Plotting the trips by hours in a day
hourly_data <- data %>% 
  group_by(hour) %>% 
  dplyr::summarize(Total = n())

# Show data in a searchable js table
datatable(hourly_data)
#       hour	Total
# 1 	  0	    103836
# 2	    1   	67227
# 3	    2	    45865
# 4	    3	    48287
# 5	    4	    55230
# 6	    5	    83939
# 7	    6   	143213
# 8	    7	    193094
# 9	    8	    190504
# 10  	9	    159967
# ...


# Plot the data by hour
ggplot(hourly_data, aes(hour, Total)) + 
  geom_bar(stat="identity", 
           fill="steelblue", 
           color="red") + 
  ggtitle("Trips Every Hour", subtitle = "aggregated today") + 
  theme(legend.position = "none", 
        plot.title = element_text(hjust = 0.5), 
        plot.subtitle = element_text(hjust = 0.5)) + 
  scale_y_continuous(labels=comma)


# Plotting trips by hour and month
# Aggregate the data by month and hour
month_hour_data <- data %>% group_by(month, hour) %>%  dplyr::summarize(Total = n())
# `summarise()` has grouped output by 'month'. You can override using the `.groups` argument.

ggplot(month_hour_data, aes(hour, Total, fill=month)) + 
  geom_bar(stat = "identity") + 
  ggtitle("Trips by Hour and Month") + 
  scale_y_continuous(labels = comma)


# Plotting data by trips during every day of the month
# Aggregate data by day of the month 
day_data <- data %>% group_by(day) %>% dplyr::summarize(Trips = n())
day_data
## A tibble: 31 × 2
# day    Trips
# <fct>  <int>
#   1 1     127430
# 2 2     143201
# 3 3     142983
# 4 4     140923
# 5 5     147054
# 6 6     139886
# 7 7     143503
# 8 8     145984
# 9 9     155135
# 10 10    152500
## … with 21 more rows
## ℹ Use `print(n = ...)` to see more rows


# Plot the data for the day
ggplot(day_data, aes(day, Trips)) + 
  geom_bar(stat = "identity", fill = "steelblue") +
  ggtitle("Trips by day of the month") + 
  theme(legend.position = "none") + 
  scale_y_continuous(labels = comma)


# Collect data by day of the week and month
day_month_data <- data %>% group_by(dayofweek, month) %>% dplyr::summarize(Trips = n())
# `summarise()` has grouped output by 'dayofweek'. You can override using the `.groups` argument.
day_month_data
# # A tibble: 42 × 3
# # Groups:   dayofweek [7]
# dayofweek month  Trips
# <ord>     <ord>  <int>
#   1 Sun       Apr    51251
# 2 Sun       May    56168
# 3 Sun       Jun    79656
# 4 Sun       Jul    76327
# 5 Sun       Aug   110246
# 6 Sun       Sep   116532
# 7 Mon       Apr    60861
# 8 Mon       May    63846
# 9 Mon       Jun    94655
# 10 Mon       Jul    93189
# # … with 32 more rows
# # ℹ Use `print(n = ...)` to see more rows


# Plot the Collect data by day of the week and month
ggplot(day_month_data, aes(dayofweek, Trips, fill = month)) + 
  geom_bar(stat = "identity", aes(fill = month), position = "dodge") + 
  ggtitle("Trias by Day and Month") + 
  scale_y_continuous(labels = comma) + 
  scale_fill_manual(values = colors)


# Number of Trips place during months in a year
month_data <- data %>% group_by(month) %>% dplyr::summarize(Total = n())

month_data
# # A tibble: 6 × 2
# month   Total
# <ord>   <int>
#   1 Apr    564516
# 2 May    652435
# 3 Jun    663844
# 4 Jul    796121
# 5 Aug    829275
# 6 Sep   1028136


# Plot the Number of Trips place during months in a year
ggplot(month_data, aes(month, Total, fill = month)) + 
  geom_bar(stat = "Identity") + 
  ggtitle("Trips in a month") + 
  theme(legend.position = "none") + 
  scale_y_continuous(labels = comma) + 
  scale_fill_manual(values = colors)



## Heatmap visualization of day, hour and month
# Heatmap by Hour and Day
day_hour_data <- data %>% group_by(day, hour) %>% dplyr::summarize(Total = n())
# `summarise()` has grouped output by 'day'. You can override using the `.groups` argument.
datatable(day_hour_data)
#     day	hour	Total
# 1	  1 	0	    3247
# 2	  1	  1	    1982
# 3	  1	  2	    1284
# 4	  1	  3	    1331
# 5	  1	  4	    1458
# 6	  1	  5	    2171
# 7	  1	  6	    3717
# 8	  1	  7	    5470
# 9	  1	  8	    5376
# 10	1	  9	    4688


# Plot a Heatmap by Hour and Day
ggplot(day_hour_data, aes(day, hour, fill = Total)) + 
  geom_tile(color = "white") + 
  ggtitle("Heat Map by Hour and Day")


# Plot Heatmap by Day and Month
# Collect data by month and day
month_day_data <- data %>% group_by(month, day) %>% dplyr::summarize(Trips = n())
# `summarise()` has grouped output by 'month'. You can override using the `.groups` argument.
month_day_data
## A tibble: 183 × 3
## Groups:   month [6]
#    month day   Trips
# <ord> <fct> <int>
#   1 Apr   1     14546
#   2 Apr   2     17474
#   3 Apr   3     20701
#   4 Apr   4     26714
#   5 Apr   5     19521
#   6 Apr   6     13445
#   7 Apr   7     19550
#   8 Apr   8     16188
#   9 Apr   9     16843
#   10 Apr   10    20041
# # … with 173 more rows
# # ℹ Use `print(n = ...)` to see more rows


# Plot a heatmap by Collect data by month and day
ggplot(month_day_data, aes(day, month, fill = Trips)) + 
  geom_tile(color = "white") + 
  ggtitle("Heat Map by Month and Day")


# Plot a heatmap by day of the week and month
ggplot(day_month_data, aes(dayofweek, month, fill = Trips)) + 
  geom_tile(color = "white") + 
  ggtitle("Heat Map by Month and Day")


## Creating a map visualization of rides in NYC
# Set Map Constants
min_lat <- 40 
max_lat <- 40.91
min_long <- -74.15
max_long <- -73.7004

ggplot(data, aes(x=Lon, y=Lat)) +
  geom_point(size=1, color = "blue") +
  scale_x_continuous(limits=c(min_long, max_long)) +
  scale_y_continuous(limits=c(min_lat, max_lat)) +
  theme_map() +
   ggtitle("NYC MAP BASED ON UBER RIDES DURING 2014 (APR-SEP)")



ggplot(data, aes(x=Lon, y=Lat, color = Base)) +
  geom_point(size=1) +
  scale_x_continuous(limits=c(min_long, max_long)) +
  scale_y_continuous(limits=c(min_lat, max_lat)) +
  theme_map() +
  ggtitle("NYC MAP BASED ON UBER RIDES DURING 2014 (APR-SEP) by BASE")
