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
png(file = "plot1.png", width = 480, height = 480, units = "px") 
## Create plot and send to a file
par(bg = "transparent")
hist(sub.data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off() ## Close the PNG file device