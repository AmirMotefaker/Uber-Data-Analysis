# Uber Data Analysis

### Importing the Essential Packages


```R
# install.packages("package_name") in R console
library(ggplot2)
# library(ggthemes)
library(lubridate)
library(dplyr)
library(tidyr)
library(DT)
library(scales)
```


```R
# Creating vector of colors for the plots
colors = c("#CC1011", "#665555", "#05a399", "#cfcaca", "#f5e840", "#0683c9", "#e075b0")
colors
```


<ol class=list-inline>
	<li>'#CC1011'</li>
	<li>'#665555'</li>
	<li>'#05a399'</li>
	<li>'#cfcaca'</li>
	<li>'#f5e840'</li>
	<li>'#0683c9'</li>
	<li>'#e075b0'</li>
</ol>




```R
# Read the data for each month separately 
apr <- read.csv("D:/AMIR/Programming/Data Science/R Projects/Uber Data Analysis/Dataset/uber-raw-data-apr14.csv")
may <- read.csv("D:/AMIR/Programming/Data Science/R Projects/Uber Data Analysis/Dataset/uber-raw-data-may14.csv")
june <- read.csv("D:/AMIR/Programming/Data Science/R Projects/Uber Data Analysis/Dataset/uber-raw-data-jun14.csv")
july <- read.csv("D:/AMIR/Programming/Data Science/R Projects/Uber Data Analysis/Dataset/uber-raw-data-jul14.csv")
aug <- read.csv("D:/AMIR/Programming/Data Science/R Projects/Uber Data Analysis/Dataset/uber-raw-data-aug14.csv")
sept <- read.csv("D:/AMIR/Programming/Data Science/R Projects/Uber Data Analysis/Dataset/uber-raw-data-sep14.csv")
```


```R
# Combine the data together 
data <- rbind(apr, may, june, july, aug, sept)
cat("The dimensions of the data are:", dim(data))
```

    The dimensions of the data are: 4534327 4


```R
# Print the first 6 rows of the data
head(data)
```


<table>
<thead><tr><th scope=col>Date.Time</th><th scope=col>Lat</th><th scope=col>Lon</th><th scope=col>Base</th></tr></thead>
<tbody>
	<tr><td>4/1/2014 0:11:00</td><td>40.7690         </td><td>-73.9549        </td><td>B02512          </td></tr>
	<tr><td>4/1/2014 0:17:00</td><td>40.7267         </td><td>-74.0345        </td><td>B02512          </td></tr>
	<tr><td>4/1/2014 0:21:00</td><td>40.7316         </td><td>-73.9873        </td><td>B02512          </td></tr>
	<tr><td>4/1/2014 0:28:00</td><td>40.7588         </td><td>-73.9776        </td><td>B02512          </td></tr>
	<tr><td>4/1/2014 0:33:00</td><td>40.7594         </td><td>-73.9722        </td><td>B02512          </td></tr>
	<tr><td>4/1/2014 0:33:00</td><td>40.7383         </td><td>-74.0403        </td><td>B02512          </td></tr>
</tbody>
</table>




```R
# Readable format for the DateTime
data$Date.Time <- as.POSIXct(data$Date.Time, format="%m/%d/%Y %H:%M:%S")
data$Time <- format(as.POSIXct(data$Date.Time, format = "%m/%d/%Y %H:%M:%S"), format="%H:%M:%S")
data$Date.Time <- ymd_hms(data$Date.Time)
head(data)
```


<table>
<thead><tr><th scope=col>Date.Time</th><th scope=col>Lat</th><th scope=col>Lon</th><th scope=col>Base</th><th scope=col>Time</th></tr></thead>
<tbody>
	<tr><td>2014-04-01 00:11:00</td><td>40.7690            </td><td>-73.9549           </td><td>B02512             </td><td>00:11:00           </td></tr>
	<tr><td>2014-04-01 00:17:00</td><td>40.7267            </td><td>-74.0345           </td><td>B02512             </td><td>00:17:00           </td></tr>
	<tr><td>2014-04-01 00:21:00</td><td>40.7316            </td><td>-73.9873           </td><td>B02512             </td><td>00:21:00           </td></tr>
	<tr><td>2014-04-01 00:28:00</td><td>40.7588            </td><td>-73.9776           </td><td>B02512             </td><td>00:28:00           </td></tr>
	<tr><td>2014-04-01 00:33:00</td><td>40.7594            </td><td>-73.9722           </td><td>B02512             </td><td>00:33:00           </td></tr>
	<tr><td>2014-04-01 00:33:00</td><td>40.7383            </td><td>-74.0403           </td><td>B02512             </td><td>00:33:00           </td></tr>
</tbody>
</table>




```R
# Create individual columns for month day and year
data$day <- factor(day(data$Date.Time))
data$month <- factor(month(data$Date.Time, label=TRUE))
data$year <- factor(year(data$Date.Time))
data$dayofweek <- factor(wday(data$Date.Time, label=TRUE))
head(data)
```


<table>
<thead><tr><th scope=col>Date.Time</th><th scope=col>Lat</th><th scope=col>Lon</th><th scope=col>Base</th><th scope=col>Time</th><th scope=col>day</th><th scope=col>month</th><th scope=col>year</th><th scope=col>dayofweek</th></tr></thead>
<tbody>
	<tr><td>2014-04-01 00:11:00</td><td>40.7690            </td><td>-73.9549           </td><td>B02512             </td><td>00:11:00           </td><td>1                  </td><td>Apr                </td><td>2014               </td><td>Tue                </td></tr>
	<tr><td>2014-04-01 00:17:00</td><td>40.7267            </td><td>-74.0345           </td><td>B02512             </td><td>00:17:00           </td><td>1                  </td><td>Apr                </td><td>2014               </td><td>Tue                </td></tr>
	<tr><td>2014-04-01 00:21:00</td><td>40.7316            </td><td>-73.9873           </td><td>B02512             </td><td>00:21:00           </td><td>1                  </td><td>Apr                </td><td>2014               </td><td>Tue                </td></tr>
	<tr><td>2014-04-01 00:28:00</td><td>40.7588            </td><td>-73.9776           </td><td>B02512             </td><td>00:28:00           </td><td>1                  </td><td>Apr                </td><td>2014               </td><td>Tue                </td></tr>
	<tr><td>2014-04-01 00:33:00</td><td>40.7594            </td><td>-73.9722           </td><td>B02512             </td><td>00:33:00           </td><td>1                  </td><td>Apr                </td><td>2014               </td><td>Tue                </td></tr>
	<tr><td>2014-04-01 00:33:00</td><td>40.7383            </td><td>-74.0403           </td><td>B02512             </td><td>00:33:00           </td><td>1                  </td><td>Apr                </td><td>2014               </td><td>Tue                </td></tr>
</tbody>
</table>


