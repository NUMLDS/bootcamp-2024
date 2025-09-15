nys_schools <- read.csv("~/MLDS_Bootcamp2024/r_bootcamp_day7/data/nys_schools.csv")
View(nys_schools)
nys_acs <- read.csv("~/MLDS_Bootcamp2024/r_bootcamp_day7/data/nys_acs.csv")
View(nys_schools)

library(dplyr)
library(ggplot2)
library(summarytools)

# Display the first few rows of the dataset
head(nys_schools)
head(nys_acs)

# Get a summary of the dataset
summary(nys_schools)
summary(nys_acs)

# Check for missing values
colSums(is.na(nys_schools))
colSums(is.na(nys_acs))

# Check for -99
colSums(nys_schools == -99)
colSums(nys_acs == -99)  

