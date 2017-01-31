## Plot 1 - Frequency - Global Active Power

## Read data
tot.data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = "character")
tot.data[,1] <- as.Date(tot.data[,1], "%d/%m/%Y")

## Extract desired subsets. Use date as character string to reduce workload
sub.data <- subset(tot.data, tot.data[,1] == "2007-02-01" | tot.data[,1] == "2007-02-02")

## Transform date/time/numeric columns to desired format
sub.data[,10] <- as.POSIXct(paste(sub.data[,1],sub.data[,2], format = "%d/%m/%Y %H:%M:%S"))
colnames(sub.data)[10] <- "Merged_date"
for(i in 3:9){
        sub.data[,i] <- as.numeric(sub.data[,i])
}

## Plotting
## Open PNG device, create file
png(file = "plot4.png", width = 480, height = 480, units = "px") 
## Create plots and send to a file
## Create 2x2 plotting region
par(mfrow = c(2,2), bg = "transparent")
## Create plot 1 (top, left)
plot(sub.data$Merged_date, sub.data$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
## Create plot 2 (top, right)
plot(sub.data$Merged_date, sub.data$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
## Create plot 3 (bottom, left)
plot(sub.data$Merged_date, sub.data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(sub.data$Merged_date, sub.data$Sub_metering_2, col = "red")
lines(sub.data$Merged_date, sub.data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1, 1, 1), bty = "n")
## Create plot 4 (bottom, right)
plot(sub.data$Merged_date, sub.data$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
dev.off() ## Close the PNG file device