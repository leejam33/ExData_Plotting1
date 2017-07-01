#Load the table
hpc <- read.table("household_power_consumption.txt",header = T,sep =";",na.strings = "?",colClasses = c(rep('character',2),rep('numeric',7)))

#Format date to first date column
hpc$Date <- as.Date(hpc$Date,"%d/%m/%Y")

#Filter data set from Feb.1 2007 to Feb.2,2007
hpc2d <- subset(hpc,Date >=as.Date('2007-2-1')& Date <= as.Date('2007-2-2'))

#Remove incomplete observation
hpc2d <-hpc2d[complete.cases(hpc2d),]


#Combine Date and time column
DT <-paste(hpc2d$Date,hpc2d$Time)
DT <-setNames(DT,"DateTime")
hpc2d <-hpc2d[,!(names(hpc2d) %in% c('Date','Time'))]
hpc2d <-cbind(DT,hpc2d)
hpc2d$DT <- as.POSIXct(DT)

#creat plot4.R data and copy to png device

par(mfrow = c(2,2))
plot(hpc2d$Global_active_power ~ hpc2d$DT, type = 'l',ylab='Global Active Power(kilowatts)',xlab='')
plot(hpc2d$Voltage ~ hpc2d$DT,type='l',ylab='Voltage(volt)',xlab='')
with(hpc2d,plot(Sub_metering_1 ~ DT, type = 'l',ylab = 'Energy sub metering',xlab=''))
lines(hpc2d$Sub_metering_2 ~ hpc2d$DT, col='red')
lines(hpc2d$Sub_metering_3 ~ hpc2d$DT, col='blue')
legend('topright',col=c('black','red','blue'),lty = 'solid',c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
plot(hpc2d$Global_reactive_power ~ hpc2d$DT, type='l',ylab='Global Reactive Power(kilowatte)',xlab='')
dev.copy(png,'plot4.png',width = 480, height = 480)
dev.off()