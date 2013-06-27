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

id <- 1:30
cond <- rep(c("indiv","teams","crowd belief","super team","pred market"),times=6)

sample <- data.frame("id" = id, "cond" = cond)
sample$bs_1040 <- rnorm(30, .3, .35)
sample$bs_1041 <- rnorm(30, .5, .35)
sample$bs_1042 <- rnorm(30, .1, .35)
sample$bs_1043 <- rnorm(30, .7, .35)
sample$num_logins          <- runif(30, min=0, max=500)
sample$num_msgs            <- rnorm(30, 15, 20)

# you get data in a "wide format" w/ multiple columns of data per observation
head(sample)

# you may want data in long format w/ one data point per row
sample.long <- melt(sample, id.vars=c("id","cond"),
                    measure.vars  = c("bs_1040","bs_1041","bs_1042","bs_1043"),
                    variable.name = "ifp_id",
                    value.name    = "score")

# you might then want to summarize it 
bs.mean.ifp.cond <- dcast(sample.long, cond ~ ifp_id, value.var="score",fun.aggregate=mean)

# or cast it back into a different wide format









