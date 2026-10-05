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



  
