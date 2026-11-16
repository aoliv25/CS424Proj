# Running the parking study

## What to upload

The `docs/` folder is the participant website. It has no server, database, tracking tools, or external dependencies. The study runs in the browser. Do not put answer keys or returned results in `docs/`.

To publish after reviewing the website: push this repository to GitHub, open **Settings → Pages**, choose **Deploy from a branch**, and select your branch and **/docs**. Save. GitHub will provide the live URL. This uses your existing CS424Proj repository rather than a separate assignment repository.

Source: https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site

## Before sending links

1. Review the website locally. Use the pilot code for testing separately from the main ten.
2. Document the pilot's genuine observations and any changes. Pilot files are automatically labeled separately.
3. Freeze the website, data, and questions before the main study. If you change code after a pilot, change `VERSION` in `docs/study.js` so pilot progress from an earlier version is not reused.
4. Send one assigned link to each participant. Do not send the answer key. Ask everyone to use a laptop/desktop and a maximized browser window. The website requires at least 900 pixels of width at entry; actual viewport is recorded because remote screens may still differ.
5. Every participant must copy their results and paste them into the linked Google Form. The website does not submit automatically. Keep the original returned files and use `score_results.R` to combine and score them.

## Participant links

After publication, append the following to the URL GitHub gives you:

- `?id=PILOT01` for pilot testing (separate from the main ten).
- `?id=P01` through `?id=P10` for the main ten participants.

These are anonymous assigned codes, not secure logins. Send each code to only one person and check returned files for duplicate codes. The public website has no way to confirm identity, prevent sharing a code, or enforce that a pilot happened. Only send the main links after the pilot is complete.

P01–P03: Static A, then Interactive B.

P04–P05: Static B, then Interactive A.

P06–P07: Interactive A, then Static B.

P08–P10: Interactive B, then Static A.

## Automated procedure

Participants enter their assigned code, receive four questions, one at a time. There are no participant practice screens. They read each question before clicking **Start task**. Reading time is excluded. The assigned visualization appears after starting, and a countdown runs for 180 seconds. Participants cannot switch conditions through the interface.

The static condition has fixed date-specific clocks, date jump links, and supplementary weekday/temperature clocks. It has no expandable observation tables. Interactive uses calendar date selection and an expandable exact-value table. Questions ask which date has the larger change, rather than requiring exact percentages, so the clocks in both versions contain the needed information.

The timer stops on submit or skip. Timeouts are automatically recorded at 180 seconds. No correctness feedback appears. Static starts at the top, Interactive at September 24. Refreshing an active task retains its start time and does not reset the limit. Switching browser tabs does not pause the timer and is recorded. The website resets the displayed calendar on reload; refresh counts are exported. Time is measured by the browser clock and cannot be protected from deliberate changes on a static site.

Responses are saved in local browser storage. Refreshing or reopening the assigned link on the same browser resumes the session after entering the code. Storage can be lost if cleared or blocked; the page displays a warning if saving fails. There is no central backup. Participants may withdraw and download their partial data. Do not count withdrawals toward the ten complete main participants.

## Required scoring rules

- Correct completed answers: 1.
- Incorrect completed answers, skips, and timeouts: 0.
- Withdrawn attempts: accuracy missing, not a completed participant.
- A timeout has time 180; other attempts retain actual seconds, rounded to 0.1.
- An external technical problem must be documented by the researcher. Do not relabel a problem as an ordinary wrong answer. Preserve the raw file and describe any exclusions.

Questions and expected answers are in `PROTOCOL.md`. The answer key is also in the separate R scoring script, not in the participant JavaScript. Public GitHub source is still accessible: ask participants not to inspect the repository or use external help.

## Result columns

Each returned file contains one row per recorded task attempt:

- `participant_id`, `phase` (pilot/main), and `study_version`.
- `allocation_group` (1–4), `condition_order`, `condition`, `task_id`, `task_position` (1–4).
- `answer` (selected ISO date, blank for timeout/skip), `time_seconds`, and `status` (completed/skipped/timeout/withdrawn).
- `table_used` (0/1), `focus_losses`, `refreshes`, and `viewport` (browser width × height).
- `started_at` and `finished_at` (UTC timestamps).

The scoring script adds `accuracy`. Its summaries exclude pilot sessions and distinguish completed times from timeouts and skips. Interpret paired participant differences and task differences, not just pooled averages.

## Report changes

Update Task 2 to describe remote, self-administered testing and automatic timing, rather than a shared computer and researcher stopwatch. Record the actual number and background of participants, the returned files, pilot revisions, and technical problems. Remote screen differences, unobserved outside assistance, instructions adherence and manual CSV return are study limitations. Do not claim a pilot or user study happened until it actually does.

## Results submission

Participants click **Copy my results**, then open the linked Google Form and paste the results. CSV download remains available as a backup. If clipboard permission fails, the page displays selected results text for manual copying.

https://docs.google.com/forms/d/e/1FAIpQLSfPXXx88FNx5ncfrxbgFTQCwjNG0ufvBeP0s5E5kvs2L93WZQ/viewform

Participant code and pasted results are required; both feedback questions are optional. The form does not collect email addresses or require sign-in. Do not keep a code-to-name list if submissions must be anonymous. Save each pasted CSV response as its own `.csv` file in `returned-results` before scoring. Do not pass the Google Forms summary CSV directly to the scoring script.
