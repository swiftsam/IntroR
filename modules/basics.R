#################################################
### Module: Basics
### Goals:  Get familiar with the environment
###         
### refs:   http://en.wikipedia.org/wiki/R_(programming_language)
#################################################

### Reasonable intro example
#################################################

x <- c(1,2,3,4,5,6,7,8,9,10)   # Create vector x
y <- x^2 + 4          # create vector y from x
print(x)              # print vector x
print(y)              # print vector y
mean(y)               # Calculate average (arithmetic mean) of (vector) y; result is scalar
var(y)                # Calculate sample variance

fit <- lm(y ~ x)      # Fit a linear regression model "y = f(x)" or "y = B0 + (B1 * x)" 
summary(fit)          # get a summary of the linear model
residuals(fit)        # Check the model residuals
plot(fit)             # Plot diagnostics for the model
plot(x,y)             # Plot the x ~ y relationship
abline(fit)           # Plot the model fit

fit2 <-lm(y ~ x + I(x^2))  # Fit a linear regression model y = B0 + (B1 * x) + (B2*x^2)"
summary(fit2)              # Get a summary of the new model
plot(x,y)                  # Plot the x~y relationship
lines(x,fitted(fit2))      # Plot the model fit

### Mind-blowing intro example
#################################################

library(caTools)         # external package providing write.gif function
jet.colors <- colorRampPalette(c("#00007F", "blue", "#007FFF", "cyan", "#7FFF7F", 
                                 "yellow", "#FF7F00", "red", "#7F0000")) 
m <- 1200                # define size
C <- complex( real=rep(seq(-1.8,0.6, length.out=m), each=m ), 
              imag=rep(seq(-1.2,1.2, length.out=m), m ) ) 
C <- matrix(C,m,m)       # reshape as square matrix of complex numbers
Z <- 0                   # initialize Z to zero
X <- array(0, c(m,m,20)) # initialize output 3D array
for (k in 1:20) {        # loop with 20 iterations
  Z <- Z^2+C             # the central difference equation  
  X[,,k] <- exp(-abs(Z)) # capture results
} 
write.gif(X, "Mandelbrot.gif", col=jet.colors, delay=100)


### Starting from the beginning
#################################################

# R can do math
1 + 1
1000000 - 2
4*pi
log(2^45)

# R is a programming environment in which you can save
# values or sets of values to a variable
1 + 1       # calculate and return the value of 1 +1
x <- 1 + 1  # Save the output of 1 + 1 to a new variable, x
x           # return the value of x
X           # return the value of X.  Oops, there is no X (case matters)

# we're not limited to numbers either
best.school <- "Carnegie Mellon"
best.school

# but you can't just do anything you want
best.school * 5

# You can keep tabs on what variables you've created 
ls()       # ls stands for 'list'

# You can ask what type of variable something is
class(x)
class(fit)

# You can ask about the structure of more complex objects
names(x)  
names(fit)
str(x)      # str stands for 'structure'

# You can delete an object when you're done with it, if you want
rm(fit)     # rm stands for 'remove'

# If things get messy, you can remove everything and start with a clean slate
rm(list=ls())

### Special Characters and words
#################################################
#  "#" comments out a line.  you can write whatever you want and it won't be read by R
#      use lots of comments to make your code friendly
#  "<-" assigns a value
#  "TRUE" and "FALSE" are special words which hold those logical values
#  "NA" is a special value for missing data

### Logical Operators (see http://www.statmethods.net/management/operators.html)
#################################################
x <- 4
y <- abs(-11)    # "abs" stands for "absolute value"
z <- sqrt(81)    # "sqrt" stands for "square root"

x == y      # "==" asks the question, "are these equal"
x != z      # "!=" asks the question, "are these not equal"
x < y
x.is.bigger <- x > z
x.is.bigger
is.na(x)    
is.null(x)
is.numeric(x)

### Functions
#################################################
# R has a large number of existing functions for common (and uncommon!) tasks
# Any time you see parathenses, you're using a function
x <- rnorm(n=100,mean=10,sd=5)  # rnorm stands for 'random, normal distribution'
mean(x)
sd(x)
summary(x)
# learning which functions are useful to you is the whole idea!

## Time to dig in: Challenge #1

