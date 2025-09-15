
# Step 1

getwd()
library(dplyr)
nys_acs <- read_csv("Desktop/MLDS-bootcamp/final/nys_acs.csv")
nys_schools <- read_csv("Desktop/MLDS-bootcamp/final/nys_schools.csv")

str(nys_schools)
str(nys_acs)

summary(nys_schools)
summary(nys_acs)

colSums(is.na(nys_schools))
colSums(is.na(nys_acs))

# Step 1 Task 3.1:

# check what's NA
colSums(nys_schools == -99)
colSums(nys_acs == -99)

# turn -99 to NA
nys_schools[nys_schools == -99] <- NA
colSums(is.na(nys_schools))

# Task 3.2
mean_county_poverty <- nys_acs %>%
  group_by(county_name) %>%
  summarize(mean_poverty = mean(county_per_poverty, na.rm = TRUE))

mean_county_poverty <- mean_county_poverty %>%
  mutate(poverty_group = cut(mean_poverty, 
                        breaks = quantile(mean_poverty, probs = c(0, 1/3, 2/3, 1), na.rm = TRUE), 
                        labels = c("low", "medium", "high")))

table(mean_county_poverty$poverty_group)

# Task 3.3
nys_schools <- nys_schools %>%
  group_by(year) %>%
  mutate(
    math_z = scale(mean_math_score, center = TRUE, scale = TRUE),  # Z-score for Math
    ela_z = scale(mean_ela_score, center = TRUE, scale = TRUE)     # Z-score for ELA
  )

# Task 4
left_joins <- left_join(nys_acs, nys_schools, by=c("county_name", "year"))
# right_joins <- right_join(nys_acs, nys_schools, by=c("county_name", "year"))

all_table <- left_join(left_joins, mean_county_poverty)

# Task 5
core_data <- all_table[c("county_name", "school_name", "year", "poverty_group","per_free_lunch", "ela_z", "math_z")]

plot_table <- core_data %>% 
  na.omit() %>% 
  group_by(poverty_group) %>% 
  summarise(ela_avg = mean(ela_z, na.rm=T),
            math_avg = mean(math_z, na.rm=T))
  
plot_table

# Reshape data
data_long <- plot_table %>%
  pivot_longer(cols = c(ela_avg, math_avg), names_to = "subject", values_to = "avg_score")

# Plot histogram
ggplot(data_long, aes(x = poverty_group, y = avg_score, fill = subject)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  labs(title = "ELA and Math Averages by Poverty Group", x = "Poverty Group", y = "Average Score") +
  scale_fill_manual(values = c("lightblue", "lightgreen"), name = "Subject", labels = c("ELA", "Math")) +
  theme_minimal()
