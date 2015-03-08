# read data
householdData <- read.table(file="household_power_consumption.txt", header=TRUE,sep = ";",  na.strings ="?")

# transform date column to a date datatype
householdData[,"Date"] <- as.Date(householdData[,"Date"], "%d/%m/%Y")

# filter out the right dates 
filteredData <- householdData[householdData$Date == as.Date("01/02/2007", "%d/%m/%Y") | householdData$Date == as.Date("02/02/2007", "%d/%m/%Y"), ]

# create a new datetime column from date and time columns
filteredData$Timestamp = as.POSIXct(paste(filteredData$Date, filteredData$Time))


# open output device
png(filename="plot4.png", width=480, height=480, units="px")

# create 4 panels as output
par(mfrow=c(2,2))

# add plot 1 to the toprleft corner
with(filteredData, plot(Timestamp, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

# add plot 2 to the topright corner
with(filteredData, plot(Timestamp, Voltage, type="l", xlab="datetime", ylab="Voltage"))

# add plot 3 to the bottom left corner with sub metering line 1
with(filteredData, plot(Timestamp, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black"))

# add sub metering line 2 to plot 3
with(filteredData, lines(Timestamp,Sub_metering_2,col="red"))

# add sub metering line 3 to plot 3
with(filteredData, lines(Timestamp,Sub_metering_3,col="blue"))

# add legend to plot 3
legend("topright", lty=1, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), bty="n")

# add plot 4 to the bottom right corner
with(filteredData, plot(Timestamp, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))

# close device
dev.off()