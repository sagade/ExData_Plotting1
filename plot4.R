#' Read the data from Electric power consumption (UCI dataset) from 
#' https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#' supposed to be in the same folder as the script (textfile 'household_power_consumption.txt')
#' and a multi plot with 4 subplots summarizing the data

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
#' and save to PNG plot4
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# plot 1: global active power over time
plot(data_power$Time, data_power$Global_active_power, 
     type = "l",
     col = "black", 
     main = "",
     xlab = "",
     ylab = "Global Active Power")

# plot 2: voltage over time 
plot(data_power$Time, data_power$Voltage, 
     type = "l",
     col = "black", 
     main = "",
     xlab = "datetime",
     ylab = "Voltage")

# plot 3: submitering over time
with(data_power, plot(Time, Sub_metering_1, 
                      type = "l",
                      col = "black", 
                      main = "",
                      xlab = "",
                      ylab = "Energy sub metering"))
with(data_power, lines(Time, Sub_metering_2, col = "red"))
with(data_power, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

# plot 4: Global reactive power over time
plot(data_power$Time, data_power$Global_reactive_power, 
     type = "l",
     col = "black", 
     main = "",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()
