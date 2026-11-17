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
