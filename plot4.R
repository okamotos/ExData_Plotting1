# Creates plot4 with four subplots for the first two days of February 2007: 
#   * a line plot of global active power
#   * a line plot of voltage
#   * a line plot of three submetering readings
#   * a line plot of global reactive power
createPlot4 <- function(file='household_power_consumption.txt', plotfile='plot4.png') {
  data <- read.csv(file, sep=';', na.strings="?", 
                   colClasses=c('character', 'character', rep('numeric', 7)))
  # limit data to dates of interest. this is a hack that works because we know the exact
  # dates and the format of the strings for those dates, but it is much faster than 
  # more generally converting to a Date and doing comparisons.
  data <- data[data$Date == '1/2/2007' | data$Date =='2/2/2007', ]
  # make sure there aren't any missing readings
  data <- data[complete.cases(data), ]
  # now create the POSIXlt representations of the dates and times on the reduced data set  
  data$DateTime <- strptime(paste(data$Date, data$Time), '%d/%m/%Y %H:%M:%S')

  # plot to PNG
  png(filename=plotfile)
  par(mfrow = c(2, 2))
  # create the first time plot of global active power
  plot(data$DateTime, data$Global_active_power, main='', type='l', 
       ylab='Global Active Power', xlab='')
  # create the second time plot of Voltage
  plot(data$DateTime, data$Voltage, main='', type='l', 
       ylab='Voltage', xlab='datetime')
  # create the third time plot of sub metering
  plot(data$DateTime, data$Sub_metering_1, main='', type='l',
       ylab='Energy sub metering', xlab='')
  lines(data$DateTime, data$Sub_metering_2, main='', type='l', col='red')
  lines(data$DateTime, data$Sub_metering_3, main='', type='l', col='blue')
  legend('topright', col=c('black', 'red', 'blue'), bty='n', lty=1,
         legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
  # create the fourth time plot of global reactive power
  plot(data$DateTime, data$Global_reactive_power, main='', type='l', 
       ylab='Global_reactive_power', xlab='datetime')
  invisible(dev.off())
}