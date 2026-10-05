# Parking Availability at School and the Gym
CS424 — Assignment 1

## Task 1: Observation and Data Collection Plan
I chose to study parking availability at school and at my gym because these are places I regularly visit by car. I am interested in how parking availability differs between the two locations and how it changes across days and times. 

Domain Questions
Which location has a higher percentage of open parking spaces during my visits?
How does parking availability differ between earlier and later observations at each location?
How does availability change across days at similar observation times?
Which location has more consistent parking availability?

Data Collection Process
One observation represents the number of open parking spaces at one location at a specific date and time. At school, I count all 45 spaces in the observed parking area: 23 on the left side and 22 on the right side. This area will remain the same for each observation at school. At the gym, I observed an area containing 34 spaces. In this case it is the third floor where I park. I use the same spaces each time to keep the counts comparable. For each observation, I record the location, date, time, and number of open spaces. Because the two areas have different capacities, I calculate the percentage of spaces open. My data collection is from September 24 through October 1, 2026, and contains 22 observations across seven days: 13 at school and nine at the gym. School observations range from 7:30 a.m. to 4:45 p.m., while gym observations range from 9:40 a.m. to 8:15 p.m. These times are comparable to each other since it provides a range from morning to afternoon. 
I chose these locations because they are part of my routine, allowing me to have constant observations. Collecting at two locations across multiple days and times allows for  meaningful variation. There is also variation across days which accounts for MWF and TTH schedules.
I am working alone.

Data Dictionary

Attribute      Type            Description                    Example
Location    Categorical    Parking area observed              School
  date        Temporal      Date of observation              2026-09-24
  Time        Temporal        observation time                 14:48
total_spaces Quantitative  Number of spaces in area              45
open_spaces   Quantitative  Number of spaces  open                5
percent_open  Quantitative  Open spaces/total spaces * 100       11.1%

Limitations and Potential Bias
My data collection is from my regular visits rather than a set sampling schedule. School and gym observations occur at different times, so differences between locations could partly reflect time of day. Some days also have more observations than others and will have greater influence on summaries.
Each observation captures one moment. It does not show how long vehicles stay or how long drivers search for parking. 

##Task 2: Pilot and Data Collection
I have not finished collecting my data as that will span all the way to the end of the project. My pilot data was an entire week. Using the same parking areas for every count helped keep my observations consistent. Recording dates and times also allowed for comparisons across visits. I can clear up what "open" means including rules for handling empty spaces that are blocked by bad parkers, since there are a lot of those. My observations do not distinguish these situations.

The main limitation was my observation schedule. School and gym observations happened at different hours. Collection was also uneven some days had several observations, while others had only one.

For future collections, I can clarify the definition of an open space. I can get more observations of both locations within similar time windows across several days. 

Collected Data

I collected 22 observations across seven days between  9-24 and  10-1. 13 at school and 9 at the gym. At school, I counted all 45 spaces: 23 on the left side and 22 on the right side. At the gym, I observed the same area of 34 spaces, the third floor where I park. I completed the collection individually and recorded the counts in a notes log. School availability ranged from 0 to 28 open spaces. Gym availability ranged from 19 to 29. Because the areas have different capacities, I will compare percentages of open spaces.

##Task 3 Data description and domain questions
My dataset contains 22 parking observations collected across seven days between September 24 and October 1, 2026. There are 13 observations of a 45 space at the HLPS Lot and 9 observations of a 34 space third floor parking area at the LA Fitness on Ashland and Belmont. I manually counted open spaces and recorded the location, date, and time. The dataset also includes each location’s capacity which allows me to calculate the percentage open.

The observations capture variation across locations, days, and times. School counts ranged from 0 to 28 open spaces, while gym counts ranged from 19 to 29. The observations follow my personal schedule and are uneven. This is a potential bias. School and gym were often observed at different hours. Clarified using AM or PM. Will start recording in a 24hr format to remove that label and allow for a more clean csv file. Will include label to see if any spots were "open" but blocked by bad drivers.

Converting each count into a percent allows me to better compare observations since both lots have different capacities. Focusing on only parking spots limits me since it doesn't include time searching for parking, or how long people actually stay. There can be people waiting in their car to leave but still get marked down as "occupied".

Revised Domain Questions
1. How does the percentage of open spaces differ between school and the gym during the observed visits?
This comparison could reveal differences in the parking availability encountered. It will also allow me to use observations collected by other individuals willing to record more data.  I will use location, open_spaces, and total_spaces to compare percentage availability.

2. How does parking availability vary with time of day at each location?
This question explores whether early and late observations show different availability. I will use time, location, date, and the percentage of open spaces. 

3. How does availability differ across days at similar observation times?

This can allow for distinction in schedules for those with MWF or TTH schedules, which is more popular based on parking availability.

4. Which location shows greater variation in the percentage of open spaces across observations?

I will compare the spread of percentage availability within each location using location, open_spaces, and total_spaces. This will describe variation in my sample rather than  which location is more predictable.

These questions still focus location and timing along with consistency. 

##Task 4: Task abstractions
How does the percentage of open spaces differ between school and the gym during the observed visits?
Action: Compare
Target: Distribution of % availability by location
Abstract: Compare values across locations
Reasoning: The main action is comparing two groups (locations) based on quantities (open spaces)

How does parking availability vary with time of day at each location?
Action: Explore relationships
Target: Observation time and percentage availability in each location
Abstract: Explore the relationship between time and a value grouped by location.
Reasoning: The main action is comparing relationships between time and availability.

How does availability differ across days at similar observation times?
Action: Compare
Target: Availability on different dates within the same location and time
Abstract: Compare values across dates holding category and time consistent.
Reasoning: The main action is holding the location and time consistent.

Which location shows greater variation in the percentage of open spaces across observations?
Action: Compare variability
Target: Spread of percentage availability within each location
Abstract: Compare the spread of value distributions across categories.
Reasoning: The main action is comparing variability.

Identifying the comparisons and relationships allows me to see what exactly I need to collect and compare. It makes it easier to see which visualizations I will need.

##Task 5:
<img width="4520" height="4284" alt="IMG_6398" src="https://github.com/user-attachments/assets/cb02745b-9714-4649-8077-6031f7f86218" />

Two calendars. One for school and one for the gym. In each date box, add a circle for every observation with its time. Write the percentage next to it. Leave dates without observations labeled not observed. This helps compare locations and dates. 
This design places observations into calendar boxes, separated by location. Each observation uses a circle mark, with text for percentage. The design shows comparisons across locations, dates, and time slots. It also makes gaps in data collection visible. 


##Task 6 Summarizing (For the sake of time I have first brainstormed the visualizations then I will create them.

My designs show parking availability from three views: observations across daEach emphasizes different aspects of the same dataset.

The calendar shows exactly when observations occurred. It allows for comparisons across days and makes missing data visible. Days with many observations can become too crowded. 

The clock shows observations from different dates grouped together by time of day. This could help show similarities between observations taken at similar times. The layout is similar to a pie chart where the angle changes on quantity. The downside is that the radius are difficult to compare if there are similar values. 

The strip plot shows the clearest comparison of availability and variation between locations. A shared scale accounts for the different parking capacities between lots, while dots show repeated values. Its main weakness is that it gives less emphasis to dates and times. 

The designs address the four domain questions. The calendar and strip plot compare availability between locations. The clock and calendar explore timing, while the calendar supports comparisons at repeated time slots across days. The strip plot makes differences in spread easy to read. 

Showing individual observations and missing periods makes the gaps more visible. With a larger dataset, the calendar and clock can become crowded

##Task 7 
Did it by myself, maybe regret it




  
