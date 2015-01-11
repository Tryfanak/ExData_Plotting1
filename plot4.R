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
png( file = "plot4.png", width=480, height=480, pointsize = 11 )

# Set up the 2x2 lattice to display plots - Plot 4
par(mfcol = c(2, 2))

# Create all four plots to fill the lattice (order matters)
with (tab, {
    plot(datetime, Global_active_power,type="l",
         ylab= "Global Active Power", xlab = "")
    
    plot( datetime, Sub_metering_1, 
          type="l",
          xlab = "",
          ylab= "Energy sub metering")
    lines( datetime, Sub_metering_2, col = "red")
    lines( datetime, Sub_metering_3, col = "blue")
    legend("topright", lty = 1 , bty = "n", col = c("black", "red", "blue"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )

    plot(datetime, Voltage, type="l")
    
    plot(datetime, Global_reactive_power, type="l")
})

dev.off()
