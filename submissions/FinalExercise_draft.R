library(here)
library(readr)
generation <- read.csv(here::here("/Users/lizongzhen/Desktop/MLDS/r_bootcamp_day 3/ca_energy_generation.csv"), stringsAsFactors=F)
imports <- read.csv(here::here("/Users/lizongzhen/Desktop/MLDS/r_bootcamp_day 3/ca_energy_imports.csv"), stringsAsFactors=F)

?paste
?mutate
?melt

nys_codebook


unique(nys_schools$district_name)
sum(nys_schools$district_name=="-99")

data <- nys_schools[nys_schools$county_name != -99, ]