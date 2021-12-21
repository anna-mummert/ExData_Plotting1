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

#Plot 2
# Line graph of global active power over time; time labeled by weekday
png("plot2.png", width = 480, height = 480, units = "px")
with(hhdata4, {
  plot(Global_active_power,xlab = "",
       ylab = "Global Active Power (kilowatts)",type = "n",xaxt = "n")
  lines(Global_active_power)
  axis(1, at = c(which(hhdata4$Time == 0), length(hhdata4$Time) +1), labels = c("Thurs", "Fri", "Sat")) 
})
dev.off()


