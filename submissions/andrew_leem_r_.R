# define poverty 
# county school distribrution ? 

library(tidyverse)
library(dplyr)
summary(nys_schools)
summary(nys_acs)
unique(nys_schools$county_name)

# Task 3 
# 1. deal with missing values, getting rid of -99 
nys_schools1 <- nys_schools %>%
  filter(county_name != -99)

# 2. recoding the poverty groups? what makes sense? 
# Assuming 'nys_schools' has a column 'poverty_rate' representing the poverty rate in each county
# Load necessary library
library(dplyr)


# Splitting up into poverty groups here...
# 0.1, 0.15, > 0.15
# looking at the histogram as a reference to divide 

nys_acs1 <- nys_acs1 %>%
  mutate(
    poverty_group = case_when(
      county_per_poverty < 0.10 ~ "low",
      county_per_poverty >= 0.10 & county_per_poverty < 0.15 ~ "medium",
      county_per_poverty >= 0.15 ~ "high"
    )
  )

library(dplyr)

# Assuming both datasets have a 'name' column for county name
nys_schools1 <- nys_schools1 %>%
  left_join(nys_acs1, by = "county_name")

# Summarize data for each county
# Task 5.1. For each county: total enrollment, percent of students qualifying for free or reduced price lunch, and percent of population in poverty.

county_summary <- nys_schools1%>%
  group_by(county_name) %>%  # 'name' is the column for county name
  summarize(
    total_enrollment = sum(total_enroll, na.rm = TRUE),
    percent_free_lunch = mean(per_free_lunch, na.rm = TRUE),
    county_per_poverty = mean(county_per_poverty, na.rm = TRUE)
  )


