# Primary R data typ
a<-c(1:10)
length(a)
##[1] 10
a[1]
##[1] 1
a[[1]]
##[1] 1

# [] vs [[]]
a[11]
##[1] NA
a[[11]]
##Error in a[[11]] : subscript out of bounds
