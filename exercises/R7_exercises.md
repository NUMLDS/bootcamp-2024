## Data viz with ggplot - Exercises

This document contains the instructions for exercises during the ggplot session, drawn from the slides. Suggested answers are included in the [slides](https://msia.github.io/bootcamp-2023/lectureslides/R7_slides/).

### Exercise 1: Scatterplot

Using the gapminder07 data, create a scatterplot of the natural log of `gdpPercap` as a function of the natural log of `pop`. Give it a title and axis labels.

Remember, you will need three functions: `ggplot()`, `geom_point()`, and `labs()`.

### Exercise 2: Hydro power generated over time

Task: Plot a column chart hydroelectric power generated over time.

Hint: There are two types of hydroelectric sources in the data: `large_hydro` and `small_hydro`.

### Exercise 3: Total output per source

Task: Create a column chart that shows the total output per source.

- Change the color of the columns to `"darkred"`.
- Add a horizontal line indicating the mean output across all sources. Use the cheatsheet to identify the `geom` function that you need.
- Add a meaningful title and axis labels using `labs()`.

### Exercise 4: Colors and fill

Task: Create a line plot that compares generation of wind, solar, and geothermal energy over time.

Bonus: Set the line size to 1.5.

### Exercise 5: Average hourly output by source

Task: Visualize the average output for each hour of the day, grouped by source.

Hint: You need to identify the output per source per hour (e.g. 01:00, 02:00, etc) averaged over all days.

- You will need to prepare your data using both `dplyr` and `lubridate` functions.
- You can choose which `geom`(s) to use, and how to demarcate groups.
- Bonus: use a scale layer to set a color palette (try `"Set3"`) and change the legend name.
- Remember to add `labs()`!

### Exercise 6: Facets

Task: Compare generation patterns for each source in facets. Color the lines using the "group" variable in `regroup`.

Remember:
- You will need to prepare your data. Think about the variables that you need: source/type, output, and group.
- When you pipe modified data into ggplot, remember that you are grouping in two ways: source/type through facets, and group through color.
