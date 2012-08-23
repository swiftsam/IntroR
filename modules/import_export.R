#################################################
### Module: Importing and Exporting data
### Goals:  Import data from a CSV
###         Import data from an online data source
###         Save data to a CSV
### refs:   http://www.ats.ucla.edu/stat/r/faq/inputdata_R.htm
#################################################

rm(list=ls()) # start with a clean slate
# (don't run if you have something in your workspace you can't recreate)

### Loading Data
#################################################

# Load data you have stored locally with read.csv()
USJudgeRatings <- read.csv("USJudgeRatings.csv", header=TRUE)

# Load data from anywhere online with the same function!
ABS2 <- read.csv("http://samswift.org/data/ABS2-data-2012-02-24.csv", header=TRUE)
names(ABS2)

# want to use a format other than CSV?  No problem!
library(foreign)
#data.restore   Read an S3 Binary File
#lookup.xport   Lookup Information on a SAS XPORT Format
#read.dbf       Read a DBF File
#read.dta       Read Stata binary files
#read.epiinfo   Read Epi Info data files
#read.mtp       Read a Minitab Portable Worksheet
#read.octave    Read Octave Text Data Files
#read.spss      Read an SPSS data file
#read.ssd       Obtain a Data Frame from a SAS Permanent


### Saving Data
#################################################

# Reduce the data.frame to the columns you're interested in
df <- USJudgeRatings[c("CONT","INTG","DMNR","ORAL")]

# Save the new, smaller CSV
write.csv(df, "USJudgeSubset.csv",row.names=FALSE)




