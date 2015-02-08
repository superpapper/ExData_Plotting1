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
subdata$Global_reactive_power=as.numeric(subdata$Global_reactive_power)
subdata$Sub_metering_1=as.numeric(subdata$Sub_metering_1)
subdata$Sub_metering_2=as.numeric(subdata$Sub_metering_2)
subdata$Voltage=as.numeric(subdata$Voltage)

#plot the data-multi graphs
par(mfrow = c(2, 2))
with(subdata, {
  plot(new_time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
  plot(new_time, Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
  plot(new_time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(new_time, Sub_metering_2, col = "red")
  lines(new_time, Sub_metering_3, col = "blue")
  legend("topright", col = c("black", "red", "blue"), cex = 0.7, lty = 1, bty = "n",
         legend = c("Sub_metering_1", 
                    "Sub_metering_2",
                    "Sub_metering_3"))
  plot(new_time, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global Reactive Power")
})
dev.copy(png, file = "plot4.png")
dev.off()