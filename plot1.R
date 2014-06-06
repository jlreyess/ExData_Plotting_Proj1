

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

##PLOT 1
png(filename = "plot1.png",width = 480, height = 480)
hist(as.numeric(DataFeb$Global_active_power),main="Global Active Power",col="red",xlab="Global Active Power (kilowatts)")
dev.off()

unlink(temporal)

