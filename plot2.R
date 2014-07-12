#Set the working directory in the unzipped data directory downloaded

#Load the entire dataset
data <- read.csv("./household_power_consumption.txt", sep=";" ,colClasses ="character")

#Give format to the Date variable
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")

#Subset the values of interest in the Date variable 
data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

#Set the datetime variable
datetime <- paste(data$Date,data$Time) 
datetime <- strptime(datetime,format = "%Y-%m-%d %H:%M:%S")
data <- cbind(datetime,data)
rownames(data)=NULL

#Set the weekdays language
Sys.setlocale("LC_TIME", "English")

#Make the plot N°2
data$Global_active_power <- as.numeric(data$Global_active_power)

windows()
par(bg="transparent")
with(data,plot(datetime,Global_active_power, type ="l", xlab = "", ylab ="Global Active Power (kilowatts)"))

dev.copy(png,"plot2.png",width=480,height=480)
dev.off()