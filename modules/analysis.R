#################################################
### Module: Analysis
### Goals:  t.test
###         aov
###         lm
### refs:   
#################################################

# Load a new data set and take a look at what's in it
library(datasets)
data(CO2)
head(CO2)

table(CO2$Plant)
table(CO2$Treatment)

# do a t-test comparing 2 categories on a continuous DV
t.test(uptake ~ Treatment, data=CO2)

# do an anova comparing more than 2 categories on a continuous DV
aov <- aov(uptake ~ Plant, data=CO2)
summary(aov)

# a simple linear model between two continuous measures
lm <- lm(uptake ~ conc, data=CO2)
summary(lm)

# a multiple regression with continous and categorical predictors
lm2 <- lm(uptake ~ conc + Type, data=CO2)
summary(lm2)



