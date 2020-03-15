#code to create a plot of minute averaged household electrical power consumption

# create destination directory to download data from UC Irvine machine learning 
#repository
if(!file.exists("HouseholdPowerConsumption")){
  dir.create("./HouseholdPowerConsumption")
}

#download the data from UC Irvine machine learning repository
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile="./household_power_consumption.zip",method="curl")
get
#unzip the file
unzip("household_power_consumption.zip")

# read the data and store in variable: data
data<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?")

#combine Date and Time columns to create a date/time variable of class Date/time
DateTime<-paste(data$Date,data$Time)
data<-cbind(DateTime, data[,3:9])
data$DateTime<-strptime(data$DateTime, format="%d/%m/%Y %H:%M:%S")

# subset data from the dates 2007-02-01-2007-02-02
subsetData<-subset(data, data$DateTime>="2007-02-01 00:00:00" & data$DateTime<="2007-02-02 24:00:00")

#create a PNG file and set graphical parameter to display 4 plots in one graph
png("plot4.png", height=480, width=480)
par(mfrow=c(2,2))
with(subsetData,plot(DateTime, Global_active_power, ylab="Global active power",type="l", xlab="", col="black"))
with(subsetData,plot(DateTime, Voltage, ylab="Voltage",type="l", xlab="datetime", col="black"))
with(subsetData, plot(DateTime, Sub_metering_1, type="l", col="black", ylab="Energy sub metering"))
points(subsetData$DateTime, subsetData$Sub_metering_2, type="l", col="red")
points(subsetData$DateTime, subsetData$Sub_metering_3, type="l", col="blue")
legend("topright",col=c("black","red", "blue"), pch="---", legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
with(subsetData, plot(DateTime, Global_reactive_power, type="l"))
dev.off()