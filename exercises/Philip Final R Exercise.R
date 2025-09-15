# Importing packages

library(dplyr)
library(ggplot2)

# Importing data sets

nys_acs <- read.csv("D:/Northwestern MLDS/Bootcamp/R-bootcamp-2024/data/nys_acs.csv")


nys_schools <- read.csv("D:/Northwestern MLDS/Bootcamp/R-bootcamp-2024/data/nys_schools.csv")


# Checking for missing values and cleanign the DF

nys_schools <- nys_schools[!apply(nys_schools == -99, 1, any), ]


#  Adding new column for poverty categories

nys_acs <- nys_acs %>% 
  mutate(poverty_level = case_when(
    county_per_poverty < quantile(nys_acs$county_per_poverty)[2]  ~"Low",
    county_per_poverty >= quantile(nys_acs$county_per_poverty)[2]  & county_per_poverty <= quantile(nys_acs$county_per_poverty)[3]  ~"Medium",
    county_per_poverty >= quantile(nys_acs$county_per_poverty)[3]  ~"High",
  ))


# GRouping by year 


# Function for calc z score:

calc_z <- function(values){
  
  m = mean(values)
  sd = sd(values)
  
  z = (values - mean) / sd
  
  return(z)
  
}

nys_schools <- nys_schools %>%
  group_by(year) %>%
  mutate(z_score = scale(mean_ela_score))






#  PLotting


ggplot(data = nys_schools) +
  geom_point(mapping = aes(x=per_free_lunch, y = mean_ela_score)) + 
  labs(title = 'Free Lunch vs ELA Score', x = 'per_free_lunch', y = 'mean_ela_score')


