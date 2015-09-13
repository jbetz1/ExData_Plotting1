#Exploratory Data Analysis Project 1, Plot 3
#Jordan Betz
#September 13, 2015

#Assumption: Working directory contains household_power_consumption.txt.

#Read all the data into a data frame.  The argument "as.is = TRUE" avoids
#the issues with Date and Time being read in as factors.
allPowerData <- read.delim("household_power_consumption.txt", sep = ";",
                           as.is = TRUE, na.strings = "?")

#Subset the data to include only February 1st and 2nd, 2007.
powerData <- rbind(subset(allPowerData, Date == "1/2/2007"),
                   subset(allPowerData, Date == "2/2/2007"))

#Combine the Date and Time columns into a datetime column.
powerData <- cbind(datetime = strptime(paste(powerData$Date, powerData$Time),
                            format = "%d/%m/%Y %H:%M:%S"),
                   powerData[, 3:length(powerData)])

#Create a 2x2 grid of plots in a PNG file.
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))

#Plot the Global Active Power as a line plot.
plot(powerData$datetime, powerData$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")

#Plot the voltage as a line plot.
plot(powerData$datetime, powerData$Voltage, type = "l", xlab = "datetime",
     ylab = "Voltage", col = "black")

#Plot the energy subsystem metering as a line plot.
plot(powerData$datetime, powerData$Sub_metering_1, type = "n", 
     xlab = "", ylab = "Energy sub metering")
points(powerData$datetime, powerData$Sub_metering_1,
       col = "black", type = "l")
points(powerData$datetime, powerData$Sub_metering_2,
       col = "red", type = "l")
points(powerData$datetime, powerData$Sub_metering_3,
       col = "blue", type = "l")
legend("topright", col = c("black", "red", "blue"), 
       legend = names(powerData[6:8]), bty = "n")

#Plot the global reactive power as a line plot.
plot(powerData$datetime, powerData$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power", col = "black")

#Write the plot to the file and close the device.
dev.off()
