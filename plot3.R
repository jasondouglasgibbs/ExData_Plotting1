## Plotting code for Plot 3 - Jason Gibbs##

####################################Libraries#########################################################
library(tidyverse)


####################################Data Reading and Cleaning#########################################
##Reads the data from the supplied .txt file into a DF##
dat<-read.table("household_power_consumption.txt", sep=";", header=TRUE)

##Checks column classes for the DF##
str(dat)

##Convert date column to class date##
dat$Date<-as.Date(dat$Date, format="%d/%m/%Y")

##Create Date/Time Column##
dat$DateTime<-as.POSIXct(as.character(paste(dat$Date, dat$Time)), format="%Y-%m-%d %H:%M:%S")

##Checks column classes for the DF after application of as.Date##
str(dat)

##Replace "?" with NAs and stores the number of NAs to a variable##
dat[,3:9][dat[,3:9]=="?"]<-NA
TotalNAs<-sum(is.na(dat))

##Filters only rows between 2007-02-01 and 2007-02-02 and creates a new DF using rbind##
TargetDat01<-dat%>%filter(Date=="2007-02-01")
TargetDat02<-dat%>%filter(Date=="2007-02-02")
TargetDat<-rbind(TargetDat01,TargetDat02)

##Assigning correct classes to columns##
TargetDat$Global_active_power<-as.numeric(TargetDat$Global_active_power)
TargetDat$Global_reactive_power<-as.numeric(TargetDat$Global_reactive_power)
TargetDat$Voltage<-as.numeric(TargetDat$Voltage)
TargetDat$Global_intensity<-as.numeric(TargetDat$Global_intensity)
TargetDat$Sub_metering_1<-as.numeric(TargetDat$Sub_metering_1)
TargetDat$Sub_metering_2<-as.numeric(TargetDat$Sub_metering_2)
TargetDat$Sub_metering_3<-as.numeric(TargetDat$Sub_metering_3)

####################################Plotting#######################################################

##Plot 3 - Plot of Sub meterings over time
png("plot3.png", width=480, height=480)
plot(y=TargetDat$Sub_metering_1, x=TargetDat$DateTime, type="l", ylab="Energy sub metering", xlab="")
lines(y=TargetDat$Sub_metering_2, x=TargetDat$DateTime, type="l", col="red")
lines(TargetDat$Sub_metering_3, x=TargetDat$DateTime, type="l", col="blue")
##lty=1 allows for the colored line to appear in the legend##
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"))
dev.off()
