# Put the returned participant CSVs in study-materials/returned-results.
# Run this script from the repository folder. No extra packages are needed.
files <- list.files("study-materials/returned-results", pattern = "\\.csv$", full.names = TRUE)
if (length(files) == 0) stop("Add the returned participant CSVs first.")
results <- do.call(rbind, lapply(files, read.csv, stringsAsFactors = FALSE))

# Keep the answer key out of the public docs folder.
answers <- c(T1A = "2026-10-07", T1B = "2026-10-14",
             T2A = "2026-10-22", T2B = "2026-10-26")
if (any(!results$task_id %in% names(answers))) stop("Unknown task ID in results.")
if (anyDuplicated(paste(results$participant_id, results$task_position))) {
  stop("Duplicate participant/task rows. Keep only one returned file per participant.")
}
results$accuracy <- as.integer(results$status == "completed" &
                                results$answer == answers[results$task_id])
results$accuracy[results$status == "withdrawn"] <- NA
write.csv(results, "study-materials/scored_results.csv", row.names = FALSE)

# Pilot results stay in the scored file but are excluded from main-study summaries.
main <- results[results$phase == "main", ]
if (nrow(main) == 0) {
  message("Pilot results scored. No main-study results yet.")
} else {
  summary <- data.frame()
  for (condition in c("Static", "Interactive")) {
    group <- main[main$condition == condition, ]
    completed <- group[group$status == "completed", ]
    correct <- completed[completed$accuracy == 1, ]
    summary <- rbind(summary, data.frame(
      Condition = condition,
      Attempts = nrow(group),
      Accuracy = mean(group$accuracy, na.rm = TRUE),
      Completed = nrow(completed),
      Timeouts = sum(group$status == "timeout"),
      Skipped = sum(group$status == "skipped"),
      MeanSecondsCompleted = mean(completed$time_seconds),
      MedianSecondsCompleted = median(completed$time_seconds),
      SDSecondsCompleted = sd(completed$time_seconds),
      CorrectCompleted = nrow(correct),
      MedianSecondsCorrect = median(correct$time_seconds)))
  }
  write.csv(summary, "study-materials/condition_summary.csv", row.names = FALSE)
  print(summary)
  print(table(main$participant_id, main$condition))
  print(with(main, table(task_id, condition, status)))

  # Two plots appear in RStudio. Participants, not independent tasks, are paired.
  participant_accuracy <- aggregate(accuracy ~ participant_id + condition, main, mean)
  plot(NA, xlim = c(0.7, 2.3), ylim = c(0, 1), xaxt = "n",
       xlab = "Condition", ylab = "Proportion correct", main = "Accuracy by participant")
  axis(1, at = 1:2, labels = c("Static", "Interactive"))
  for (id in unique(main$participant_id)) {
    p <- participant_accuracy[participant_accuracy$participant_id == id, ]
    p <- p[match(c("Static", "Interactive"), p$condition), ]
    lines(1:2, p$accuracy, type = "b", col = "#2166ac", pch = 16)
  }
  completed <- main[main$status == "completed", ]
  if (nrow(completed) > 0) {
    boxplot(time_seconds ~ condition, completed,
            xlab = "Condition", ylab = "Time (seconds)",
            main = "Completed-task times (timeouts and skips excluded)", col = "#e5edf8")
    stripchart(time_seconds ~ condition, completed, vertical = TRUE, add = TRUE,
               method = "jitter", pch = 16, col = "#2166ac")
  }
}
