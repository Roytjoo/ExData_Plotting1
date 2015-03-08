# read data
householdData <- read.table(file="household_power_consumption.txt", header=TRUE,sep = ";",  na.strings ="?")

# transform date column to a date datatype
householdData[,"Date"] <- as.Date(householdData[,"Date"], "%d/%m/%Y")

# filter out the right dates 
filteredData <- householdData[householdData$Date == as.Date("01/02/2007", "%d/%m/%Y") | householdData$Date == as.Date("02/02/2007", "%d/%m/%Y"), ]

# create a new datetime column from date and time columns
filteredData$Timestamp = as.POSIXct(paste(filteredData$Date, filteredData$Time))


# open output device
png(filename="plot2.png", width=480, height=480, units="px")

# Create one panel as output
par(mfrow=c(1,1))

# create line plot
with(filteredData, plot(Timestamp, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

# close device
dev.off()