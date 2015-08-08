# Creates plot1.png, a histogram of the Global Active Power for the first two days of
# February 2007.
createPlot1 <- function(file='household_power_consumption.txt', plotfile='plot1.png') {
  data <- read.csv(file, sep=';', na.strings="?", 
                   colClasses=c('character', 'character', rep('numeric', 7)))
  # limit data to dates of interest. this is a hack that works because we know the exact
  # dates and the format of the strings for those dates, but it is much faster than 
  # more generally converting to a Date and doing comparisons.
  data <- data[data$Date == '1/2/2007' | data$Date =='2/2/2007', ]
  # make sure there aren't any missing readings
  data <- data[!is.na(data$Global_active_power), ]
  # plot to PNG
  png(filename=plotfile)
  hist(data$Global_active_power, col='red', main='Global Active Power', 
       xlab='Global Active Power (kilowatts)')
  invisible(dev.off())
}