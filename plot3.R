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
subdata$Sub_metering_1=as.numeric(subdata$Sub_metering_1)
subdata$Sub_metering_2=as.numeric(subdata$Sub_metering_2)




#plot the data- submeter vs time
par(mfrow = c(1, 1))
with(subdata, {
  plot(new_time, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(new_time, Sub_metering_2, col = "red")
  lines(new_time, Sub_metering_3, col = "blue")
  legend("topright", col = c("black", "red", "blue"), cex = 0.8, lty = 1,
         legend = c("Sub_metering_1", 
                    "Sub_metering_2",
                    "Sub_metering_3"))
  
})
dev.copy(png, file = "plot3.png")
dev.off()