##open URL and download file

fileURL<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, dest="dataset.zip") 
data<-unzip ("./dataset.zip", exdir = ".")
file <- read.table(data,header=T, sep=";", stringsAsFactors = F)

#subset data table to extract relevant data

rows1 <- filter(file, file$Date == "1/2/2007")
rows2 <- filter(file, file$Date == "2/2/2007")
subsetdata <- rbind(rows1, rows2)

## reformat colums to correct classes to allow plotting 

subsetdata$Date <- as.Date(subsetdata$Date, format = "%d/%m/%y")
class(subsetdata$Date)

subsetdata$Time <- strptime(subsetdata$Time, format = "%H:%M:%S" )
class(subsetdata$Time)

subsetdata$Global_active_power <- as.numeric(subsetdata$Global_active_power)


## Create plot and save as PNG file

png('plot1.png')
hist(subsetdata$Global_active_power, col = "Red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

