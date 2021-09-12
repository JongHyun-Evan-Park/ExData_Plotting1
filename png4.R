# 1. Read in the data from the dates 2007-02-01 ~ 2007-02-02 / convert Date and Time variables to date-time class / check if there is NA value

if(!file.exists("data")){dir.create("data")}

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/EPC.zip")
unzip("./data/EPC.zip", exdir = "./data/EPC")

pathdata <- file.path("./data/EPC", "household_power_consumption.txt")
read.table(file.path(pathdata), header = TRUE, sep = ";", nrows = 5) ## 데이터 형태 파악

hpc <- read.table(file.path(pathdata), header = TRUE, sep = ";", na.strings = "?")
hpc2 <- hpc %>% filter(Date == "1/2/2007" | Date == "2/2/2007") %>% mutate(timeline = dmy(Date) + hms(Time)) 

# 2. Make plot
# plot4
png(filename = "png4.png", width = 480, height = 480)

par(mfcol=c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

with(hpc2,plot(Global_active_power ~ timeline, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

with(hpc2,plot(Sub_metering_1 ~ timeline, type = "l", xlab = "", ylab = ""))
with(hpc2,lines(timeline, Sub_metering_2, col = "red", xlab = "", ylab = ""))
with(hpc2,lines(timeline, Sub_metering_3, col = "blue", xlab = "", ylab = ""))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1,1), col = c("black", "red", "blue"))
title( xlab= "", ylab = "Energy sub metering")

with(hpc2,plot(Voltage ~ timeline, type = "l", xlab = "datetime", ylab = "Voltage"))

with(hpc2,plot(Global_reactive_power ~ timeline, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

dev.off()