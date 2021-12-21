library(lubridate)
library(dplyr)

## Read in and format data ##
hhdata <- read.table("household_power_consumption.txt",
                     sep = ";",header = TRUE)
hhdata2 <- hhdata

hhdata2 <- hhdata2 %>% na_if("?")
hhdata2$Date <- dmy(hhdata2$Date)
hhdata2$Time <- hms::as_hms(hhdata2$Time)

date_select <- year(hhdata2$Date) == 2007 & month(hhdata2$Date) == 2 & (day(hhdata2$Date) == 1 | day(hhdata2$Date) == 2)
hhdata3 <- hhdata2[date_select,]

hhdata4 <- hhdata3 %>% mutate_if(is.character,as.numeric)

#Plot 1
# histogram Global active power
png("plot1.png", width = 480, height = 480, units = "px")
hist(hhdata4$Global_active_power,col = "red",xlab = "Global Acitive Power (kilowatts)",
     ylab = "Frequency",main = "Global Active Power")
dev.off()


