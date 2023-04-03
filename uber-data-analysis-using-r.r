{"metadata":{"kernelspec":{"name":"ir","display_name":"R","language":"R"},"language_info":{"name":"R","codemirror_mode":"r","pygments_lexer":"r","mimetype":"text/x-r-source","file_extension":".r","version":"4.0.5"}},"nbformat_minor":4,"nbformat":4,"cells":[{"source":"<a href=\"https://www.kaggle.com/code/amirmotefaker/uber-data-analysis-using-r?scriptVersionId=124462918\" target=\"_blank\"><img align=\"left\" alt=\"Kaggle\" title=\"Open in Kaggle\" src=\"https://kaggle.com/static/images/open-in-kaggle.svg\"></a>","metadata":{},"cell_type":"markdown"},{"cell_type":"markdown","source":"# Uber Data Analysis using R\n\n- With over 118 million users, 5 million drivers, and 6.3 billion trips with 17.4 million trips completed per day - Uber is the company behind the data for moving people and making deliveries hassle-free.\n- How are drivers assigned to riders cost-efficiently, and how is dynamic pricing leveraged to balance supply and demand? \n- Thanks to the large volumes of data Uber collects and the fantastic team that handles Uber Data Analysis using Machine Learning tools and frameworks. \n- If you’re curious to learn more about how data analysis is done at Uber to ensure positive experiences for riders while making the ride profitable for the company - Get your hands dirty working with the Uber dataset to gain in-depth insights.\n\n\n- Data storytelling is an important component of Machine Learning through which companies are able to understand the background of various operations. \n- With the help of visualization, companies can avail the benefit of understanding complex data and gaining insights that would help them to craft decisions. \n- This is more of a data visualization project that will guide you towards using the ggplot2 library for understanding the data and for developing an intuition for understanding the customers who avail the trips.\n\n- In this data analysis, we analyze Uber data from 1th April 2014 to 30th September 2014.\n\n- The goal of this project is to learn visualizations in R.\n\n- Dataset: [Kaggle](https://www.kaggle.com/datasets/amirmotefaker/uber-dataset-from-april-to-september-2014)","metadata":{}},{"cell_type":"markdown","source":"# Import Libraries","metadata":{}},{"cell_type":"code","source":"library(ggplot2)\nlibrary(ggthemes)\nlibrary(lubridate)\nlibrary(dplyr)\nlibrary(tidyr)\nlibrary(DT)\nlibrary(scales)\n#library(data.table) # Import big files (CSV or Text) \n#library(readxl) # Import Excel files","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:41.121201Z","iopub.execute_input":"2023-03-16T15:41:41.123339Z","iopub.status.idle":"2023-03-16T15:41:42.1033Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Creating vector of colors for the plots","metadata":{}},{"cell_type":"code","source":"colors = c(\"#CC1011\", \"#665555\", \"#05a399\", \"#cfcaca\", \"#f5e840\", \"#0683c9\", \"#e075b0\")\ncolors","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:42.106123Z","iopub.execute_input":"2023-03-16T15:41:42.1503Z","iopub.status.idle":"2023-03-16T15:41:42.175304Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Read the data for each month separately","metadata":{}},{"cell_type":"code","source":"apr <- read.csv(\"/kaggle/input/uber-dataset-from-april-to-september-2014/Uber-dataset/uber-raw-data-apr14.csv/uber-raw-data-apr14.csv\")\nmay <- read.csv(\"/kaggle/input/uber-dataset-from-april-to-september-2014/Uber-dataset/uber-raw-data-may14.csv/uber-raw-data-may14.csv\")\njune <- read.csv(\"/kaggle/input/uber-dataset-from-april-to-september-2014/Uber-dataset/uber-raw-data-jun14.csv/uber-raw-data-jun14.csv\")\njuly <- read.csv(\"/kaggle/input/uber-dataset-from-april-to-september-2014/Uber-dataset/uber-raw-data-jul14.csv/uber-raw-data-jul14.csv\")\naug <- read.csv(\"/kaggle/input/uber-dataset-from-april-to-september-2014/Uber-dataset/uber-raw-data-aug14.csv/uber-raw-data-aug14.csv\")\nsept <- read.csv(\"/kaggle/input/uber-dataset-from-april-to-september-2014/Uber-dataset/uber-raw-data-sep14.csv/uber-raw-data-sep14.csv\")\n","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:42.178251Z","iopub.execute_input":"2023-03-16T15:41:42.180582Z","iopub.status.idle":"2023-03-16T15:41:58.117676Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Combine the data together","metadata":{}},{"cell_type":"code","source":"data <- rbind(apr, may, june, july, aug, sept)\ncat(\"The dimensions of the data are:\", dim(data))","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:58.122427Z","iopub.execute_input":"2023-03-16T15:41:58.124489Z","iopub.status.idle":"2023-03-16T15:41:59.905406Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Print the first 6 rows of the data","metadata":{}},{"cell_type":"code","source":"head(data)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:59.907983Z","iopub.execute_input":"2023-03-16T15:41:59.909556Z","iopub.status.idle":"2023-03-16T15:41:59.936791Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Readable format for the DateTime","metadata":{}},{"cell_type":"code","source":"data$Date.Time <- as.POSIXct(data$Date.Time, format=\"%m/%d/%Y %H:%M:%S\")\ndata$Time <- format(as.POSIXct(data$Date.Time, format = \"%m/%d/%Y %H:%M:%S\"), format=\"%H:%M:%S\")\ndata$Date.Time <- ymd_hms(data$Date.Time)\nhead(data)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:41:59.940272Z","iopub.execute_input":"2023-03-16T15:41:59.942231Z","iopub.status.idle":"2023-03-16T15:42:28.594915Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Create individual columns for month day and year","metadata":{}},{"cell_type":"code","source":"data$day <- factor(day(data$Date.Time))\ndata$month <- factor(month(data$Date.Time, label=TRUE))\ndata$year <- factor(year(data$Date.Time))\ndata$dayofweek <- factor(wday(data$Date.Time, label=TRUE))\nhead(data)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:28.598716Z","iopub.execute_input":"2023-03-16T15:42:28.600691Z","iopub.status.idle":"2023-03-16T15:42:43.865944Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Add Time variables as well ","metadata":{}},{"cell_type":"code","source":"data$second = factor(second(hms(data$Time)))\ndata$minute = factor(minute(hms(data$Time)))\ndata$hour = factor(hour(hms(data$Time)))\nhead(data)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:43.868765Z","iopub.execute_input":"2023-03-16T15:42:43.87028Z","iopub.status.idle":"2023-03-16T15:42:59.184618Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Data Visualisation","metadata":{}},{"cell_type":"markdown","source":"## Plotting the trips by hours in a day","metadata":{}},{"cell_type":"code","source":"hourly_data <- data %>% \n  group_by(hour) %>% \n  dplyr::summarize(Total = n())","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:59.187587Z","iopub.execute_input":"2023-03-16T15:42:59.189198Z","iopub.status.idle":"2023-03-16T15:42:59.322301Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Show data in a searchable js table","metadata":{}},{"cell_type":"code","source":"datatable(hourly_data)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:59.326176Z","iopub.execute_input":"2023-03-16T15:42:59.328116Z","iopub.status.idle":"2023-03-16T15:42:59.617736Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Plot the data by hour","metadata":{}},{"cell_type":"code","source":"ggplot(hourly_data, aes(hour, Total)) + \n  geom_bar(stat=\"identity\", \n           fill=\"steelblue\", \n           color=\"red\") + \n  ggtitle(\"Trips Every Hour\", subtitle = \"aggregated today\") + \n  theme(legend.position = \"none\", \n        plot.title = element_text(hjust = 0.5), \n        plot.subtitle = element_text(hjust = 0.5)) + \n  scale_y_continuous(labels=comma)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:42:59.620137Z","iopub.execute_input":"2023-03-16T15:42:59.621679Z","iopub.status.idle":"2023-03-16T15:43:00.258729Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Plotting trips by hour and month","metadata":{}},{"cell_type":"code","source":"# Aggregate the data by month and hour\nmonth_hour_data <- data %>% group_by(month, hour) %>%  dplyr::summarize(Total = n())\n\nggplot(month_hour_data, aes(hour, Total, fill=month)) + \n  geom_bar(stat = \"identity\") + \n  ggtitle(\"Trips by Hour and Month\") + \n  scale_y_continuous(labels = comma)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:43:00.262709Z","iopub.execute_input":"2023-03-16T15:43:00.264725Z","iopub.status.idle":"2023-03-16T15:43:01.095004Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Plotting data by trips during every day of the month","metadata":{}},{"cell_type":"code","source":"# Aggregate data by day of the month \nday_data <- data %>% group_by(day) %>% dplyr::summarize(Trips = n())\nday_data","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:43:01.097597Z","iopub.execute_input":"2023-03-16T15:43:01.099117Z","iopub.status.idle":"2023-03-16T15:43:01.228945Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Plot the data for the day","metadata":{}},{"cell_type":"code","source":"ggplot(day_data, aes(day, Trips)) + \n  geom_bar(stat = \"identity\", fill = \"steelblue\") +\n  ggtitle(\"Trips by day of the month\") + \n  theme(legend.position = \"none\") + \n  scale_y_continuous(labels = comma)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:43:01.231311Z","iopub.execute_input":"2023-03-16T15:43:01.232777Z","iopub.status.idle":"2023-03-16T15:43:01.47392Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# Collect data by day of the week and month\nday_month_data <- data %>% group_by(dayofweek, month) %>% dplyr::summarize(Trips = n())\n\nday_month_data","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:43:01.476231Z","iopub.execute_input":"2023-03-16T15:43:01.477684Z","iopub.status.idle":"2023-03-16T15:43:01.693541Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Plot the Collect data by day of the week and month","metadata":{}},{"cell_type":"code","source":"ggplot(day_month_data, aes(dayofweek, Trips, fill = month)) + \n  geom_bar(stat = \"identity\", aes(fill = month), position = \"dodge\") + \n  ggtitle(\"Trias by Day and Month\") + \n  scale_y_continuous(labels = comma) + \n  scale_fill_manual(values = colors)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:43:01.69593Z","iopub.execute_input":"2023-03-16T15:43:01.697519Z","iopub.status.idle":"2023-03-16T15:43:02.104817Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"# Number of Trips place during months in a year\nmonth_data <- data %>% group_by(month) %>% dplyr::summarize(Total = n())\n\nmonth_data","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:43:02.107161Z","iopub.execute_input":"2023-03-16T15:43:02.108572Z","iopub.status.idle":"2023-03-16T15:43:02.347158Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Plot the Number of Trips place during months in a year\n","metadata":{}},{"cell_type":"code","source":"ggplot(month_data, aes(month, Total, fill = month)) + \n  geom_bar(stat = \"Identity\") + \n  ggtitle(\"Trips in a month\") + \n  theme(legend.position = \"none\") + \n  scale_y_continuous(labels = comma) + \n  scale_fill_manual(values = colors)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:43:02.349798Z","iopub.execute_input":"2023-03-16T15:43:02.351331Z","iopub.status.idle":"2023-03-16T15:43:02.573395Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Heatmap visualization of day, hour and month","metadata":{}},{"cell_type":"markdown","source":"## Heatmap by Hour and Day","metadata":{}},{"cell_type":"code","source":"day_hour_data <- data %>% group_by(day, hour) %>% dplyr::summarize(Total = n())\n\ndatatable(day_hour_data)","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:43:02.575734Z","iopub.execute_input":"2023-03-16T15:43:02.577315Z","iopub.status.idle":"2023-03-16T15:43:02.890859Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Plot a Heatmap by Hour and Day","metadata":{}},{"cell_type":"code","source":"ggplot(day_hour_data, aes(day, hour, fill = Total)) + \n  geom_tile(color = \"white\") + \n  ggtitle(\"Heat Map by Hour and Day\")","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:43:02.89326Z","iopub.execute_input":"2023-03-16T15:43:02.894723Z","iopub.status.idle":"2023-03-16T15:43:03.206191Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Plot Heatmap by Day and Month","metadata":{}},{"cell_type":"code","source":"# Collect data by month and day\nmonth_day_data <- data %>% group_by(month, day) %>% dplyr::summarize(Trips = n())\n\nmonth_day_data","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:43:03.208739Z","iopub.execute_input":"2023-03-16T15:43:03.210294Z","iopub.status.idle":"2023-03-16T15:43:03.477092Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Plot a heatmap by Collect data by month and day","metadata":{}},{"cell_type":"code","source":"ggplot(month_day_data, aes(day, month, fill = Trips)) + \n  geom_tile(color = \"white\") + \n  ggtitle(\"Heat Map by Month and Day\")","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:43:03.4795Z","iopub.execute_input":"2023-03-16T15:43:03.48094Z","iopub.status.idle":"2023-03-16T15:43:03.771871Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"## Plot a heatmap by day of the week and month","metadata":{}},{"cell_type":"code","source":"ggplot(day_month_data, aes(dayofweek, month, fill = Trips)) + \n  geom_tile(color = \"white\") + \n  ggtitle(\"Heat Map by Month and Day\")","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:43:03.774306Z","iopub.execute_input":"2023-03-16T15:43:03.775762Z","iopub.status.idle":"2023-03-16T15:43:04.044845Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"markdown","source":"# Creating a map visualization of rides in NYC","metadata":{}},{"cell_type":"code","source":"# Set Map Constants\nmin_lat <- 40 \nmax_lat <- 40.91\nmin_long <- -74.15\nmax_long <- -73.7004\n\nggplot(data, aes(x=Lon, y=Lat)) +\n  geom_point(size=1, color = \"blue\") +\n  scale_x_continuous(limits=c(min_long, max_long)) +\n  scale_y_continuous(limits=c(min_lat, max_lat)) +\n  theme_map() +\n  ggtitle(\"NYC MAP BASED ON UBER RIDES DURING 2014 (APR-SEP)\")","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:43:04.047204Z","iopub.execute_input":"2023-03-16T15:43:04.048575Z","iopub.status.idle":"2023-03-16T15:46:19.042707Z"},"trusted":true},"execution_count":null,"outputs":[]},{"cell_type":"code","source":"min_lat <- 40.5774\nmax_lat <- 40.9176\nmin_long <- -74.15\nmax_long <- -73.7004\n\nggplot(data, aes(x=Lon, y=Lat, color = Base)) +\n    geom_point(size=1) +\n    scale_x_continuous(limits=c(min_long, max_long)) +\n    scale_y_continuous(limits=c(min_lat, max_lat)) +\n    theme_map() +\n    ggtitle(\"NYC MAP BASED ON UBER RIDES DURING 2014 (APR-SEP) by BASE\")","metadata":{"execution":{"iopub.status.busy":"2023-03-16T15:46:19.045077Z","iopub.execute_input":"2023-03-16T15:46:19.046432Z","iopub.status.idle":"2023-03-16T15:49:35.63442Z"},"trusted":true},"execution_count":null,"outputs":[]}]}