library(ggplot2)
library(dplyr)
library(lubridate)
Sys.setlocale(locale = "English")

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
# plot2
png(filename = "plot2.png", width = 480, height = 480)
with(hpc2,plot(Global_active_power ~ timeline, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()