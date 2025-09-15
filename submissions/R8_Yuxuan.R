library(dplyr)
library(tidyverse)
library(ggplot2)
summary(nys_acs)
summary(nys_schools)
nys_acs[nys_acs==-99]<-NA
nys_schools[nys_schools==-99]<-NA
sum(is.na(nys_acs))
sum(is.na(nys_schools))
summary(nys_acs)
summary(nys_schools)
nys_schools %>% drop_na()
quantiles <- quantile(nys_acs$county_per_poverty, probs = c(1/3, 2/3), na.rm = TRUE)
nys_acs$poverty_groups <- cut(nys_acs$county_per_poverty, 
                      breaks = c(-Inf, quantiles[1], quantiles[2], Inf), 
                      labels = c("low", "medium", "high"), 
                      include.lowest = TRUE)
nys_acs$poverty_groups
head(nys_schools)
nys_schools <- nys_schools %>% group_by(year) %>% mutate(ela_sca = scale(mean_ela_score), math_sca = scale(mean_ela_score)) %>% ungroup()
data <- left_join(nys_schools, nys_acs, by = c('county_name', 'year'))

summary_table <- data %>%
  group_by(county_name) %>%
  summarize(
    total_enroll = sum(total_enroll, na.rm = TRUE),
    per_disc_lunch = ((sum(per_free_lunch, na.rm = TRUE) + sum(per_reduced_lunch, na.rm = TRUE)) / sum(total_enroll, na.rm = TRUE)) * 100,
    per_pop_in_pov = (sum(poverty_groups==c('high','medium'), na.rm = TRUE) / sum(total_enroll, na.rm = TRUE)) * 100
  )
print(summary_table)

thresholds <- data %>%
  summarise(
    bottom_5 = quantile(county_per_poverty, 0.05, na.rm = TRUE),
    top_5 = quantile(county_per_poverty, 0.95, na.rm = TRUE))
sel_coun <- filter(data, county_per_poverty <= thresholds$bottom_5 | county_per_poverty >= thresholds$top_5) %>%
  mutate(
    per_disc_lunch = ((sum(per_free_lunch, na.rm = TRUE) + sum(per_reduced_lunch, na.rm = TRUE)) / sum(total_enroll, na.rm = TRUE)) * 100,
    per_pop_in_pov = (sum(poverty_groups %in% c('high','medium'), na.rm = TRUE) / sum(total_enroll, na.rm = TRUE)) * 100,
    mean_read = mean(ela_sca),
    mean_math = mean(math_sca)
  )
print(sel_coun)
