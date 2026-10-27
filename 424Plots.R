#Strip Plot
parking <- read.csv("/Users/ttjay123/Downloads/parking_cleaned.csv")
parking$Date <- as.Date(parking$Date)
time <- strptime(parking$Time, "%H:%M")
parking$Hour <- time$hour + time$min / 60
school <- parking[parking$Location == "School", ]
gym <- parking[parking$Location == "Gym", ]

par(mfrow = c(1, 1), mar = c(5, 5, 4, 2))
stripchart(list(Gym = gym$Percent.Available, School = school$Percent.Available), method = "stack", offset = 0.6, pch = 16, col = c("orange", "blue"), xlim = c(0, 100), main = "Parking availability across visits", xlab = "Percent available", ylab = "Location")
mtext("Each dot is one visit.", side = 3, line = 0.3, cex = 0.8)

#Clock plots
par(mfrow = c(1, 1), mar = c(4, 3, 4, 3))
for (location in c("School", "Gym")) {
  visits <- parking[parking$Location == location, ]
    if (location == "School") 
    {
      start_hour <- 6
      end_hour <- 20
      color <- "blue"
      label_step <- 2
    } 
  else 
  {
    start_hour <- 9
    end_hour <- 21
    color <- "orange"
    label_step <- 2
  }
  time_span <- end_hour - start_hour
  outside <- sum(visits$Hour < start_hour | visits$Hour > end_hour)
  visits <- visits[visits$Hour >= start_hour & visits$Hour <= end_hour, ]
  circle_angles <- seq(-150, 150, length.out = 200) * pi / 180
  plot(0, 0, type = "n", xlim = c(-1.45, 1.45), ylim = c(-1.45, 1.45), asp = 1, axes = FALSE, xlab = "", ylab = "", main = paste(location, "parking by time of day"))
  
  for (percent in seq(0, 100, 25)) 
    {
    radius <- 0.25 + 0.75 * percent / 100
    lines(radius * sin(circle_angles), radius * cos(circle_angles), col = "gray80")
    }
  
  # Add hour ticks and guide lines
  hours <- seq(start_hour, end_hour, by = 1)
  angles <- (-150 + (hours - start_hour) / time_span * 300) * pi / 180
  
  for (i in seq_along(hours)) 
    {
    hour <- hours[i]
    angle <- angles[i]
    tick_start <- 0.96
    
    if (hour %% 2 == 0 || (hour - start_hour) %% label_step == 0) {
      if ((hour - start_hour) %% label_step == 0) {
        tick_start <- 0.90
        segments(0.25 * sin(angle), 0.25 * cos(angle),
                 sin(angle), cos(angle), col = "gray85")
      }
      segments(tick_start * sin(angle), tick_start * cos(angle),
               sin(angle), cos(angle), col = "gray40")
    }
  }
  
  label_hours <- seq(start_hour, end_hour, by = label_step)
  label_angles <- (-150 + (label_hours - start_hour) / time_span * 300) * pi / 180
  hour_labels <- sprintf("%02d:00", label_hours)
  
  text(1.22 * sin(label_angles), 1.22 * cos(label_angles), hour_labels, cex = 0.85)
  
  legend("topleft", legend = c("Rings, inner to outer:", "0%, 25%, 50%, 75%, 100%"),
         bty = "n", cex = 0.75)
  
  pt_angles <- (-150 + (visits$Hour - start_hour) / time_span * 300) * pi / 180
  radius <- 0.25 + 0.75 * visits$Percent.Available / 100
  points(radius * sin(pt_angles), radius * cos(pt_angles), pch = 16, cex = 0.85,
         col = adjustcolor(color, alpha.f = 0.5))
  
  
}

#Calendar
par(mfrow = c(1, 1), mar = c(2, 1, 5, 1))
first <- min(parking$Date, na.rm = TRUE)
last <- max(parking$Date, na.rm = TRUE)
start <- first - (as.integer(format(first, "%u")) - 1)
number_of_weeks <- as.integer(last - start) %/% 7 + 1

plot(0, 0, type = "n", xlim = c(0, 7), ylim = c(number_of_weeks, -0.4),
     axes = FALSE, xlab = "", ylab = "", xaxs = "i", yaxs = "i",
     main = "Calendar of parking visits")
mtext("Time / location / percent available     S = School     G = Gym",
      side = 3, line = 0.4, cex = 0.75)
text(seq(0.5, 6.5, 1), -0.2,
     c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"), cex = 0.8)

for (i in 0:(number_of_weeks * 7 - 1)) {
  date <- start + i
  x <- i %% 7
  y <- i %/% 7
  rect(x, y, x + 1, y + 1, border = "gray80")
  if (date < first || date > last) next
  
  text(x + 0.05, y + 0.10, format(date, "%b %d"), adj = 0, cex = 0.7)
  visits <- parking[parking$Date == date, ]
  visits <- visits[order(visits$Time), ]
  if (nrow(visits) == 0) {
    text(x + 0.05, y + 0.35, "Not observed", adj = 0, cex = 0.6)
  } else {
    for (j in seq_len(nrow(visits))) {
      color <- ifelse(visits$Location[j] == "School", "blue", "orange")
      label <- paste(visits$Time[j], substr(visits$Location[j], 1, 1),
                     paste0(visits$Percent.Available[j], "%"))
      text(x + 0.05, y + 0.25 + (j - 1) * 0.11,
           label, adj = 0, col = color, cex = 0.55)
    }
  }
}

par(mfrow = c(1, 1), mar = c(5, 4, 4, 2) + 0.1)
