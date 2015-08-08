# Creates plot3, a line plot for the three submetering readings for the first two days of February 2007
createPlot3 <- function(file='household_power_consumption.txt', plotfile='plot3.png') {
  data <- read.csv(file, sep=';', na.strings="?", 
                   colClasses=c('character', 'character', rep('numeric', 7)))
  # limit data to dates of interest. this is a hack that works because we know the exact
  # dates and the format of the strings for those dates, but it is much faster than 
  # more generally converting to a Date and doing comparisons.
  data <- data[data$Date == '1/2/2007' | data$Date =='2/2/2007', ]
  # make sure there aren't any missing readings
  data <- data[complete.cases(data[, 7:9]), ]
  # now create the POSIXlt representations of the dates and times on the reduced data set  
  data$DateTime <- strptime(paste(data$Date, data$Time), '%d/%m/%Y %H:%M:%S')
  # plot to PNG
  png(filename=plotfile)
  plot(data$DateTime, data$Sub_metering_1, main='', type='l',
       ylab='Energy sub metering', xlab='')
  lines(data$DateTime, data$Sub_metering_2, main='', type='l', col='red')
  lines(data$DateTime, data$Sub_metering_3, main='', type='l', col='blue')
  legend('topright', col=c('black', 'red', 'blue'), lty=1,
         legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
  invisible(dev.off())
}