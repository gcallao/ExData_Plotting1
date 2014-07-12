#Set the working directory in the unzipped data directory downloaded

#Load the entire dataset
data <- read.csv("./household_power_consumption.txt", sep=";" ,colClasses ="character")

#Give format to the Date variable
data$Date <- as.Date(data$Date,format = "%d/%m/%Y")

#Subset the values of interest in the Date variable 
data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
rownames(data)=NULL

#Make the plot N°1
data$Global_active_power <- as.numeric(data$Global_active_power) 

windows()
par(bg="transparent")
hist(data$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)",col = "red")

dev.copy(png,file = "plot1.png",width=480,height=480)
dev.off()