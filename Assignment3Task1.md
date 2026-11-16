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
