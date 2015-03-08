# read data
householdData <- read.table(file="household_power_consumption.txt", header=TRUE,sep = ";",  na.strings ="?")

# transform date column to a date datatype
householdData[,"Date"] <- as.Date(householdData[,"Date"], "%d/%m/%Y")

# filter out the right dates 
filteredData <- householdData[householdData$Date == as.Date("01/02/2007", "%d/%m/%Y") | householdData$Date == as.Date("02/02/2007", "%d/%m/%Y"), ]

# create a new datetime column from date and time columns
filteredData$Timestamp = as.POSIXct(paste(filteredData$Date, filteredData$Time))


# open device
png(filename="plot3.png", width=480, height=480, units="px")

# Create one panel as output
par(mfrow=c(1,1))

# create plot with sub metering line 1
with(filteredData, plot(Timestamp, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col="black"))

# add sub metering line 2 as red
with(filteredData, lines(Timestamp,Sub_metering_2,col="red"))

# add sub metering line 3 as blue
with(filteredData, lines(Timestamp,Sub_metering_3,col="blue"))

# add legend to the plot
legend("topright", lty=1, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"))

# close device
dev.off()