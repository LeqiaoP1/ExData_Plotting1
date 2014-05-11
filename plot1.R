# plot1.R
input_file <- "./household_power_consumption.txt"
output_png <- "./plot1.png"


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
# Plot1: Histogram of Global Active Power
hist(as.numeric(data$Global_active_power),
     col="red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

dev.off()
