library(data.table)

# This is my code to download data to working directory (already run)
#   dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#   download.file(dataset_url,"household_power_consumption.zip")
#   unzip("household_power_consumption.zip")
filenm <- "household_power_consumption.txt"

# Read two days of data starting on 2/1/2007 (Already confirmed correct rows)
tab <-fread(filenm, header=FALSE, na.strings="?",skip ="1/2/2007",nrows=2*24*60)

# Add the column names (which were skipped in the first read)
setnames( tab, as.character(fread(filenm, nrows = 1, header=FALSE)))

# Add a combined date/time column to the data table
tab[ ,datetime:= as.POSIXct(strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S"))]

# Open the png file ready for plotting
png( file = "plot3.png", width=480, height=480 )

# Plot the multiple line chart - Plot 3
with(tab, plot( datetime, Sub_metering_1,
                type="l",
                xlab = "",
                ylab= "Energy sub metering"))
with(tab, lines( datetime, Sub_metering_2, col = "red"))
with(tab, lines( datetime, Sub_metering_3, col = "blue"))

# Add the legend
legend( "topright", lty = 1, col = c("black", "red", "blue"),
        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
dev.off()
