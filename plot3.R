

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


##PLOT 3
png(filename = "plot3.png",width = 480, height = 480)
plot(DataFeb$Date_Hour,DataFeb$Sub_metering_1  , type = "l",xlab="",ylab="Energy Sub metering")
points(DataFeb$Date_Hour,DataFeb$Sub_metering_2  , type = "l",xlab="",ylab="Sub metering",col = "red")
points(DataFeb$Date_Hour,DataFeb$Sub_metering_3  , type = "l",xlab="",ylab="Sub metering",col = "blue")
legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 2, col = c("black","red","blue"))   ##, cex = 0.7,y.intersp=0.5)
dev.off()



unlink(temporal)