#################################################
### Module: Data Manipulation
### Goals:  Add, remove, rename columns
###         Subset
###         Summarize
###         Melt and Cast (long vs wide format)
###
#################################################

library(datasets)
library(reshape2)
library(plyr)

# load sample data set
data(movies)

### Adding, removing, renaming columns
names(movies)

# Adding columns
# a function of two other columns
movies$votes_per_dollar <- movies$votes / movies$budget

# a new categorical variable
movies$good <- "no"
movies$good[movies$rating > 6] <- "yes"

# Removing columns
movies$r5 <- NULL
movies <- movies[!(names(movies) %in% 
                   c("r1","r2","r3","r4","r5","r6","r7","r8","r9","r10"))]

movies.title.yr <- movies[c("title","year")]

# renaming columns
names(movies)
# referencing the name by index
names(movies)[16] <- "Good"
names(movies)
# using a convenience function from plyr
movies <- rename(movies, c("Good"="good", "budget"="Budget"))
names(movies)

### Subsetting

# using the R data.frame indexing
movies.action <- movies[movies$Action == 1,]
head(movies.action)

# selecting on two variables
movies.action.pg13 <- movies[movies$Action == 1 & movies$mpaa == "PG-13", ]

# using a convenience function
movies.comedy <- subset(movies, Comedy == 1)

### Summarizing
votes.mpaa <- ddply(movies, c("mpaa"), 
                    function(df){
                      c("mean.votes" = mean(df$votes))
                    })

votes.mpaa.action <- ddply(movies, c("mpaa","Action"), 
                           function(df){
                             c("mean.votes" = mean(df$votes),
                               "sd.votes"   = sd(df$votes))
                           })

### Melting and Casting
### aka, long format vs wide format

data(smiths)
smiths
smiths.long <- melt(smiths, id.vars=c("subject"))










