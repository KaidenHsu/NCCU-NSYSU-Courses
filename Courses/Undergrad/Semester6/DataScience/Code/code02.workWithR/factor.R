d = data.frame(x=c(1,2,3), y=c('x','y','z'))
str(d)
##'data.frame':	3 obs. of  2 variables: 
##$ x: num  1 2 3 
##$ y: Factor w/ 3 levels "x","y","z": 1 2 3

# “set of strings” for  levels of categorical variables
factor('red',levels=c('red','orange'))
## [1] red
## Levels: red orange
factor('apple',levels=c('red','orange'))
## [1] <NA>
## Levels: red orange
