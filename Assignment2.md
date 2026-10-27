##Task 1: Revisit your data and questions
The updated data set has grown from the original observations up to 89 visits. It will keep growing as the project continues. The data now inclues data for blocked parking spaces in the case of bad drivers. My guiding questions remain similar changing one to fit the new "inaccesible" data:

-How does the percentage of accesible spaces differ between the two locations durign the recorded visits?

-How does availability vary with time of day and weekday/holiday within each location?

-When were inacessible spaces recorded, and how long were they present for?

This larger data set extends my previous observations and adds the inaccessible attribute. To better explain, inaccessible means the space was available but unusable due to double parking at the time of recording. I have also recruited the help of someone to help me record more observations per day. I have also started recording disability/reserved spots, these will be included in the next part of the project. These additions are meant to address the limited coverage of the data. This will help achieve more meaningful data analysis.

##Task 2: Prepare the data
The data was cleaned and formatted into a csv format for the best readability. The parking_data.csv file in the repo has been updated to reflect these changes and alos my new data and attributes. I record the data in a table format on my phone and then change it into csv format. I wrote a small java scrip that helped me clean my data further. The code takes my original csv that I took on my notes app and cleans it. It formats the data into YYYY-MM-DD format for better readibility. It also standardizes time into millitary format to remove the need for AM and PM. It also lists the capacity so it is easier to read and compare what is available. Lastly, it provides the calculates the percentage so that you can easily read how much capacity was available at a given time. Percentage is calculated by (accessible / capacity) * 100.

##Task 3: Explore the data
For task 3 I created two plots using RStudio. I imported my csv and used it create a plot that plots the percent available against the time of day. Both school and gym are plotted on the same graph to be able to visually compare both locations. I used circles and squares as my marks to distinguish both locations. I notice that the school observations show an X^2 graph centered around 12pm, and availability slowly increases after 2pm. Something unusual I notice at 3pm there is a wide gap where one day there was 60% availability when the average is usually 25%. Understanding the context of what day it was can help me better understand why that day was an outlier. Im surprised with the range of availability for the gym even at the same time. This follows my patter I noticed that Mondays tend to be the busiest at the gym at 6pm, which is weird because people don't like Mondays.

My second plot is used to supplement my first plot to help understand the patterns. The second plot shows when my observations were recording, plotting Time against Day. Sundays have not data because I don't go to the gym nor do I go to school. This is something I can clean with my data later so I dont include an unnecesary day in my data which has no values. This plot shows patterns in my schedule. It basically shows when I go to school, go out for lunch, and go to the gym. I think none of the observations are misleading with the range of data I have, I accurately depict morning, afternoon, and evening routines.

Aggregation would hide important differences. ALot of this data shows patterns in routines based on weekday, time, and location. Like I mentioned before Mondays seem busiest at the gym and averaging this across the same time on different days would hide this unusual patter. Showing the individual observations preserves these outliers. I think the transformation I did in Task 2 is sufficient for what I am trying to observe. When I add more data, I will have to do more transformations. Exploration helped make my questions more specific. Focusing more on time of day and how it affects availability. I may also include a supplemental data set to observe more specifc patterns. If I also include weather data I can also observe how weather affects availability in parking lots.

 ##Task 4: Implement visualization alternatives
Strip Plot: This plot is a quick visual to see how many observations there are at each percentage level of capacity. Each location gets its own row. Each dot represents one signe visit. Horizontal position is the percent available. Stacking avoids clutter. I chose this plot because it provides a quick insight on the locations capacties. It doesn't show dates or times, so this is more so just an overview of the data. I could pair it with something that has dates and times or maybe I will ultimately drop it
<img width="973" height="1096" alt="image" src="https://github.com/user-attachments/assets/d0dbdec0-e0b5-4a6f-8d7d-00ac38db04d4" />

Clocks: I refined my original sketches since they had alot of wasted space. I cut them into shorter clocks that only have the time range of my data. This allows for more spacing with repeated values. Dots are visits, angle is time, and the distance from the center represents the capacity available. Inner ring is 0% while last ring is 100%. I tried this design because I believed it showed the most important data which is time and capacity. Patterns are visible but there is still some overlap. However, it is an improvement from my sketch.
<img width="973" height="1096" alt="image" src="https://github.com/user-attachments/assets/af25914f-8636-4327-aa69-06891088e891" />
<img width="973" height="1096" alt="image" src="https://github.com/user-attachments/assets/e4a79972-be41-4fa6-a311-87092bee3c1f" />

Calendar: This one is my favorite along with the clock. These are both things that people use day to day meaning they are able to quickly read them and understand them. It organizes the visits by date, with each date showing time location and percent available. It shows all the data in a clear and easy way to read. The downside is that data is not easily comparable. You have to read to get the data. I do believe it is a good complement to the previous plots though.
<img width="973" height="1096" alt="image" src="https://github.com/user-attachments/assets/2c36fc4f-18e1-41d4-afcf-5c13cf98e0ab" />

##Task 5: Interaction and multiple views
I have decided to do the clocks and calendar together because they complement eachother very well. The clocks show how availability changes with time of day. I believe that having an interaction between both would be helpful. Allowing the user to click two dates on the calendar and compare the clocks for both days would solve the comparison issues I currently have with the calendar. The strip plot is a good overview if you just want to see capacity, sort of like the Google Maps "busy" indicator. However, I'm going to continue developing the clock and calendar into one visualization. Selecting a point on the clock can highlight the entry in the calendar. These features are not implemented yet, but can help. I believe for my project an interaction element is necessary to be able to compare the data.

##Task 6: Iterate and refine
My visualization have been refined through assignment 2. The changes I have made have been to increase readability and reduce clutter.
Iteration 1: 
Originally I had side by side clocks created using RStudio. However, the downside to this was that it made the clocks smaller and created clutter. To resolve this I split the clocks into their own plots. This allowed for bigger clocks and increased readability. To further help I added tick lines to the clock to better estimate the time of observations. I took this a step forward by adding ticks in between the hours to give more room to estimate. Lastly, I added a legend that describes what each ring represents in the clock. I kept the 0% ring from Assignment 1 as it helped reduced clutter. I may add more rings however, I need to to find a balance where I don't just change from cluttered dots to cluttered rings.

Iteration 2:
Probably the most important iteration in my visualization was the reduction of the clock to only display the minimum and maximum hours of my data. Technically they are no longer clocks, but they function very similarly. Originally I used a 24-hr scale clock even though there was unused space for about half of it, notably at night and in the early mornings. I changed the scale for school down to 6:00 to 20:00. For gym I reduced it down to 9:00 to 21:00. This drastically improved readability since it allowed the plotted data to use more space. There is still clutter where it overlaps but it is more readable and not just a blob of points. I believe increasing the spacing between the rings would also help spread the data more. Overlaps would still occur but they would be more distinguishable.

##Task 7
I would like to continue pursuing the clocks supported by the calendar. I still need to workout which will support which as it works well both ways, maybe I will have it work both ways. The clock demonstrates how parking availability changes with time of day at each location. The calendar supports this by allowing the user to lookup dates times and percentages for each visit. These two views complement eachother and having them interactively linked would help explore the data.

Compared to my sketches these are more flushed out. The clocks are their own individual plots. The clocks were also reduced to only display the times where data is actually observed. The addition of the 0% ring was also fully implemented from my second round of sketches from assignment 1. The radius lines and hour ticks improve readability. The calendar is also fully implemented. In the sketches it looked to cluttered, but I was able to neatly organize the information for better access. 

I think having these two together works well since one plot supplements the flaws of the other, while also working well individually. I'm still insure how to fix the overlaps with the clocks. I can something similar to the strip plot where repeated observations stack. This wouldn't work since positioning matters so maybe I can use color to represent different amounts of repeated observations.

In Assignment 3, I want to evaluate whether users can read approximate times and percentages and use the calendar to investigate the clock observations. 










