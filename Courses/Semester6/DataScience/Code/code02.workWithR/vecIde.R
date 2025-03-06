# test if two vectors are a match?
c(T,T,F,F) == c(T,F,T,F)
## [1]  TRUE FALSE FALSE  TRUE
identical(c(T,T,F,F),c(T,F,T,F))
##[1] FALSE
all.equal(c(T,T,F,F),c(T,F,T,F))
##[1] "2 element mismatches
