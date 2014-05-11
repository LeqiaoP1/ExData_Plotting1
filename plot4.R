# plot4.R
input_file <- "./household_power_consumption.txt"
output_png <- "./plot4.png"


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
# Plot4 - Multiplot
## Configure
par(mfrow=c(2,2))

## Global Active Power plot
plot(data$DateTime,
     as.numeric(data$Global_active_power),
     pch=NA,
     xlab="",
     ylab="Global Active Power (kilowatts)")

## Add line
lines(data$DateTime, as.numeric(data$Global_active_power))


## Plot Voltage
plot(data$DateTime, 
     as.numeric(data$Voltage), 
     pch=NA,
     xlab="datetime",
     ylab="Voltage")

## Draw the line
lines(data$DateTime, as.numeric(data$Voltage))

## Sub metering plot
plot(data$DateTime,
     as.numeric(data$Sub_metering_1),
     pch=NA,
     xlab="",
     ylab="Energy sub metering")

## Draw the lines
lines(data$DateTime, as.numeric(data$Sub_metering_1))
lines(data$DateTime, as.numeric(data$Sub_metering_2), col="red")
lines(data$DateTime, as.numeric(data$Sub_metering_3), col="blue")

## Draw the summary
legend('topright',
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1),
       col = c("black", "red", "blue"),
       bty = 'n')

## Global reactive power plot
with(data, plot(DateTime, Global_reactive_power, xlab="datetime", pch=NA))
with(data, lines(DateTime, Global_reactive_power))

dev.off()