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

#creat histogram polt1.R data and copy to png device 
hist(hpc2d$Global_active_power,main = 'Global Active Power',xlab ='Global Active Power (kilowatts)',col = 'red')
dev.copy(png,'plot1.png',width = 480, height = 480)
dev.off()