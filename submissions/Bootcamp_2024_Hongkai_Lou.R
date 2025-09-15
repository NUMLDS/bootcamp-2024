indexs <- unique(which(nys_schools == -99, arr.ind =  T)[,1])
nys_schools_removena <- nys_schools[-indexs,]
sum(nys_schools$district_name > 0)
nys_acs_bycounty <- nys_acs %>%
  group_by(county_name)%>%
  summarise(median_per_county = mean(median_household_income))
percentiles <- quantile(nys_acs_bycounty$median_per_county, probs = c(.33,.66,1))
percentiles
nys_acs_bycounty$poverty_score <- cut(nys_acs_bycounty$median_per_county,
                                 breaks = c(-Inf, percentiles[1], percentiles[2], percentiles[3]),
                                 labels = c("Low", "Median", "High"))
nys_acs_countyranked <- left_join(nys_acs, nys_acs_bycounty, by = c('county_name'))
nys_school_zscore <- nys_schools_removena %>% 
  group_by(year) %>%
  mutate(z_score_math = (mean_math_score - mean(mean_math_score))/sd(mean_math_score),
         z_score_ela = (mean_ela_score - mean(mean_ela_score))/sd(mean_ela_score))
merged_nys <- right_join(nys_school_zscore, nys_acs_countyranked, by = c('county_name', 'year'))
poverty_district <- merged_nys %>%
  select(county_name, year, total_enroll, per_free_lunch, per_reduced_lunch, z_score_ela, z_score_math, poverty_score)%>%
  group_by(county_name, poverty_score) %>%
  summarise(free_lunch = (sum(total_enroll*per_free_lunch))/sum(total_enroll),
            reduced_lunch = (sum(total_enroll*per_reduced_lunch))/sum(total_enroll),
            z_score_ela_county = mean(z_score_ela),
            z_score_math_county = mean(z_score_math))
poverty_district_byyear <- merged_nys %>%
  select(county_name, year, total_enroll, per_free_lunch, per_reduced_lunch, z_score_ela, z_score_math, poverty_score)%>%
  group_by(county_name, year,poverty_score) %>%
  summarise(free_lunch = (sum(total_enroll*per_free_lunch))/sum(total_enroll),
            reduced_lunch = (sum(total_enroll*per_reduced_lunch))/sum(total_enroll),
            z_score_ela_county = mean(z_score_ela),
            z_score_math_county = mean(z_score_math))
lm1_ela <- lm(data = poverty_district, z_score_ela_county ~ poverty_score + log(free_lunch) + log(reduced_lunch))
lm1_math <- lm(data = poverty_district, z_score_math_county ~ poverty_score + log(free_lunch) + log(reduced_lunch))
summary(lm1_ela)
summary(lm1_math)
par(mfrow = c(2, 2))
plot(lm1_ela)
