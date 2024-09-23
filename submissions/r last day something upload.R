# Some EDA

names(nys_acs)
names(nys_schools)

str(nys_acs)
str(nys_schools)

summary(nys_acs)
summary(nys_schools)
# Recoding and variable manipulation

## Deal with missing values, which are currently coded as -99.
library(dplyr)
nys_schools<- nys_schools %>% filter(nys_schools,mean_ela_score != -99 & mean_math_score != -99 )

summary(nys_schools)

?filter

nys_schools<- nys_schools %>% filter(mean_ela_score != -99 & mean_math_score != -99.0 )

sum(apply(nys_schools, 2, function(row) any(row == -99)))


table(nys_acs == -99)

?apply