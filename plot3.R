### PLOT 3 ###

## Assign file name to vector
datafile <- "household_power_consumption.txt" 

## Read in data
dataframe <- read.csv(datafile, header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

## Convert date format of variable 'Date'
dataframe$Date <- as.Date(dataframe$Date, format="%d/%m/%Y")

## Subset dataframe for required dates into dataframesub
dataframesub <- subset(dataframe, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(dataframe) # remove original dataframe

## Convert Datetime into POSIXct
datetime <- paste(as.Date(dataframesub$Date), dataframesub$Time)
dataframesub$Datetime <- as.POSIXct(datetime)

## Plot
with(dataframesub, {plot(Sub_metering_1~Datetime, type="l",
ylab="Global Active Power (kilowatts)", xlab="")
lines(Sub_metering_2~Datetime,col='Red')
lines(Sub_metering_3~Datetime,col='Blue')})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save file to png into working directory
dev.copy(png, file="plot3.png", height=960, width=960)
dev.off()
