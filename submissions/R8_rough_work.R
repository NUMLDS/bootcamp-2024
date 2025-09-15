library(tidyverse)
library(ggplot2)

nys_schools <- read.csv("D:/NU MLDS/Bootcamp/bootcamp-2024-main/data/nys_schools.csv")
nys_acs <- read.csv("D:/NU MLDS/Bootcamp/bootcamp-2024-main/data/nys_acs.csv")


county_year_schools <- nys_schools %>% filter(county_name != "-99") %>% group_by(county_name,year) %>% summarise(count = length(unique((school_name))))
county_schools <- nys_schools %>% filter(county_name != "-99") %>% group_by(county_name) %>% summarise(count = length(unique((school_name))))

county_schools %>% ggplot() + geom_col(aes(x=county_name, y=count), col="black")

year_schools <- nys_schools %>% filter(county_name != "-99") %>% group_by(year) %>% summarise(count = length(unique((school_name))))

nys_schools %>% ggplot() + geom_histogram(aes(y=mean_math_score), col="black") + coord_flip()

nys_schools %>% group_by(year) %>% summarise(mean_math_score = mean(mean_math_score)) #%>% ggplot() + geom_histogram(aes(y=mean_math_score), col="black") + coord_flip()

nys_schools %>% group_by(year) %>% summarise(mean_ela_score = mean(mean_ela_score))

nys_schools %>% filter(per_reduced_lunch != -99) %>% group_by(year) %>% summarise(mean_reduced_lunch = mean(per_reduced_lunch))

nys_schools %>% filter(per_free_lunch != -99) %>% group_by(year) %>% summarise(mean_free_lunch = mean(per_free_lunch))

county_year_schools_mean_math <- nys_schools %>% filter(county_name != "-99") %>% group_by(county_name,year) %>% summarise(mean_math = mean(mean_math_score))

albany <- nys_schools[nys_schools$county_name == 'ALBANY',]

nys_schools %>% pivot_wider(names_from = c(year,school_name),values_from = mean_math_score,values_fn = mean)

