# plot3.R
input_file <- "./household_power_consumption.txt"
output_png <- "./plot3.png"


## Read data
col_classes = c("character", "character", rep("numeric",7))
data <- read.table(input_file, sep=";", header=T, na.strings="?",
                   colClasses = col_classes)



## Convert two char strings into one real date+time
data$DateTime <- as.POSIXct(strptime(paste(data$Date, data$Time), 
                                     format = "%d/%m/%Y %H:%M:%S"))


## Subset between two given days
data <- subset(data, DateTime >= as.POSIXct("2007-02-01") &
                   DateTime <= as.POSIXct("2007-02-03"))

## Create png file
png(output_png, height=480, width=480)


#------------------------------------------------------------------------#
# Plot3: Global Active Power vs Time
plot(data$DateTime,
     as.numeric(data$Sub_metering_1),
     pch=NA,
     xlab="",
     ylab="Energy sub metering")

## Add lines
lines(data$DateTime, as.numeric(data$Sub_metering_1))
lines(data$DateTime, as.numeric(data$Sub_metering_2), col="red")
lines(data$DateTime, as.numeric(data$Sub_metering_3), col="blue")

## Add summaries
legend('topright',
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1),
       col = c("black", "red", "blue"))

dev.off()