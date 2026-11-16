library(shiny)
parking <- read.csv("parking.csv", check.names = FALSE)
parking$Date <- as.Date(parking$Date)
time <- strptime(parking$Time, "%H:%M")
parking$Hour <- time$hour + time$min / 60
day_names <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
parking$Weekday <- day_names[as.integer(format(parking$Date, "%u"))]
days <- day_names[1:6]
parking$Temperature <- as.numeric(parking[["Temperature (°F)"]])
bands <- c("69°F and below", "70°F and above")
parking$Band <- ifelse(parking$Temperature < 70, bands[1], bands[2])

# Draw one clock. Both tabs use this function so their design stays the same.
draw_clock <- function(data, location, heading = location) 
  {
  par(cex.main = 1.5, bg = "#f0f3f7", fg = "#20252b", col.main = "#20252b", col.lab = "#20252b", col.axis = "#20252b")
  visits <- data[data$Location == location, ]
  start <- ifelse(location == "School", 6, 9)
  finish <- ifelse(location == "School", 20, 21)
  step <- 2
  color <- ifelse(location == "School", "#2166ac", "#b35806")
  plot(0, 0, type = "n", xlim = c(-1.5, 1.5), ylim = c(-1.5, 1.5), asp = 1, axes = FALSE, xlab = "", ylab = "", main = heading)
  circle <- seq(-150, 150, length.out = 200) * pi / 180
  for (percent in seq(0, 100, 25)) 
    {
    radius <- 0.25 + 0.75 * percent / 100
    lines(radius * sin(circle), radius * cos(circle), col = "#aab3be")
  }
  for (hour in start:finish) 
    {
    angle <- (-150 + (hour - start) / (finish - start) * 300) * pi / 180
    if ((hour - start) %% step == 0) 
      {
      segments(0.25 * sin(angle), 0.25 * cos(angle), sin(angle), cos(angle), col = "#c3cad3")
    }
    segments(0.94 * sin(angle), 0.94 * cos(angle), sin(angle), cos(angle), col = "#626b77")
  }
  hours <- seq(start, finish, step)
  angle <- (-150 + (hours - start) / (finish - start) * 300) * pi / 180
  labels <- sprintf("%02d:00", hours)
  text(1.23 * sin(angle), 1.23 * cos(angle), labels, cex = 1.15)
  angle <- (-150 + (visits$Hour - start) / (finish - start) * 300) * pi / 180
  radius <- 0.25 + 0.75 * visits[["Percent Available"]] / 100
  key <- paste(visits$Time, visits[["Percent Available"]])
  first <- !duplicated(key)
  counts <- c()
  for (value in key[first]) 
    {
    counts <- c(counts, sum(key == value))
  }
  x <- radius[first] * sin(angle[first])
  y <- radius[first] * cos(angle[first])
  points(x, y, pch = 16, col = adjustcolor(color, alpha.f = 0.55), cex = 0.9)
  repeated <- counts > 1
  if (any(repeated)) 
    {
    text(x[repeated], y[repeated], paste0("×", counts[repeated]), pos = 4, cex = 1.0)
  }
  if (nrow(visits) == 0) text(0, 0, "No visits", cex = 1.1)
  legend("topleft", c("Rings, inner to outer:", "0%, 25%, 50%, 75%, 100%"), bty = "n", cex = 1.0)
  mtext(paste(nrow(visits), "visits"), side = 1, line = 0.3, cex = 1.1)
}

visit_table <- function(data) 
  {
  result <- data[, c("Date", "Time", "Location", "Weekday", "Accessible", "Inaccessible", "Percent Available", "Temperature (°F)")]
  result[order(result$Date, result$Time), ]
}

clock_panel <- function(id) 
  {
  div(class = "clock-panel", plotOutput(id, height = "650px"))
}

static_groups <- unique(parking[, c("Weekday", "Location", "Band")])
static_groups <- static_groups[order(match(static_groups$Band, bands), match(static_groups$Weekday, days), match(static_groups$Location, c("School", "Gym"))), ]
rownames(static_groups) <- NULL
months <- unique(format(sort(parking$Date), "%Y-%m"))
month_labels <- format(as.Date(paste0(months, "-01")), "%B %Y")

static_plots <- list()
for (band in bands) 
  {
  panels <- list()
  missing_groups <- c()
  for (day in days) 
    {
    for (location in c("School", "Gym")) {
      if (day == "Saturday" && location == "School") next
      group <- which(static_groups$Weekday == day & static_groups$Location == location & static_groups$Band == band)
      if (length(group) > 0) 
        {
        panels <- append(panels, list(clock_panel(paste0("static", group))))
      } 
      else 
        {
        missing_groups <- c(missing_groups, paste(location, day))
      }
    }
  }
  static_plots <- append(static_plots, list(h3(band)))
  if (length(missing_groups) > 0) 
    {
    static_plots <- append(static_plots, list(p("No recorded visits: ", paste(missing_groups, collapse = "; "))))
  }
  static_plots <- append(static_plots, list(div(class = "clock-grid", panels)))
}

dates <- sort(unique(parking$Date))
daily_plots <- list()
date_links <- list()
for (i in seq_along(dates)) {
  date <- dates[i]
  visits <- parking[parking$Date == date, ]
  section_id <- paste0("date", i)
  date_links <- append(date_links, list(
    tags$a(href = paste0("#", section_id), format(date, "%b %d")), " | "))
  panels <- list()
  if (any(visits$Location == "School")) {
    panels <- append(panels, list(clock_panel(paste0("daily_school", i))))
  }
  if (any(visits$Location == "Gym")) {
    panels <- append(panels, list(clock_panel(paste0("daily_gym", i))))
  }
  daily_plots <- append(daily_plots, list(
    tags$section(id = section_id,
      h3(format(date, "%A, %B %d, %Y")),
      div(class = "clock-grid", panels))))
}

ui <- fluidPage(
  tags$head(tags$link(rel = "stylesheet", href = "style.css")),
  titlePanel("Parking availability: static and interactive clocks"),
  p("Each dot is a visit. Rings, inner to outer: 0%, 25%, 50%, 75%, 100% available.", "×2 means two visits share the same time and percentage.", "School: 06:00–20:00; gym: 09:00–21:00. Angles differ between locations."),
  p("Temperature is from the nearest supplied ORD reading that day."),
  tabsetPanel(
    tabPanel("Static",
             h3("All visits"),
             div(class = "clock-grid", clock_panel("static_school"), clock_panel("static_gym")),
             h3("Visits by date"),
             p("These fixed clocks show individual dates. The links jump down the page without filtering."),
             div(date_links),
             daily_plots,
             h3("Additional weekday and temperature comparisons"),
             p("Below: the same clocks grouped by weekday and temperature. Scroll to compare subsets."),
             static_plots
    ),
    tabPanel("Interactive",
             h3("Explore visits by date"),
             p("Choose a month, then click a day to see its clocks and exact observations."),
             selectInput("calendar_month", "Month", choices = setNames(months, month_labels)),
             uiOutput("calendar_grid"),
             h3(textOutput("calendar_selection", inline = TRUE)),
             textOutput("calendar_empty"),
             div(class = "clock-grid", uiOutput("calendar_panels", style = "display:contents;")),
             tags$details(class = "observation-dropdown",
               tags$summary("Click to expand observation table"),
               tableOutput("calendar_table"))
    )
  )
)

server <- function(input, output, session) {
  calendar_date <- reactiveVal(min(parking$Date))
  observeEvent(input$calendar_day, 
               {
    date <- as.Date(input$calendar_day, format = "%Y-%m-%d")
    if (!is.na(date)) calendar_date(date)
  })
  observeEvent(input$calendar_month, 
               {
    if (format(calendar_date(), "%Y-%m") != input$calendar_month) 
      {
      calendar_date(min(parking$Date[format(parking$Date, "%Y-%m") == input$calendar_month]))
    }
  })
  calendar_visits <- reactive(parking[parking$Date == calendar_date(), ])
  output$calendar_grid <- renderUI({
    req(input$calendar_month)
    first <- as.Date(paste0(input$calendar_month, "-01"))
    next_month <- seq(first, by = "month", length.out = 2)[2]
    dates <- seq(first, next_month - 1, by = "day")
    offset <- as.integer(format(first, "%u")) - 1
    cells <- list()
    for (day in c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")) 
      {
      cells <- append(cells, list(div(class = "calendar-heading", day)))
    }
    if (offset > 0) 
      {
      for (i in 1:offset) cells <- append(cells, list(div()))
    }
    for (i in seq_along(dates)) 
      {
      date <- dates[i]
      visits <- parking[parking$Date == date, ]
      school_n <- sum(visits$Location == "School")
      gym_n <- sum(visits$Location == "Gym")
      label <- if (nrow(visits)) paste("School:", school_n, "| Gym:", gym_n) else "No visits"
      button <- tags$button(
        type = "button", class = if (nrow(visits)) "calendar-day" else "calendar-day no-visits",
        `aria-pressed` = if (date == calendar_date()) "true" else "false",
        `aria-label` = paste(format(date, "%B %d, %Y"), label),
        onclick = sprintf("Shiny.setInputValue('calendar_day', '%s', {priority: 'event'});", date),
        span(class = "calendar-number", format(date, "%d")),
        span(class = "calendar-count", label))
      cells <- c(cells, list(button))
    }
    div(class = "parking-calendar", cells)
  })
  output$calendar_selection <- renderText(format(calendar_date(), "%A, %B %d, %Y"))
  output$calendar_empty <- renderText({
    if (!nrow(calendar_visits())) "No parking observations were recorded on this date."
  })
  output$calendar_panels <- renderUI({
    data <- calendar_visits()
    tagList(if (any(data$Location == "School")) clock_panel("calendar_school"),
            if (any(data$Location == "Gym")) clock_panel("calendar_gym"))
  })
  output$calendar_school <- renderPlot({
    par(mar = c(2, 1, 3, 1))
    draw_clock(calendar_visits(), "School")
  })
  output$calendar_gym <- renderPlot({
    par(mar = c(2, 1, 3, 1))
    draw_clock(calendar_visits(), "Gym")
  })
  output$calendar_table <- renderTable(visit_table(calendar_visits()), striped = TRUE)
  output$static_school <- renderPlot({
    par(mar = c(2, 1, 3, 1))
    draw_clock(parking, "School")
  })
  output$static_gym <- renderPlot({
    par(mar = c(2, 1, 3, 1))
    draw_clock(parking, "Gym")
  })
  for (i in seq_len(nrow(static_groups))) 
    {
    local({
      group <- static_groups[i, ]
      id <- paste0("static", i)
      output[[id]] <- renderPlot({
        par(mar = c(2, 1, 3, 1))
        data <- parking[parking$Weekday == group$Weekday & parking$Band == group$Band, ]
        draw_clock(data, group$Location, paste(group$Location, "—", group$Weekday)
                   )
      })
    })
  }
  for (i in seq_along(dates)) {
    local({
      date <- dates[i]
      visits <- parking[parking$Date == date, ]
      school_id <- paste0("daily_school", i)
      gym_id <- paste0("daily_gym", i)
      output[[school_id]] <- renderPlot({
        par(mar = c(2, 1, 3, 1))
        draw_clock(visits, "School")
      })
      output[[gym_id]] <- renderPlot({
        par(mar = c(2, 1, 3, 1))
        draw_clock(visits, "Gym")
      })
    })
  }
}

shinyApp(ui, server)
