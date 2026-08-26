# NULL vs NA
b<-c()
length(b)
##[1] 0
is.null(b)
##[1] TRUE
is.na(b)
##logical(0)
##Warning message:In is.na(b) : is.na() applied to non-(list or vector) of type 'NULL’
