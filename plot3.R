# Clear the graphics state
graphics.off()

# Get the data
if (!file.exists("household_power_consumption.txt")) {
  datasource <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(datasource, "household_power_consumption.zip")
  unzip("household_power_consumption.zip", exdir = ".")
}

# Read, subset, format data
columnClasses <- c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")

full_dataset <- read.table("household_power_consumption.txt", 
                           sep = ";", 
                           header = TRUE, 
                           na = "?", 
                           stringsAsFactors = FALSE,
                           colClasses = columnClasses)

subset_dataset = subset(full_dataset, Date == "1/2/2007" | Date == "2/2/2007")

subset_dataset$DateTime <- strptime(paste(subset_dataset$Date, subset_dataset$Time), "%d/%m/%Y %H:%M:%S")
subset_dataset$Date <- as.Date(subset_dataset$Date , "%d/%m/%Y")

plotting_dataset <- subset_dataset

# Build the "Energy sub metering" over time line chart
png("plot3.png", width = 480, height = 480)
plot(x = plotting_dataset$DateTime, 
     y = plotting_dataset$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering",
     col = "black")
points(x = plotting_dataset$DateTime, 
       y = plotting_dataset$Sub_metering_2,
       type = "l",
       col = "red")
points(x = plotting_dataset$DateTime, 
       y = plotting_dataset$Sub_metering_3,
       type = "l",
       col = "blue")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), 
       lty = 1,
       ncol = 1)
dev.off()
