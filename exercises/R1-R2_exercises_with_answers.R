############ MSiA Boot Camp: Intro to R: Day 1 Exercises - ANSWER KEY #############
######### by Kumar Ramanathan, based on materials from Christina Maimone ##########

#### BASICS AND DATA TYPES ####

#### Arithmetic ####

# Pick a number; save it as x
x <- 5

# Multiply x by 3
x*3

# Divide x by 2
x/2

# Subtract 4 from the above
(x/2)-4

# Square the above
((x/2)-4)^2

#### Functions ####

# Look up the help file for log
?log

# Take the natural log of 10
log(10)

# Take the log of 10 with base-19
log(10, base=10)

# Store the result of log(10) as a variable
y <- log(10)

#### Comparisons and Logical Operators ####

# Check if 1 is bigger than 2
1 > 2

# Check if 1 + 1 is equal to 2
(1+1)==2

# Check if it is true that the strings "eat" and "drink" are not equal to each other
"eat"!='drink'

# Check if it is true that 1 is equal to 1 *AND* 1 is equal to 2 
# (Hint: remember what the operators & and | do)
(1==1) & (1==2)

# Check if it is true that 1 is equal to 1 *OR* 1 is equal to 2
(1==1) | (1==2)

#### Packages and Functions ####

# Load the package tidyverse
library(tidyverse)

# Open the help file for the function recode 
# (Hint: remember what ? does)
?recode

#### DATA STRUCTURES ####

#### Vectors ####

# Run this code to generate variables x1 and x2
set.seed(1234)
x1 <- rnorm(5)
x2 <- rnorm(20, mean=0.5)
  
# Select the 3rd element in x1
x1[3]
  
# Select the elements of x1 that are less than 0
x1[x1<0]
  
# Select the elements of x2 that are greater than 1
x2[x2>1]
  
# Create x3 containing the first five elements of x2
x3 <- x2[1:5]

# Select all but the third element of x1
x1[-3]

#### Missing values ####

# Generate a vector
vec <- c(1, 8, NA, 7, 3)

# Calculate the mean of vec, excluding the NA value
mean(vec, na.rm=TRUE)

# Count the number of missing values in vec
sum(is.na(vec))

#### Factors ####

# See lecture notes and DataCamp for guidance and practice


#### Lists ####

# See lecture notes and DataCamp for guidance and practice


#### Matricies ####

# Generate a matrix
mat <- matrix(c(1:51, rep(NA,4)), ncol=5)

# Select row 4, column 5
mat[4,5]

# Select column 3
mat[,3]

# Bonus: How many NA values are there in this matrix?
sum(is.na(mat))

#### Data frames ####

# Load one of R's example data frames, mtcars
data(mtcars)

# Identify the number of observations (rows), number of variables (columns), and names of variables in the data frame
str(mtcars)

# Select the variable 'mpg'
mtcars$mpg

# Select the 4th row
mtcars[4,]

# Square the value of the 'cyl' variable and store this as a new variable 'cylsq'
mtcars$cylsq <- (mtcars$cyl)^2

#### READING FILES ####

# Check your working directory. It should be the root folder where you downloaded the boot camp materials. If that's not the case, set your working directory accordingly.
getwd()

# Read gapminder data with read.csv()
gapminder <- read.csv("data/gapminder5.csv", stringsAsFactors=FALSE)

# Load the readr package
library(readr)

# Read gapminder data with read_csv()
# Note: this assumes that the csv file is stored in a sub-directory called "data"
gapminder <- read_csv("data/gapminder5.csv")

#### DATA MANIPULATION ####

#### Exploring data frames ####

# Run summary() on the gapminder data
summary(gapminder)

# Find the mean of the variable pop
mean(gapminder$pop)

# Create a frequency table of the variable 'year' using table()
table(gapminder$year)

# Create a proportion table of the variable 'continent' using prop.table()
# Hint: check the help file for prop.table() to see what the input should be
prop.table(table(gapminder$continent))

#### Subsetting and Sorting ####

# Create a new data frame called gapminder07 contaning only those rows in the gapminder data where year is 2007
gapminder07 <- subset(gapminder, year==2007)

# Created a sorted frequency table of the variable continent in gapminder07
sort(table(gapminder07$continent))

# Print out the population of Mexico in 2007
gapminder07$pop[gapminder07$country=="Mexico"]

# BONUS: Print out the rows represnting the 5 countries with the highest population in 2007
# Hint: Use order(), which we learned about, and head(), which prints out the first 5 rows of a data frame
head(gapminder07[order(gapminder07$pop, decreasing=TRUE),])

#### Adding and removing columns ####

# See lecture notes for more guidance. We will practice this skill later in the boot camp.


#### Recoding variables ####

# Round the values of the variable `lifeExp` using `round()` and store this as a new variable `lifeExp_round`
gapminder07$lifeExp_round <- round(gapminder07$lifeExp)

# Print out the new variable to see what it looks like
gapminder07$lifeExp_round

# This code creates the new variable 'lifeExp_over70'. Try to understand what it does.
gapminder07$lifeExp_over70 <- NA  # Initialize a variable containing all "NA" values
gapminder07$lifeExp_over70[gapminder07$lifeExp>70] <- "Yes"
gapminder07$lifeExp_over70[gapminder07$lifeExp<70] <- "No"
table(gapminder07$lifeExp_over70)

# Try to create a new variable 'lifeExp_highlow' that has the value 
# "High" when life expectancy is over the mean and the value "Low" 
# when it is below the mean. When you are done, print a frequency table.
gapminder07$lifeExp_highlow <- NA
gapminder07$lifeExp_highlow[gapminder07$lifeExp>mean(gapminder07$lifeExp)] <- "High"
gapminder07$lifeExp_highlow[gapminder07$lifeExp<mean(gapminder07$lifeExp)] <- "Low"
table(gapminder07$lifeExp_highlow)

#### Aggregating ####

# Find the mean of life expectancy in 2007 for each continent
# Hint: use the aggregate() function
aggregate(gapminder07$lifeExp ~ gapminder07$continent, FUN = mean)

#### Statistics, part 1 ####

# Calculate the correlation between 'lifeExp' and 'gdpPercap'.
cor(gapminder07$lifeExp, gapminder07$gdpPercap)

# Use a t-test to evaluate the difference in 'gdpPercap' between "high" and "low" life expectancy countries. Store the results as t1, and then print out t1.
t1 <- t.test(gdpPercap ~ lifeExp_highlow, data=gapminder07)
t1

#### Statistics, part 2 ####

# Conduct a linear regression predicting 'lifeExp' as a function of 'gdpPercap' and 'pop', and store the results as reg1.
reg1 <- lm(lifeExp ~ gdpPercap + pop, data=gapminder07)

# Print out reg1.
reg1

# Run summary() on reg1.
summary(reg1)

#### WRITING FILES ####

#### Writing a data file ####

# Save the data frame gapminder07 in the same directory that gapminder5.csv is located.
# If you use write.csv(), set the argument row.names = FALSE. 
# If you use write_csv(), it does not include row names/numbers by default.
write.csv(gapminder07, file="data/gapminder07.csv", row.names=FALSE)

#### Save R objects ####

# See lecture notes for guidance and more examples.


#### DATA VISUALIZATION ####

#### Histograms ####

# Create a histogram of the variable 'lifeExp' in gapminder07
hist(gapminder07$lifeExp)

# Re-create the histogram with a title and axis labels
hist(gapminder07$lifeExp, main="Distribution of life expectancy across countries in 2007", xlab="Life expectancy", ylab="Frequency")

# Bonus: Change the `breaks = ` argument from its default setting and see what happens.
hist(gapminder07$lifeExp, main="Distribution of life expectancy across countries in 2007", xlab="Life expectancy", ylab="Frequency", breaks=20)

#### Scatterplots ####

# Create a scatterplot with `lifeExp` on the y-axis and `gdpPercap` on the x-axis.
plot(gapminder07$lifeExp ~ gapminder07$gdpPercap)

# Add a title and axis labels.
plot(gapminder07$lifeExp ~ gapminder07$gdpPercap,
     main="Relationship between life expectancy and GDP per capita in 2007", 
     ylab="Life expectancy", xlab="GDP per capita")

# Bonus: Add a horizontal line indicating the mean of `lifeExp` onto the plot using `abline()`.
plot(gapminder07$lifeExp ~ gapminder07$gdpPercap,
     main="Relationship between life expectancy and GDP per capita in 2007", 
     ylab="Life expectancy", xlab="GDP per capita")
abline(h=mean(gapminder07$lifeExp))
