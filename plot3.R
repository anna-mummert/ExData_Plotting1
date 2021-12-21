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

#Plot 3
# Line graph of sub_metering (all three) over time; time labeled by weekday
png("plot3.png", width = 480, height = 480, units = "px")
with(hhdata4,{
  plot(Sub_metering_1,xlab = "",
       ylab = "Energy sub metering",type = "n",xaxt = "n")
  lines(Sub_metering_1)
  lines(Sub_metering_2,col = "red")
  lines(Sub_metering_3,col = "blue")
  legend("topright",lty = 1, col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  axis(1, at = c(which(hhdata4$Time == 0), length(hhdata4$Time) +1), labels = c("Thurs", "Fri", "Sat")) 
})
dev.off()

