

## First step is to download the file into a temporal file. Because the file is in .zip, I use the
## function unz() to unzip the file.
## another trasformation made is change Date and Time to "Date Format" with the function strptime()

temporal <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temporal)
Data <- read.table(unz(temporal,"household_power_consumption.txt"),sep = ";", header = TRUE,stringsAsFactors=F)
DataFeb <- subset(Data,Data[1] == "1/2/2007" | Data[1] == "2/2/2007")
DataFeb$Date_Hour <- paste(DataFeb$Date,DataFeb$Time, sep = " ")
#DataFeb$Date <- strptime(DataFeb$Date, "%d/%m/%Y")
DataFeb$Date_Hour <- strptime(DataFeb$Date_Hour, "%d/%m/%Y %H:%M:%S")

## To construct the plots, first I open the png device, in order to save the plot in a png file
## some plots may need several instructions that modify the plot.

##PLOT 4
png(filename = "plot4.png",width = 480, height = 480)
par(mfcol=c(2,2))
plot(DataFeb$Date_Hour,DataFeb$Global_active_power, type = "l",xlab="",ylab="Global Active Power")
plot(DataFeb$Date_Hour,DataFeb$Sub_metering_1  , type = "l",xlab="",ylab="Energy Sub metering")
points(DataFeb$Date_Hour,DataFeb$Sub_metering_2  , type = "l",xlab="",ylab="Sub metering",col = "red")
points(DataFeb$Date_Hour,DataFeb$Sub_metering_3  , type = "l",xlab="",ylab="Sub metering",col = "blue")
legend("topright",legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"),bty="n" ,lwd = 2, col = c("black","red","blue"))  ##, cex = 0.2,y.intersp=0.1)
plot(DataFeb$Date_Hour,DataFeb$Voltage  , type = "l",xlab="datetime",ylab="Voltage")
plot(DataFeb$Date_Hour,DataFeb$Global_reactive_power  , type = "l",xlab="datetime",ylab="Global_reactive_power")
dev.off()


unlink(temporal)