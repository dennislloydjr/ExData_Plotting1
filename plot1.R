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

# Build the "Global Active Power" histogram plot
png("plot1.png", width = 480, height = 480)
hist(plotting_dataset$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
