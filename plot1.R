# read data
householdData <- read.table(file="household_power_consumption.txt", header=TRUE,sep = ";",  na.strings ="?")

# transform date column to a date datatype
householdData[,"Date"] <- as.Date(householdData[,"Date"], "%d/%m/%Y")

# filter out the right dates 
filteredData <- householdData[householdData$Date == as.Date("01/02/2007", "%d/%m/%Y") | householdData$Date == as.Date("02/02/2007", "%d/%m/%Y"), ]
    

# open output device
png(filename="plot1.png", width=480, height=480, units="px")

# Create one panel as output
par(mfrow=c(1,1))

# create histogram with title and x and y labels
hist(filteredData$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")

# Turn off device
dev.off()