# Demonstrating side effects
x<-1
good <- function() { x <- 5}
good()
print(x)
## [1] 1
bad <- function() { x <<- 5}
bad()
print(x)
## [1] 5
