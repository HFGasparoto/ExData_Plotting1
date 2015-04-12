# ExploExploratory Data Analysis Course Project 1 - Plot2
# Author: Henrique F. Gasparoto
# Date: 12/04/201

#load full data
EPC_Full <- read.table("household_power_consumption.txt",header = TRUE,sep = ";")
#convert first column to Date
EPC_Full[,1] <- as.Date(EPC_Full[,1],"%d/%m/%Y")
#create a subset by date interval
EPC_Sub <- subset(EPC_Full,Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
#frees memory
EPC_Full <- NA

#merge the two first columns and convert in a time type
EPC_Sub <- cbind(strptime(paste(EPC_Sub$Date,EPC_Sub$Time),format="%Y-%m-%d %H:%M:%S"),EPC_Sub[,3:9])
#change its name
names(EPC_Sub)[1] <- "Date_Time"

#check and convert the data type
if(class(EPC_Sub$Global_active_power) != "numeric"){
        EPC_Sub$Global_active_power <- type.convert(as.character(EPC_Sub$Global_active_power),na.strings = "?",dec = ".")
}

#set grid of plots
par(mfrow = c(1,1))
#create plot(s)
with(EPC_Sub,plot(Date_Time,Global_active_power,type = "l",xlab = "",ylab = "Global Active Power (kilowatts)"))

#copy plot(s) to a PNG file
dev.copy(png, file = "plot2.png")
#close the PNG device
dev.off()