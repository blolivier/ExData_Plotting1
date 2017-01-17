
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


### Plot 4 ###

png(filename = "plot4.png", width = 480, height = 480)

# Set pannel
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))

# Plot pannel 1
plot(final_set$date_time, final_set$Global_active_power
     ,type = "l"
     ,ylab = "Global Active Power (kilowatts)"
     ,xlab = "")

# Plot pannel 2
with(final_set, plot(date_time, Voltage, type = "l"))

# Plot pannel 3
plot(final_set$date_time, final_set$Sub_metering_1
     ,type = "l"
     ,ylab = "Energy sub metering"
     ,xlab = "")
lines(final_set$date_time, final_set$Sub_metering_2, col = "red")
lines(final_set$date_time, final_set$Sub_metering_3, col = "blue")
legend("topright"
       ,lty = c(1,1,1)
       ,col = c("black", "red", "blue")
       ,legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
)

# Plot pannel 4
with(final_set, plot(date_time, Global_reactive_power, type = "l"))

dev.off()