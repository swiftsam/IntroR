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



head(iris) # by default, head displays the first 6 rows
head(iris, n = 10) # we can also explicitly set the number of rows to display

#(The data frame actually contains three types of species: setosa, versicolor, and virginica.)

#Let's plot `Sepal.Length` against `Petal.Length` using ggplot2's `qplot()` function.

ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
  geom_point()
# Plot Sepal.Length vs. Petal.Length, using data from the `iris` data frame.

#To see where each species is located in this graph, we can color each point by adding a `color = Species` argument.

ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
  geom_point(aes(color=Species)) # dude!

#Similarly, we can let the size of each point denote sepal width, by adding a `size = Sepal.Width` argument.

ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
  geom_point(aes(color = Species, size = Petal.Width))
# We see that Iris setosa flowers have the narrowest petals.

ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
  geom_point(aes(color = Species, size = Petal.Width), alpha = 0.7)
# By setting the alpha of each point to 0.7, we reduce the effects of overplotting.


ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
  geom_point(aes(color = Species, size = Petal.Width), alpha = 0.7) +
  geom_smooth(method="lm", aes(color=Species))

#Finally, let's fix the axis labels and add a title to the plot.
ggplot(iris, aes(x=Sepal.Length, y=Petal.Length)) +
  geom_point(aes(color = Species, size = Petal.Width), alpha = 0.7) +
  labs(x = "Sepal Length", 
       y = "Petal Length", 
       title = "Sepal vs. Petal Length in Fisher's Iris data")


## Other common geoms

#In the scatterplot examples above, we implicitly used a *point* **geom**, the default when you supply two arguments to `qplot()`.

# These two invocations are equivalent.
qplot(Sepal.Length, Petal.Length, data = iris, geom = "point")
qplot(Sepal.Length, Petal.Length, data = iris)


### Line charts: geom = "line"

qplot(Sepal.Length, Petal.Length, data = iris, geom = "line", color = Species) 
# Using a line geom doesn't really make sense here, but hey.

# `Orange` is another built-in data frame that describes the growth of orange trees.
qplot(age, circumference, data = Orange, geom = "line",
      colour = Tree,
      main = "How does orange tree circumference vary with age?")


data(mtcars)
head(mtcars)
mtcars$names <- rownames(mtcars)

# Plots of Frequency x category (Bar Chart)
qplot(factor(cyl), data=mtcars, geom="bar") # with qplot

ggplot(mtcars, aes(factor(cyl))) +          # with ggplot
  geom_bar() 

ggplot(mtcars, aes(factor(cyl))) +          # with ggplot and extra tweaks
  geom_bar(fill="white", color="darkgreen") +
  xlab("# of Cylinders") +
  opts(title="Count of Models by # of Cylinders")

# Plots of distribution x category (Box Plot, Violin Plot)
qplot(factor(cyl), mpg, data = mtcars, geom = "boxplot")   #with qplot

ggplot(mtcars, aes(factor(cyl),mpg)) +          # with ggplot
  geom_boxplot()

ggplot(mtcars, aes(factor(cyl),mpg)) +          # with ggplot and extras
  geom_violin() +
  geom_jitter(color="red") 

ggplot(mtcars, aes(factor(cyl),mpg)) +          # with ggplot and extras
  geom_violin() +
  geom_jitter(aes(color=hp)) +
  geom_text(aes(label=names), size=2)

# Plots of relationship 
qplot(mpg, hp, data=mtcars, geom="point")      #with qplot

ggplot(mtcars, aes(mpg,hp)) +                 #with ggplot
  geom_point()

ggplot(mtcars, aes(mpg,hp)) +                 # with ggplot and extras
  geom_point(aes(color=disp)) +
  geom_smooth(method="lm")

ggplot(mtcars, aes(mpg,hp)) +                 # with ggplot and extras
  geom_point(aes(color=disp)) +
  geom_smooth(method="loess")





