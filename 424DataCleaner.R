parking <- read.csv("/Users/ttjay123/Downloads/parking_cleaned.csv")
time <- strptime(parking$Time, "%H:%M")
parking$Hour <- time$hour + time$min / 60
parking$Day <- as.integer(format(as.Date(parking$Date), "%u"))
colors <- ifelse(parking$Location == "School", "blue", "orange")
shapes <- ifelse(parking$Location == "School", 16, 15)

# Plot 1: percentage available at each observation time.
plot(parking$Hour, parking$Percent.Available, col = colors, pch = shapes, ylim = c(0, 100), main = "Parking availability by time", xlab = "Time of day (24-hour, decimal hours)", ylab = "Percent available")
legend("topright", c("School", "Gym"), col = c("blue", "orange"), pch = c(16, 15))

# Plot 2: when the observations were collected.
plot(parking$Hour, parking$Day, col = colors, pch = shapes, ylim = c(7.5, 0.5), yaxt = "n", main = "Observation schedule", xlab = "Time of day (24-hour, decimal hours)", ylab = "Day")
axis(2, at = 1:7, labels = c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"), las = 1)
legend("topright", c("School", "Gym"), col = c("blue", "orange"), pch = c(16, 15))
