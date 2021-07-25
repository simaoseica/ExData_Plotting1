# Download the zip file that contains the data set
data_url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
zip_file <- 'dataset.zip'

download.file(data_url, destfile = zip_file, method = 'curl')
unzip(zip_file)


# Load data set to memory
power_consumption <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
#str(power_consumption)

# Cast power_consumption$Date to Date
power_consumption$Date <- as.Date(power_consumption$Date, format="%d/%m/%Y")
# Subset data from first two days of February 2007
consumption_february <- power_consumption[(power_consumption$Date=="2007-02-01") | (power_consumption$Date=="2007-02-02"),]
#Add new column with timestamp info
consumption_february <- transform(consumption_february, timestamp=as.POSIXct(paste(consumption_february$Date, consumption_february$Time)), "%d/%m/%Y %H:%M:%S")
#summary(consumption_february)

# Generate Plot with continuous lines, for 3 different vars with legend
plot(consumption_february$timestamp, consumption_february$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(consumption_february$timestamp, consumption_february$Sub_metering_2, type="l", col="red")
points(consumption_february$timestamp, consumption_february$Sub_metering_3, type="l", col="blue")
legend("toprigh", col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), lwd=c(1,1)) 

# Save histogram to png file
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()