# --------------------------------------------------------------------------------------------------
# File        : plot3.R
# Author      : Sendhil Kolandaivel (Sendhil.Kolandaivel@gmail.com)
# Date Created: 10/10/2015
# Description : Plot 3 - Sub Metering, Electric Power Consumption
# Data Source : https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# Details     : Assignment #1, Exploratory Data Analysis Coursera course
# ---------------------------------------------------------------------------------------------------

# Step 1: Read File & Load the Data
library(data.table)
data_file = "../household_power_consumption.txt"

# Using fread from data.table, as it is much faster
# Reads the 2,075,259 rows and 9 columns of data in 8 seconds!
dt <- fread(data_file, header = TRUE, sep = ";", na.strings = c("?",""))

# Subset the data to the two dates we need to plot
my_dt <- subset(dt, Date == "1/2/2007"| Date == "2/2/2007")

# Convert the Date and Time from Character to valid Date/Time formats
# Convert Date from Character to Date
my_dt$Date <- as.Date(my_dt$Date, format = "%d/%m/%Y") 

# Create a new column and concatenate the Date and Time values
my_dt$timetemp <- paste(my_dt$Date, my_dt$Time)  

# Convert the Data Table to Data Frame
# For some reason, strptime() does not work well with data tables
my_df <- as.data.frame(my_dt)

# Update the Time values using the strptime() function on the concatenated
# Date & Time Values
my_df$Time <- strptime(my_df$timetemp, format = "%Y-%m-%d %H:%M:%S") 

# -----------------------------------------------------------------------
# Step 2: Plot the Data
# ------------------------------------------------------------------------

png(
    filename = "plot3.png",
    width     = 480,
    height    = 480,
    units     = "px"
)

plot(x = my_df$Time, 
     y = my_df$Sub_metering_1, 
     type = "n", 
     xlab = "", 
     ylab = "Energy Sub Metering"
)

lines(x = my_df$Time, 
      y = my_df$Sub_metering_1, 
      type = "l", 
      col="black"
)
lines(x = my_df$Time, 
      y = my_df$Sub_metering_2, 
      type = "l", 
      col="Red"
)
lines(x = my_df$Time, 
      y = my_df$Sub_metering_3, 
      type = "l", 
      col="Blue"
)

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") , 
       col = c("black", "Red", "Blue"), 
       lty = 1, 
       border = "black")


dev.off()
