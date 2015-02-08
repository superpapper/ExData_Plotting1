library(data.table)


#create data folder
if (!file.exists("data")) {dir.create("data")}

#download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "./data/power_consumption.zip"
download.file(fileUrl, destfile)
dateDownloaded <- date()


#read in data and subset data
data<-fread("./data/household_power_consumption.txt",sep=";",stringsAsFactors=False)
subdata<-subset(data,Date=="1/2/2007"|Date=="2/2/2007")
subdata$new_time <- as.POSIXct(paste(subdata$Date, subdata$Time), format = "%d/%m/%Y %T")
subdata$Global_active_power=as.numeric(subdata$Global_active_power)

#plot the data-Global active power vs time
par(mfrow = c(1, 1))
plot(subdata$new_time, subdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)" )
dev.copy(png, file = "plot2.png")
dev.off()