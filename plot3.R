# ExploExploratory Data Analysis Course Project 1 - Plot3
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
if(class(EPC_Sub$Sub_metering_1) != "numeric"){
        EPC_Sub$Sub_metering_1 <- type.convert(as.character(EPC_Sub$Sub_metering_1),na.strings = "?",dec = ".")
}
if(class(EPC_Sub$Sub_metering_2) != "numeric"){
        EPC_Sub$Sub_metering_2 <- type.convert(as.character(EPC_Sub$Sub_metering_2),na.strings = "?",dec = ".")
}
if(class(EPC_Sub$Sub_metering_3) != "numeric"){
        EPC_Sub$Sub_metering_3 <- type.convert(as.character(EPC_Sub$Sub_metering_3),na.strings = "?",dec = ".")
}

#create png file device
png(file = "plot3.png", width = 480, height = 480, units = "px")

#set grid of plots
par(mfrow = c(1,1))
#create plot(s)
with(EPC_Sub,plot(Date_Time,Sub_metering_1,type = "n",xlab = "",ylab = "Energy sub metering"))
with(EPC_Sub,lines(Date_Time,Sub_metering_1,type = "l",xlab = "",col = "black"))
with(EPC_Sub,lines(Date_Time,Sub_metering_2,type = "l",xlab = "",col = "red"))
with(EPC_Sub,lines(Date_Time,Sub_metering_3,type = "l",xlab = "",col = "blue"))
legend("topright",lty = c(1,1,1),col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
     
#close the PNG device
dev.off()