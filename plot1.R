
# Create a path to the raw data
wd_path = "C:/Users/Nardus/Documents/coursera/Data Science/Course 4 - Exploratory Data Analysis/Week 1/Assignment data"
setwd(wd_path)

# Import data
raw_set = read.table("household_power_consumption.txt", sep = ";", header = TRUE)

library(magrittr)
raw_set = raw_set %>%
    dplyr::mutate(Date = lubridate::dmy(Date)) %>%
    dplyr::filter(Date >= "2007-02-01" & Date <= "2007-02-02")

final_set = raw_set
final_set$date_time = lubridate::ymd_hms(paste(final_set$Date, final_set$Time, sep = " "))
final_set = dplyr::mutate(final_set
                          ,Global_active_power = as.numeric(as.character(Global_active_power))
                          ,Global_reactive_power = as.numeric(as.character(Global_reactive_power))
                          ,Voltage = as.numeric(as.character(Voltage))
                          ,Global_intensity = as.numeric(as.character(Global_intensity))
                          ,Sub_metering_1 = as.numeric(as.character(Sub_metering_1))
                          ,Sub_metering_2 = as.numeric(as.character(Sub_metering_2))
                          ,Sub_metering_3 = as.numeric(as.character(Sub_metering_3))
)


### Plot 1 ###

png(filename = "plot1.png", width = 480, height = 480)

hist(final_set$Global_active_power
     ,main = "Global Active Power"
     ,xlab = "Global Active Power (kilowatts)"
     ,col = "Red")

dev.off()