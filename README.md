# CS 424 parking visualization project

Assignment 1 and Assignment 2 materials are retained in this repository.

## Assignment 3 website

The participant website is in `docs/`. It uses plain HTML, CSS, and JavaScript and can be hosted on GitHub Pages. Open `docs/index.html` locally for a quick preview, or serve the repository with a local web server.

The two conditions use the same 159 observations and clock design. Static has fixed daily clocks; Interactive uses calendar date selection and an expandable observation table. School spans 06:00–20:00, gym 09:00–21:00, both with a cut at the bottom. Colors and scales match across conditions.

Participants answer four assigned questions with automatic timing and download their results. **Results are not automatically uploaded. Participants must send their CSV files to the researcher.**

Study procedure, pilot/main links, expected answers, scoring, and hosting instructions are in `study-materials/`. `score_results.R` combines returned CSVs, adds accuracy, and creates the required comparison plots in R. Returned results are ignored by Git by default to avoid accidental publication; include the required anonymized measurements deliberately in your final course submission.

Do not send the main-study links until the pilot has been conducted and the protocol finalized. Software tests do not count as pilot participants.

No website changes have been published by this draft.
