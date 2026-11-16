## Task 1: Implementing interaction

I continued with the school and gym clocks from Assignment 2 and made static and interactive versions of them using R and Shiny. Both versions use  the same updated data, ending the data collection on 11/10/2026. The data now includes supplemental temperature data. The clocks keep my same design between the static and interactive versions.

The static version includes clocks for each date. It also includes overall clocks and comparisons grouped by weekday and temperature. Date links help users navigate the page.
<img width="1470" height="813" alt="static" src="https://github.com/user-attachments/assets/806f4525-c251-492f-a3be-1b4b4395b7bb" />


The interactive version uses a clickable calendar. Selecting a date updates the school and gym clocks. There is also a drop down menu that is clickable and shows the exact observations. Calendar shows the number of visits at each location. Dates without observations are marked “No visits.” Clocks are only shown for locations observed on the selected date.
<img width="1470" height="652" alt="interactive2" src="https://github.com/user-attachments/assets/a1679d35-bb87-4949-ab3f-f30bedd7be55" />
<img width="1470" height="811" alt="interactive" src="https://github.com/user-attachments/assets/565130be-0d7d-42ea-888e-c81e6ce0193a" />

This interaction allows users to examine daily changes and comparing visits on particular dates. I expect the calendar selection to reduce the effort of finding a date compared with searching through the static views. MY evaluation will investigate the tradeoffs between both observations.

Both versions use the same clocks, colors, and scales. This keeps the design consistent while only changing how users access information. 
