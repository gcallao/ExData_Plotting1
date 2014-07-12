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

#Make the plot N°3
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

windows()
par(bg="transparent")
with(data,plot(datetime,Sub_metering_1,type="n", bg = "white", xlab ="", ylab="Energy sub metering"))
with(subset(data,Sub_metering_1>="0"),points(datetime,Sub_metering_1,type="l",col="black"))
with(subset(data,Sub_metering_2>="0"),points(datetime,Sub_metering_2,type="l",col="red"))
with(subset(data,Sub_metering_3>="0"),points(datetime,Sub_metering_3,type="l",col="blue"))
legend("topright",lty = 1,adj = 0.09, x.intersp=1.5, col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.copy(png,file = "plot3.png",width=480,height=480)
dev.off()