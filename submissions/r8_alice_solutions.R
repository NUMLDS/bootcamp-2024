### 0. Clear environment, set working directory, new R script / notebook
### Load libraries
library(dplyr)
library(ggplot2)

### 1. Import Data (5 min)
schools <- read.csv("data/nys_schools.csv", stringsAsFactors = FALSE)
counties <- read.csv("data/nys_acs.csv", stringsAsFactors = FALSE)

### 2. Explore Data (5 min)
summary(schools) # Check for issues (e.g., -99 in test scores)
summary(counties)

### 3. Clean Data (30 min)
### Group brainstorm:
# - Dealing with missing values
# - Categorizing data
# - Understanding z-scores

# Identify character and numeric columns
char_columns <- names(schools)[sapply(schools, is.character)]
num_columns <- names(schools)[sapply(schools, is.numeric)]

# Extract relevant columns
schools_char <- schools[c("school_name", "district_name", "county_name", "region")]
schools_num <- schools[c("total_enroll", "per_free_lunch", "per_reduced_lunch", "per_lep", "mean_ela_score", "mean_math_score")]

# Replace -99 values
schools_char[schools_char == "-99"] <- ""
schools_num[schools_num == -99] <- NA

# Check for NAs
colSums(is.na(schools_num))

### 3.1 Create a New DataFrame Without -99 Values
schools_clean <- cbind(schools$school_cd, schools$year, schools_char, schools_num)
colnames(schools_clean)[1:2] <- c("school_cd", "year")

### 3.2 Create Poverty Level Groups
# Plot the poverty levels
hist(counties$county_per_poverty)
hist(counties$county_per_poverty, breaks=50)

# Create breaks for poverty levels
counties$poverty_level <- cut(counties$county_per_poverty, 
                              breaks = c(-Inf, 0.075, 0.2, Inf), 
                              labels = c("low", "medium", "high"))

# Check the distribution of poverty levels
table(counties$poverty_level)

### 3.3 Standardized Test Scores
# Calculate mean and standard deviation of scores
scores_std <- schools_clean %>%
  select(year, contains("score")) %>%
  group_by(year) %>%
  summarise(
    ela_mean = mean(mean_ela_score, na.rm = TRUE),
    math_mean = mean(mean_math_score, na.rm = TRUE),
    ela_sd = sd(mean_ela_score, na.rm = TRUE),
    math_sd = sd(mean_math_score, na.rm = TRUE)
  )

# Create z-score columns and remove calculation columns
schools_all <- inner_join(schools_clean, scores_std, by = "year") %>%
  mutate(
    ela_z_score = (mean_ela_score - ela_mean) / ela_sd,
    math_z_score = (mean_math_score - math_mean) / math_sd
  ) %>%
  select(-c(ela_mean, math_mean, ela_sd, math_sd))
  
# Check the final data frame
View(schools_all)

### 4. Merge Data
data <- left_join(counties, schools_all, by = c("county_name", "year"))

# Check dimensions of the merged data
dim(data)

# Check the columns with NULL values
colSums(is.na(data))

# View the rows with NULL values
specific_columns <- c("total_enroll", "per_free_lunch",
                      "per_reduced_lunch", "per_lep")

View(data[rowSums(is.na(data[specific_columns])) > 0, ])

### 5. Create Summary Tables
data_subset <- data[c("county_name", "school_name", "year", "poverty_level", "per_free_lunch", "ela_z_score", "math_z_score")]

# Data Visualization 1: Average Test Scores by Poverty Level
library(reshape2)

data_bar_chart <- melt(data_subset %>%
                         group_by(poverty_level) %>%
                         summarise(
                           ela_avg = mean(ela_z_score, na.rm = TRUE),
                           math_avg = mean(math_z_score, na.rm = TRUE)
                         ),
                       id.vars = "poverty_level",
                       variable.name = "test",
                       value.name = "scores")

data_bar_chart %>%
  ggplot() + 
  geom_col(aes(x = poverty_level, y = scores, group = test, fill = test), position = "dodge") + 
  labs(title = "Test Scores By Poverty Level", x = "Poverty Level", y = "Above or Below Average")

# Data Visualization 2: Average Test Scores by Year and Poverty Level
data_bar_chart_year <- melt(data_subset %>%
                              group_by(year, poverty_level) %>%
                              summarise(
                                ela_avg = mean(ela_z_score, na.rm = TRUE),
                                math_avg = mean(math_z_score, na.rm = TRUE)
                              ),
                            id.vars = c("year", "poverty_level"),
                            variable.name = "test",
                            value.name = "scores")

data_bar_chart_year %>%
  ggplot() + 
  geom_col(aes(x = poverty_level, y = scores, group = test, fill = test), position = "dodge") + 
  facet_wrap(~year, scales = "free") + 
  labs(title = "Test Scores By Poverty Level By Year", x = "Poverty Level", y = "Above or Below Average")

# Final Plot: Test Scores Over Time
data_bar_chart_year %>%
  group_by(year, poverty_level) %>%
  summarise(score = sum(scores)) %>%
  ggplot() + 
  geom_line(aes(x = year, y = score, color = poverty_level), linewidth = 1) +
  labs(title = "Test Scores By Poverty Level Over Time", x = "Year", y = "Score")