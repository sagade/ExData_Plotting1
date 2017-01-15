#' Read the data from Electric power consumption (UCI dataset) from 
#' https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#' supposed to be in the same folder as the script (textfile 'household_power_consumption.txt')
#' and a lineplot of the household global minute-averaged active power (in kilowatt) over time

#' Set local for english weekdays 
Sys.setlocale("LC_TIME","C")

#' Read in the data, NAs are coded as "?"
data_power <- read.csv2("household_power_consumption.txt", na.strings = "?", dec = ".")

#' Convert Date and Time columns
data_power$Time <- strptime(paste(data_power$Date, data_power$Time), format = "%d/%m/%Y %H:%M:%S")
data_power$Date <- as.Date(data_power$Date, format = "%d/%m/%Y")


#' Filter data to dates: 2007-02-01 and 2007-02-02
m <- data_power$Date >= "2007-02-01" & data_power$Date <= "2007-02-02" 
data_power <- data_power[m, ]


#' Create Histogram of gobal active power
#' and save to PNG plot2
png("plot2.png", width = 480, height = 480)
plot(data_power$Time, data_power$Global_active_power, 
     type = "l",
     col = "black", 
     main = "",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()
