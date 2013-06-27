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

library(datasets)
library(ggplot2)
#load one of R's built-in sample data sets called movies
data(movies)
names(movies)

#R's basic default plotting tools
hist(movies$rating,xlab="Ratings",breaks=50)
hist(movies$budget)

movies <- subset(movies, budget > 0)

movies$logbudget <- log(movies$budget)

hist(movies$logbudget)
plot(movies$logbudget ~ movies$rating)
fit <- lm(movies$logbudget ~ movies$rating)
summary(fit)

plot(movies$logbudget ~ movies$rating)


# ggplot gives us a nicer but quick tool for plotting called qplot
qplot(rating, data=movies, geom="histogram") 

# if you want full control you use ggplot2's function, ggplot

data(iris)

#What does the data frame contain? We can use the `head` function to look at the first few rows.

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





