library(nycflights13)
library(dplyr)
library(lubridate)

View(flights)
## Q1 Which are origins airports? 
## What are the top 5 destinations of origins airports?

flights %>%  
	count(origin)

df1 <- flights %>%  
	select(origin , dest) %>%  
	filter(origin == "EWR") %>%  
	count(origin, dest ) %>%  
	arrange(-n) %>%  
	head(5)

df2 <- flights %>%  
	select(origin , dest) %>%  
	filter(origin == "JFK") %>%  
	count(origin , dest) %>% 
 arrange(-n) %>%  
	head(5)

df3 <- flights %>%  
	select(origin , dest) %>%  
	filter(origin == "LGA") %>% 
	count(origin, dest) %>%  
	arrange(-n) %>%  
	head(5)

list_df <- list(df1, df2, df3)
airport_df <- bind_rows(list_df

)View(airport_df)

df4 <- airports %>%  
	select(faa, name)

airport_df <- airport_df %>%  
	inner_join(df4 , by = c("dest" = "faa" ))

View(airport_df)

##Q2 How many flights are there in the US? 

flights$flight <- as.character(flights$flight)
	class(flights$flight)

avg_per_month <- flights %>%  
	group_by(day , month) %>%  
	count(flight) %>%  
	summarise(per_day = sum(n))

avg_per_month %>%  
	group_by(month) %>%  
	summarise(avg_per_day = mean(per_day))

##Q3 If i will go to "Red Tour" Taylor Swift's concert  
## Concert detail : at Amway center, Orlando at 6 pm on april 12th  
## Which flight can I take on 12 april? 

flights$month <- month(flights$month ,label = TRUE , abbr = FALSE)

orlando_flight <- flights %>%  
	select(month, day , origin , carrier , dest , 
  sched_dep_time , sched_arr_time , dep_time, dep_delay , 
	arr_time , distance) %>%  
	filter(month == "April" & dest == "MCO" & day == 12 
	& arr_time < 1600 & dep_delay < 60 
	& sched_dep_time < 1200 ) %>%  
	arrange(arr_time) %>%  
	left_join(airlines)

View(orlando_flight)    

##Q4 In 2023, are there any airline delay, and how frequent?

flights %>%  
	select(carrier , arr_delay ,month) %>%  
	filter(arr_delay > 0) %>%  
	group_by(carrier) %>%  
	summarise(avg_delay = mean(arr_delay) ,             
						n = n()) %>%  
	arrange(desc(n)) %>%  
	inner_join(airlines)


## Q5 What are the longest distance flight and the shortest distance flight 
## And How long do those flight take?

df4 <- airports %>%  
	select(faa, name)


flights %>%  
	select(origin , dest , distance , air_time ) %>%  
	mutate(airtime_hour = air_time/60) %>%   
	arrange(desc(distance)) %>%  
	inner_join(df4 , by = c("dest" = "faa")) %>%  
	head(1)



flights %>%  
	select(origin , dest , distance , air_time ) %>%  
	mutate(airtime_hour = air_time/60) %>%   arrange() %>%  
	inner_join(df4 , by = c("dest" = "faa")) %>%  
	head(1)
