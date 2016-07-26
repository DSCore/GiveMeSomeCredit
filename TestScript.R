# Author: Devon Cormack
# Date: 2016-07-01
# Practice Entry for "Give Me Some Credit" Kaggle competition

dat <- read.csv('cs-training.csv')

# Using https://www.datacamp.com/community/tutorials/15-easy-solutions-data-frame-problems-r
# Another interesting read is: http://www.kdnuggets.com/2015/06/top-20-r-machine-learning-packages.html

# Look at the variables
head(dat)
colnames(dat) # Look at column names (can also be used to set)
names(dat) # Look at column names (can also be used to set)
dim(dat) # dimensions [rows columns] (also nrow(dat) and ncol(dat) )
str(dat) # Look at vartypes in dat (Like df.dtypes in pandas)

# Attach the variables for ease of use - TODO: this section doesn't seem to work...
search() # Look at the current environment
attach(dat) # Attach dat to environment (can also use with(dat,c(<colnames>)) to attach certain columns)
search() # See if dat was attached
dat
detach(dat) # Remove dat since this doesn't seem to be working

# Get some descriptive stats - TODO: Look into apply(...) more
apply(dat, 2, median) # Find the median of the columns (2)
apply(dat, 1, median) # Finda the median of the rows (1)
summary(dat)

mt <- data.frame() # Create an empty dataframe for the heck of it
rm(mt) # Remove the empty dataframe

# Can use Python Pandas-style syntax to access R dataframes too
summary(dat['SeriousDlqin2yrs'])
summary(dat[1:6,'SeriousDlqin2yrs'])
# Using subset
summary(subset(dat,dat['SeriousDlqin2yrs'] > 0 & dat['NumberOfDependents'] > 2))
# Using grep to find all of the observations with 1 dependent ("1" as the number of dependents) in 4 ways (A,B,C,D)
dat2 <- dat[grep("1",dat[,'NumberOfDependents']),] # A
dat2 <- dat[grep("1",dat$NumberOfDependents),] # B
dat2 <- dat[grep("1",dat['NumberOfDependents']),] # C
typeof(dat[,'NumberOfDependents']) # A
typeof(dat$NumberOfDependents) # B
typeof(dat['NumberOfDependents']) # C

unlist(dat["NumberOfDependents"]) # D <- This line makes a list of the values that were in a dataframe (converts to array)
dat2 <- dat[grep("1",unlist(dat['NumberOfDependents'])),] # D

# For some reason, A & B work, but C doesn't.  Looks like it is 
# an issue with the data types... dat['NumberOfDependents'] is 
# returning a list, where dat$NumberOfDependents and 
# dat[,'NumberOfDependents'] returns an integer
# D fixes it -> Looks like you use unlist(x) to get values of x

factor(dat$NumberOfDependents)

# NOTE: Use boolean masks to filter rows
  
library(rpart)
# Good documentation of rpart http://www.statmethods.net/advstats/cart.html
# Build the classification/regression tree
  # Good docs on R formulas: http://faculty.chicagobooth.edu/richard.hahn/teaching/formulanotation.pdf 
  # and http://www.r-bloggers.com/using-r-for-introductory-statistics-chapter-4-model-formulae/
rfit = rpart(formula = SeriousDlqin2yrs ~ . - X, data = dat) #NOTE: Trees cannot handle interaction terms



