### PLOT 4 ###

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


## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0)) ## define plotting layout
with(dataframesub, {
    plot(Global_active_power~Datetime, type="l",   ## Plot 4.1
         ylab="Global Active Power (kilowatts)", xlab="")
    plot(Voltage~Datetime, type="l",               ## Plot 4.2
         ylab="Voltage (volt)", xlab="")
    plot(Sub_metering_1~Datetime, type="l",        ## Plot 4.3
         ylab="Global Active Power (kilowatts)", xlab="")
         lines(Sub_metering_2~Datetime,col='Red')
         lines(Sub_metering_3~Datetime,col='Blue')
         legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power~Datetime, type="l",  ## Plot 4.4
         ylab="Global Rective Power (kilowatts)",xlab="")})

## Save file to png into working directory
dev.copy(png, file="plot4.png", height=960, width=960)
dev.off()
