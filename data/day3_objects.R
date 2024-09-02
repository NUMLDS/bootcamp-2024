## This script file re-creates data frames from the Day 1 afternoon session and Day 3 morning session of the MSIA 2018 boot camp, for use during the Day 3 afternoon session on data visualization ##

# Load packages
library(tidyverse)
library(here)
library(reshape2)

# Prep gapminder5
gapminder <- read_csv(here("data/gapminder5.csv"))

# Prep gapminder07
gapminder07 <- subset(gapminder, subset = year==2007)
gapminder07$lifeExp_round <- round(gapminder07$lifeExp)
gapminder07$lifeExp_over70 <- case_when(gapminder07$lifeExp > 70 ~ "Yes", 
                                        gapminder07$lifeExp < 70 ~ "No")
gapminder07$lifeExp_highlow <- case_when(gapminder07$lifeExp>mean(gapminder07$lifeExp) ~ "High", 
                                         gapminder07$lifeExp<mean(gapminder07$lifeExp) ~ "Low")

# Prep imports and generation
imports <- read_csv(here("data/ca_energy_imports.csv"))
generation <- read_csv(here("data/ca_energy_generation.csv"))
regroup <- read_csv(here("data/ca_energy_regroup.csv"))

# Prep long_gen
long_gen <- melt(generation, id.vars = "datetime",
                 variable.name = "source",
                 value.name = "output")

# Prep merged_energy
merged_energy <- merge(generation, imports, by = "datetime")

# Prep long_merged_energy
long_merged_energy <- melt(merged_energy, id.vars = "datetime",
                           variable.name = "source",
                           value.name = "output")