# MLDS Boot Camp - Final R exercise

You've learned quite a lot about R in a short time. Congratulations! This exercise is designed to give you some additional practice on the material we have discussed this week while the lectures are still fresh in your mind, and to integrate different tools and skills that you have learned.

## Background

You are a data analyst for the New York City Department of Education. You've been tasked with answering the question:

> What can data tell us about the relationship between poverty and test performance in New York public schools?

Some other questions that your department has:

> * What's the difference in test performance between low, medium and high poverty areas?
> * Has this relationship changed over time?
> * Is this relationship at all moderated by access to free / reduced price lunch?

## Brainstorming

Before even looking at the data:

* Empathize: Why is the stakeholder asking these questions?
* Brainstorm: What data and/or visualizations could help answer these questions?
* Insights: What conclusions and/or recommendations do you expect to come from your analysis?

## Your Task

Using the skills you've learned in the past week, tackle the question(s) above. You can use summary tables, statistical models, and/or data visualization in pursuing an answer.

Given the short time period, any answer will of course prove incomplete. The goal of this task is to give you some room to play around with the skills you've just learned. Don't hesitate to try something even if you don't feel comfortable with it yet. Do as much as you can in the time allotted.

### Step 1: Clean the Data

This is where the majority of your time will be spent.

#### Task 0: Open RStudio

Create a new .R or .Rmd file to document your work.

- Remember to **load necessary packages**.
- Remember to **comment extensively** in your code. If you're working in an RMarkdown file, you can describe your workflow in the text section. But you should also comment within all of your code chunks.

#### Task 1: Import your data

Read the data files `nys_schools.csv` and `nys_acs.csv` into R. These data come from two different sources: one is data on *schools* in New York state from the [New York State Department of Education](http://data.nysed.gov/downloads.php), and the other is data on *counties* from the American Communities Survey from the US Census Bureau. Review the codebook file so that you know what each variable name means in each dataset.

#### Task 2: Explore your data

Getting to know your data is a critical part of data analysis. Take the time to explore the structure of the two dataframes you have imported. What types of variables are there? Is there any missing data? How can you tell? What else do you notice about the data?

#### Task 3: Recoding and variable manipulation

1. Deal with missing values, which are currently coded as `-99`.
2. Create a categorical variable that groups counties into "high", "medium", and "low" poverty groups. Decide how you want to split up the groups and briefly explain your decision.
3. The tests that the NYS Department of Education administers changes from time to time, so scale scores are not directly comparable year-to-year. Create a new variable that is the standardized z-score for math and English Language Arts (ELA) for each year (hint: group by year and use the `scale()` function)

#### Task 4: Merge datasets

Create a dataset that merges variables from the schools dataset and the ACS dataset. Remember that you have learned multiple approaches on how to do this, and that you will have to decide how to combine the two data sets.

---

### Step 2: Analyze the Data

Think back to the original question(s). The best way to answer them and present them to a non-technical audience is using summary tables or visualizations.

#### Task 5: Create summary tables

Generate a few summary tables to help answer the questions you were originally asked.

For example:

1. For each county: total enrollment, percent of students qualifying for free or reduced price lunch, and percent of population in poverty.
2. For the counties with the top 5 and bottom 5 poverty rate: percent of population in poverty, percent of students qualifying for free or reduced price lunch, mean reading score, and mean math score.

#### Task 6: Data visualization

Using `plot` or `ggplot2`, create a few visualizations that you could share with your department.

For example:

1. The relationship between access to free/reduced price lunch and test performance, at the *school* level.
2. Average test performance across *counties* with high, low, and medium poverty.

---

### Step 3: Github Submission

#### 1. Save your exercise within your forked repo

When you have completed the exercise, save your Markdown file in the `submissions` folder of your forked repo using this naming convention: `FinalRExercise_LastnameFirstname.Rmd`.

#### 2. Create a pull request

Create a pull request to submit the file to the base repo that lives in the MSiA organization. Make sure that the new file you created is in the `submissions` folder, and then create a pull request that asks to merge changes from your forked repo to the base repo.

#### Reminders

- Attempt to knit your Markdown file into HTML format before committing it to Github. Troubleshoot any errors with the knit process by checking the lines referred to in the error messages.
- When working with git, don't forget to commit changes periodically, and push commits when you are done.
