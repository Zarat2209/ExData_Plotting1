##open URL and download file

fileURL<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, dest="dataset.zip") 
data<-unzip ("./dataset.zip", exdir = ".")
file <- read.table(data,header=T, sep=";", stringsAsFactors = F)

#subset data table to extract relevant data

library(dplyr)
rows1 <- filter(file, file$Date == "1/2/2007")
rows2 <- filter(file, file$Date == "2/2/2007")
subsetdata <- rbind(rows1, rows2)

## Reformat colums to correct classes to allow plotting 


subsetdata$Global_active_power <- as.numeric(subsetdata$Global_active_power)
subsetdata$Global_reactive_power <- as.numeric(subsetdata$Global_reactive_power)
subsetdata$Sub_metering_1 <- as.numeric(subsetdata$Sub_metering_1)
subsetdata$Sub_metering_2 <- as.numeric(subsetdata$Sub_metering_2)
subsetdata$Sub_metering_3 <- as.numeric(subsetdata$Sub_metering_3)

#### Transform date to Date format and create new variable with Date and Time joined

datetime <- strptime(paste(subsetdata$Date, subsetdata$Time, sep=" "),format =  "%d/%m/%Y %H:%M:%S")
subsetdata<-cbind(subsetdata, "DateTime" = datetime)


## Create plot and save as PNG file

png('plot4.png')

par(mfrow=c(2,2))

hist(subsetdata$Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

plot(subsetdata$Global_active_power ~ subsetdata$DateTime, type="l", xlab= "", ylab="Global Active Power (kilowatts)")

plot(subsetdata$Sub_metering_1 ~ subsetdata$DateTime, type= "l", col = "Black", xlab = " ", ylab = "Energy sub metering")
lines(subsetdata$Sub_metering_2 ~ subsetdata$DateTime, type= "l", col = "Red")
lines(subsetdata$Sub_metering_3 ~ subsetdata$DateTime, type= "l", col = "Blue")
legend("topright", c("Sub_metering_1" , "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), lwd=c(2.5,2.5,2.5),col=c("Black","Red","Blue"))

plot(subsetdata$Global_reactive_power ~ subsetdata$DateTime, type= "l", col = "Black", ylab = "Global_reactive_power", xlab = "date/time")

dev.off()

