#Set the working directory in the unzipped data directory downloaded

#Load the entire dataset
data <- read.csv("./household_power_consumption.txt", sep=";" ,colClasses ="character")

#Give format to the Date variable
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")

#Subset the values of interest in the Date variable 
data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

#Setting the datetime variable
datetime <- paste(data$Date,data$Time) 
datetime <- strptime(datetime,format = "%Y-%m-%d %H:%M:%S")
data <- cbind(datetime,data)
rownames(data)=NULL

#Set the weekdays language
Sys.setlocale("LC_TIME", "English")

#Make the plot N°4
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Voltage <- as.numeric(data$Voltage)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)

windows()
par(mfrow = c(2,2),bg="transparent")
with(data,{
        plot(datetime,Global_active_power,type="l",xlab="",ylab="Global Active Power")
        plot(datetime,Voltage,type="l")
        with(data,plot(datetime,Sub_metering_1,type="n",xlab="",ylab="Energy sub metering"))
        with(subset(data,Sub_metering_1>=0),points(datetime,Sub_metering_1,type="l",col="black"))
        with(subset(data,Sub_metering_2>=0),points(datetime,Sub_metering_2,type="l",col="red"))
        with(subset(data,Sub_metering_3>=0),points(datetime,Sub_metering_3,type="l",col="blue"))
        legend("topright",bty = "n", adj = 0.12, x.intersp=1.5, lty=1,col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        plot(datetime,Global_reactive_power,type="l")
})

dev.copy(png,file = "plot4.png",width=480,height=480)
dev.off()