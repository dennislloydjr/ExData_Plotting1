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

# Build the Array of plots
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# First chart (top-left): "Global Active Power" over time line chart
plot(x = plotting_dataset$DateTime, 
     y = plotting_dataset$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power")

# Second chart (top-right): "Voltage" over time line chart
plot(x = plotting_dataset$DateTime, 
     y = plotting_dataset$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# Third chart (bottom-left): "Energy Sub Metering" over time line chart
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

# Fourth chart (bottom-right): "Global Reactive Power" over time line chart
plot(x = plotting_dataset$DateTime, 
     y = plotting_dataset$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global Reactive Power")

dev.off()
