### PLOT 2 ###

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
plot(dataframesub$Global_active_power~dataframesub$Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Save file to png into working directory
dev.copy(png, file="plot2.png", height=960, width=960)
dev.off()