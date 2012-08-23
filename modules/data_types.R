#################################################
### Module: Data Types in R
### Goals:  Create, select, and use 
###         data types: characters, numeric, logical, factor
###         data structures: scalars, vector, matrix, array, dataframe, list
#################################################

rm(list=ls()) # start with a clean slate
              # (don't run if you have something in your workspace you can't recreate)


### Data Types
#################################################

# Numeric
x <- 4     
class(x)   # R knows that 4 is a number
x <- "4"
class(x)   # quotes force R to consider it a character string

# Character
x <- "Sam Swift"
class(x)

# Logical
x <- 2 == 4
class(x)

# Factor
x <- factor(c("red", "blue","orange"))
x
class(x)

# You can sometimes convince R to convert a variable from one data type to another
x <- "4"
class(x)
x <- as.numeric(x)
class(x)

x <- "Barb Mellers"   
x <- as.numeric(x)  # some things can't just be simplified into a number

### Data Structures
#################################################

# scalar (a fancy word for "one of something")
x <- 4

# vector: 1d, 1 data type
x <- c(4,5,6,7,8,9,10)      # "c" stands for combine
y <- 1:100                  # ":" generates a regular sequence
z <- seq(1.5, 20.5, by=0.5) # "seq" stands for "sequence"
cars <- c("ford","chevy","buick","ferrari")
rain <- c(TRUE,TRUE,TRUE,FALSE,TRUE,FALSE)

# matrix: 2d, 1 data type
x <- matrix(runif(25), nrow=5, ncol=5)
x

# array: unlimited dimensions, 1 data type
some.numbers <- rnorm(90)
x <- array(some.numbers,dim=5)  # "dim" stands for "dimensions"
x
x <- array(some.numbers,dim=c(5,5))
x
x <- array(some.numbers,dim=c(5,5,2))
x

# list: 1d of mixed types
x <- list(5, "turkey", TRUE, 1:10)
str(x)
x

# data.frame: 2d of mixed types
id     <- c(1,2,3,4,5,6,7)
height <- c(76.1,77,78.1,78.2,78.8,79.7,79.9)
weight <- rnorm(7,mean=80)
name   <- c("sleepy", "dopey","sneezy","bashful","doc","happy","grumpy")
dwarves<- data.frame(id=id,height=height,weight=weight,name=name)
dwarves

### Indexing values in a Data Structure
#################################################

# values can be selected by numeric index
names  <- c("sleepy", "dopey","sneezy","bashful","happy") #create a vector
winner <- names[4]           # select the 4th element
winner
losers <- names[1:3]         # select a range of elements      
losers <- names[c(1,2,3,5)]  # select a non-contiguous range of elements
losers <- names[1:10]        # can you select indices that don't exist?

# two or more dimensional indexes work too!
some.numbers <- rnorm(90)              # create a vector of 90 random numbers from a normal dist 
x <- array(some.numbers,dim=c(5,5,2))  # form the vector into a 5x5x2 array
dim(x)                                 # "dim" stands for "dimensions"
x[2,,]
x[2,3,]
x[2,3,2]

# anything that can be requested by an index can also be set that way
x[4,1,1]
x[4,1,1] <- 5
x[4,,]

# values can also be selected by name when names are available
names(dwarves)
dwarves[,"weight"]
dwarves$weight        # "$" is a special character which gets a sub-part of a data.frame

# setting a value using a new name creates that column
dwarves$gender <- rep("male",7)   # "rep" stands for "repeat"
dwarves

# selection can also be conditional
dwarves$weight < 80
dwarves[dwarves$weight < 80,]

## Time to dig in: Challenge #2








