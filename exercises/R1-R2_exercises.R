############ MSiA Boot Camp: Intro to R: Day 1 Exercises #############
### by Kumar Ramanathan, based on materials from Christina Maimone ###

#### BASICS AND DATA TYPES ####

#### Arithmetic ####

# Pick a number; save it as x


# Multiply x by 3


# Take the log of the above (Hint, you need the function log() here)


# Subtract 4 from the above


# Square the above


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


# Check if 1 + 1 is equal to 2


# Check if it is true that the strings "eat" and "drink" are not equal to each other


# Check if it is true that 1 is equal to 1 *AND* 1 is equal to 2 
# (Hint: remember what the operators & and | do)


# Check if it is true that 1 is equal to 1 *OR* 1 is equal to 2


#### Packages and Functions ####

# Install the package tidyverse (only need to run this once)


# Load the package tidyverse


# Open the help file for the function recode 
# (Hint: remember what ? does)


#### DATA STRUCTURES ####

#### Vectors ####

# Run this code to generate variables x1 and x2
set.seed(1234)
x1 <- rnorm(5)
x2 <- rnorm(20, mean=0.5)

# Select the 3rd element in x1


# Select the elements of x1 that are less than 0


# Select the elements of x2 that are greater than 1


# Create x3 containing the first five elements of x2


# Select all but the third element of x1


#### Missing values ####

# Generate a vector
vec <- c(1, 8, NA, 7, 3)

# Calculate the mean of vec, excluding the NA value


# Count the number of missing values in vec


#### Factors ####

# See lecture notes and DataCamp for guidance and practice


#### Lists ####

# See lecture notes and DataCamp for guidance and practice


#### Matricies ####

# Generate a matrix
mat <- matrix(c(1:51, rep(NA,4)), ncol=5)

# Select row 4, column 5


# Select column 3


# Bonus: How many NA values are there in this matrix?


#### Data frames ####

# Load one of R's example data frames, mtcars
data(mtcars)

# Identify the number of observations (rows), number of variables (columns), and names of variables in the data frame


# Select the variable 'mpg'


# Select the 4th row


# Square the value of the 'cyl' variable and store this as a new variable 'cylsq'


#### READING FILES ####

# Check your working directory. It should be the root folder where you downloaded the boot camp materials. If that's not the case, set your working directory accordingly.


# Read gapminder data with read.csv()
# Note: this assumes that the csv file is stored in a sub-directory called "data"
gapminder <- read.csv("data/gapminder5.csv", stringsAsFactors=FALSE)

# Load the readr package


# Read gapminder data with read_csv()


#### DATA MANIPULATION ####

#### Exploring data frames ####

# Run summary() on the gapminder data


# Find the mean of the variable pop


# Create a frequency table of the variable 'year' using table()


# Create a proportion table of the variable 'continent' using prop.table()
# Hint: check the help file for prop.table() to see what the input should be


#### Subsetting and Sorting ####

# Create a new data frame called gapminder07 contaning only those rows in the gapminder data where year is 2007


# Created a sorted frequency table of the variable continent in gapminder07


# Print out the population of Mexico in 2007


# BONUS: Print out the rows represnting the 5 countries with the highest population in 2007
# Hint: Use order(), which we learned about, and head(), which prints out the first 5 rows of a data frame


#### Adding and removing columns ####

# See lecture notes for more guidance. We will practice this skill later in the boot camp.


#### Recoding variables ####

# Round the values of the variable `lifeExp` using `round()` and store this as a new variable `lifeExp_round`


# Print out the new variable to see what it looks like


# This code creates the new variable 'lifeExp_over70'. Try to understand what it does.
gapminder07$lifeExp_over70 <- NA  # Initialize a variable containing all "NA" values
gapminder07$lifeExp_over70[gapminder07$lifeExp>70] <- "Yes"
gapminder07$lifeExp_over70[gapminder07$lifeExp<70] <- "No"
table(gapminder07$lifeExp_over70)

# Try to create a new variable 'lifeExp_highlow' that has the value 
# "High" when life expectancy is over the mean and the value "Low" 
# when it is below the mean. When you are done, print a frequency table.





#### Aggregating ####

# Find the mean of life expectancy in 2007 for each continent
# Hint: use the aggregate() function


#### Statistics, part 1 ####

# Calculate the correlation between 'lifeExp' and 'gdpPercap'.


# Use a t-test to evaluate the difference in 'gdpPercap' between "high" and "low" life expectancy countries. Store the results as t1, and then print out t1.



#### Statistics, part 2 ####

# Conduct a linear regression predicting 'lifeExp' as a function of 'gdpPercap' and 'pop', and store the results as reg1.


# Print out reg1.


# Run summary() on reg1.


#### WRITING FILES ####

#### Writing a data file ####

# Save the data frame gapminder07 in the same directory that gapminder5.csv is located.
# If you use write.csv(), set the argument row.names = FALSE. 
# If you use write_csv(), it does not include row names/numbers by default.


#### Save R objects ####

# See lecture notes for guidance and more examples.


#### DATA VISUALIZATION ####

#### Histograms ####

# Create a histogram of the variable 'lifeExp' in gapminder07


# Re-create the histogram with a title and axis labels


# Bonus: Change the `breaks = ` argument from its default setting and see what happens.


#### Scatterplots ####

# Create a scatterplot with `lifeExp` on the y-axis and `gdpPercap` on the x-axis.


# Add a title and axis labels.


# Bonus: Add a horizontal line indicating the mean of `lifeExp` onto the plot using `abline()`.


