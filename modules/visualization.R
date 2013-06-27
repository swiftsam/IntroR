#################################################
### Module: Visualization
### Goals:  Import data and visualize it
###         Histogram
###         Scatterplot
###         Bar graphs with error bars
###
### refs:   http://en.wikipedia.org/wiki/Iris_flower_data_set
###         https://github.com/echen/ggplot2-tutorial/
#################################################

# Load Libraries
library(datasets) # a package full of sample datasets
library(ggplot2)  # the best visualization package 

# load some of the same data from datasets
data(iris)
data(movies)

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### R's basic default plotting tools
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# take a look at what data we have to work with
head(movies)

# Make a histogram of a continuous variable
hist(movies$rating) # looks nice and normal
hist(movies$budget) # oh man, skew city

# if we're interested in movie budgets, we can remove 
# movies with missing/no budgets
movies <- subset(movies, budget > 0)

# Add a transformed column for log(budget) to fix that skew
movies$logbudget <- log(movies$budget)

# Try that histogram again
hist(x = movies$logbudget)
hist(movies$logbudget) # it will assume you mean x if you give it one thing

# A scatterplot with two variables
plot(x = movies$logbudget, y = movies$rating) # x and y format
plot(movies$rating ~ movies$logbudget) # formula format

# We can also formally test for a linear relationship
fit.mov.rat <- lm(movies$rating ~ movies$budget)
summary(fit.mov.rat)

# and add that line to the plot
# abline() just knows to take the intercept and beta from a lm
abline(fit.mov.rat, col="red") 

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### ggplot: the newer, nicer, more awesome way to make plots
###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# a histogram using ggplot, note the aes() and geom_ parts
ggplot(movies, aes(x = rating)) +
  geom_histogram()

# specifying fixed properties
ggplot(movies, aes(x = rating)) +
  geom_histogram(color="darkgreen", fill="white", binwidth = .25)

# adding a new layer for density 
ggplot(movies, aes(x = rating)) +
  geom_histogram(aes(y = ..density..), 
                 color="darkgreen", fill="white", binwidth = .25) +
  geom_density(color="red")

# looking at two variables again
ggplot(movies, aes(x = year, y = budget)) +
  geom_point()

# adjust the axis at the time of plotting to take care of skew
ggplot(movies, aes(x = year, y = budget)) +
  geom_point() +
  scale_y_log10()

# add some aesthetics to aid interpretation
ggplot(movies, aes(x = year, y = budget)) +
  geom_point(aes(color=rating), alpha=.5) +
  geom_smooth(aes(linetype=factor(Short)), method="lm", color="red") +
  scale_y_log10() +
  labs(title = "Movie budgets by year",
       x = "Year",
       y = "Log Budget",
       color = "Rating",
       linetype = "Short Film")

### Some more ggplot examples

head(iris) # Take a look at a new data set

# Basic scatter plot
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
  geom_point()

# Adding an aesthetic dimension
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
  geom_point(aes(color=Species)) # dude!

# And another
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
  geom_point(aes(color = Species, size = Petal.Width))

# By setting the alpha of each point to 0.7, we reduce the effects of overplotting.
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
  geom_point(aes(color = Species, size = Petal.Width), alpha = 0.7)

# Box plot to compare group means
ggplot(iris, aes(x=Species, y=Petal.Length)) +
  geom_boxplot()

# Violin plot to represent the distributions more continously
ggplot(iris, aes(x=Species, y=Petal.Length)) +
  geom_violin() +
  labs(x = "Sepal Length", 
       y = "Petal Length", 
       title = "Sepal vs. Petal Length in Fisher's Iris data")


