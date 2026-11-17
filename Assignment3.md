## Task 1: Implementing interaction

I continued with the school and gym clocks from Assignment 2 and made static and interactive versions of them using R and Shiny. Both versions use  the same updated data, ending the data collection on 11/10/2026. The data now includes supplemental temperature data. The clocks keep my same design between the static and interactive versions.

The static version includes clocks for each date. It also includes overall clocks and comparisons grouped by weekday and temperature. Date links help users navigate the page.
<img width="1470" height="813" alt="static" src="https://github.com/user-attachments/assets/806f4525-c251-492f-a3be-1b4b4395b7bb" />


The interactive version uses a clickable calendar. Selecting a date updates the school and gym clocks. There is also a drop down menu that is clickable and shows the exact observations. Calendar shows the number of visits at each location. Dates without observations are marked “No visits.” Clocks are only shown for locations observed on the selected date.
<img width="1470" height="652" alt="interactive2" src="https://github.com/user-attachments/assets/a1679d35-bb87-4949-ab3f-f30bedd7be55" />
<img width="2940" height="1584" alt="image" src="https://github.com/user-attachments/assets/09d10ceb-51c0-48a2-ba9c-65271e50a3ff" />
<img width="2940" height="508" alt="image" src="https://github.com/user-attachments/assets/7608773b-b80d-4f10-a923-c548b5740cc9" />


This interaction allows users to examine daily changes and comparing visits on particular dates. I expect the calendar selection to reduce the effort of finding a date compared with searching through the static views. MY evaluation will investigate the tradeoffs between both observations.

Both versions use the same clocks, colors, and scales. This keeps the design consistent while only changing how users access information. 


### Remote study implementation

For remote evaluation, I ported the static clocks and interactive calendar to a GitHub Pages website using HTML, CSS, and JavaScript. Both versions use the same 159 observations and clock scales. Static includes date-specific clocks without an observation-table dropdown. Interactive lets participants click calendar dates and optionally expand exact values. The website assigns condition order and task variants, times tasks after a Start button, and lets participants copy their results into a Google Form without names or emails. A backup CSV download is available; the website has no central response database. The answer key and scoring script are separate from the participant website. The remote procedure and its limitations are documented in study-materials.

## Task 2

My evaluation will ask whether the interactive calendar helps people compare parking availability faster and more accurately than the static clocks. My hypothesis is that selecting dates will reduce completion time and increase accuracy. Each participant will use both versions and answer two questions for each.

**Set A:**

1. At the gym, which date had the larger increase in percentage available from its first to last recorded visit: October 7 or October 9? Correct answer: October 7.
2. At school, from the first recorded visit that day to the lowest recorded availability between 09:00 and 16:00 inclusive, which date had the larger decrease in percentage available: October 22 or October 23? Correct answer: October 22.

**Set B:**

1. At the gym, which date had the larger increase in percentage available from its first to last recorded visit: October 12 or October 14? Correct answer: October 14.
2. At school, from the first recorded visit that day to the lowest recorded availability between 09:00 and 16:00 inclusive, which date had the larger decrease in percentage available: October 26 or October 27? Correct answer: October 26.

These questions require comparing changes across two dates. This lets me examine whether calendar selection speeds up finding the relevant observations.

Five participants will start with the static view and five with the interactive view. P01–P03 will use static with Set A, then interactive with Set B. P04–P05 will use static with Set B, then interactive with Set A. P06–P07 will use interactive with Set A, then static with Set B. P08–P10 will use interactive with Set B, then static with Set A. Using different sets reduces the chance of remembering an answer from the previous condition.

Everyone will receive the same explanations and instructions. Participants will select one date as their final answer. The website starts timing when they click Start task and stops when they submit their answer. Each question has a three-minute limit. Correct answers receive 1 point; incorrect answers, skips, and timeouts receive 0. I will record participant codes, question variants, answers, accuracy, completion times, and interaction records. This will be a remote study. After completion, participants will copy their results into a Google Form and optionally provide feedback. The form does not collect names or email addresses or require sign-in. I will not keep a list linking codes to names.

## Task 3

The pilot was run with my brother, who is not part of the ten main participants. It was done in person and timed manually, rather than remotely through the website timer. He mistook the bottom gap in the clocks for missing data. He also had to scroll between dates in the static view and did not use the table view. He filled out the form, but the pilot did not test the full process of copying and submitting results from the website.

After the pilot, I added an explanation to both views stating that the bottom gap is outside the displayed time range and does not represent missing observations. The static view still requires scrolling or using its date links, and the interactive table remains optional. These differences will be considered when interpreting the main study.

I also tested the website separately using a software-only pilot code. The final screen copied all four result rows, including completion times, and the Google Form accepted the pasted text. The test fields were cleared without submitting a response. This was a technical check, not another participant pilot.

## Task 4
I observed 10 participants with four tasks each for a total of 40 results. Each participant answered two questions with each view. There were 39 answers with one participant timing out for one question. A correct answer was worth 1 point. Both incorrect answers and timeouts received 0 points. The answer key was T1A: October 7, T1B: October 14, T2A: October 22, and T2B: October 26.

The static view had 16/20 correct for 80% accuracy. The interactive view had 15/20 or 75%. 9 participants had the same accuracy in both views. P07 answered both static questions correctly but only one interactive question correctly. This shows that the accuracy was skewed by one answer, not necessarily showing a trend.

<img width="1680" height="1126" alt="image" src="https://github.com/user-attachments/assets/afa3f807-66b5-4adb-b478-ecc93c0aa4b2" />

| Measure | Static | Interactive |
|---|---:|---:|
| Completed answers | 19 | 20 |
| Timeouts | 1 | 0 |
| Average time | 62.2 seconds | 48.9 seconds |
| Median time | 54.2 seconds | 41.0 seconds |
| Standard deviation | 39.5 seconds | 24.5 seconds |
| Median time for correct answers only | 49.6 seconds | 42.3 seconds |

<img width="1684" height="1010" alt="image" src="https://github.com/user-attachments/assets/459f4240-752b-4831-bdc9-884263f61191" />

The time plot shows every attempt and marks the timeout with a single triangle. Using each these averages can see that 6 participants were faster with interactive and 4 were faster with static. The average difference was 19.2 seconds faster with interactive.

For the gym increase questions the static accuracy was 70% and interactive accuracy was 80%. Average completed time was 60 seconds for static and 55.8 seconds for interactive. For the school decrease questions, static accuracy was 90% and interactive accuracy was 70%. Average completed time was 64.1 seconds for static and 41.9 seconds for interactive. Interactive was faster on average for both question types, however there was lower accuracy. 

All five static first participants were faster with the interactive. 4/5 interactive first participants were faster with static. This can show that familiarity may have influenced the times.

In conclusion the results support my hypothesis which was that interactive had lower average times, but it did not improve accuracy. 

## Task 5

The interactive calendar helped participants find specific dates faster, however it did not improve accuracy. Most participants selected a date with the hyperlinks instead of scrolling through the clocks. 4 participants were faster with static, this can be a result of having practice with the question on the first set, not necessarily that this view was better.

One thing that surprised me was that the order in which they did interactive or static had an effect on the results. All 5 participants who started with static were faster with interactive afterward. 4/5 who started with interactive were faster with static afterward. I believe this is because they gained familiarity with the clocks and the questions. I received feedback stating that the clocks were confusing which leads me to believe that they were confused at first but by the second round they were more comfortable with them. This makes it difficult for me to separate practice with actual results on which view is better. In the future I can have more variation with the questions, to remove that practice factor and focus more on visualization accessibility.

The feedback showed that finding dates and understanding the clocks were two different problems. Many participants preferred the calendar, but also wanted labels on them. Some participants also needed to reread the questions. One participant did not initially realize that more static plots were available by scrolling.

Learning from all of this, I would add percentage labels directly to the rings, have more visibility on the fact that the data is scrollable, and simplify the question wording. I would also let users select two dates and display their clocks side by side. This could keep the calendars navigation while also reducing the need to switch between dates and remember earlier values. This would fix the problem of not being able to directly compare results which I believed influence the completion time. 

This study definitely had its limitations. The biggest being two questions per view, which could have factored into the familiarity issue this study faced. All the people tested were tech savvy, which could have skewed the results since all had vast experience with reading graphs and using a computer. Branching out to other demographics such as older people would give me a better idea of what actually works and what doesn't. The wording of the questions was also something that was brought up, I have to make the tasks clearer so people focus more on completing the tasks rather than trying to understand what they are asking. The tasks focused on a single variable which was availability. Having questions that require all the attributes would allow me to test all my data rather than just a specific value. I will continue developing the interactive calendar because it helped with finding dates and had lower average times. The results showed that faster navigation did not guarantee more accurate answers.
