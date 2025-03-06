c(T,T,F,F) == c(T,F,T,F)
## [1]  TRUE FALSE FALSE  TRUE
c(T,T,F,F) & c(T,F,T,F)
## [1]  TRUE FALSE FALSE FALSE
c(T,T,F,F) | c(T,F,T,F)
## [1]  TRUE  TRUE  TRUE FALSE

## short vs long forms
c(T,T,F,F) && c(T,F,T,F)
##TRUE
