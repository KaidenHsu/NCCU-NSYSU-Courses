c('a', 'b')[[2]]
c('a', 'b')[2]

#signal outof-bounds access
c('a','b')[[7]]
##Error in c("a", "b")[[7]] : subscript out of bounds
c('a','b')[7]
##[1] NA

#[[]] unwraps the returned value
list(a='b')['a']
##$a[1] 
##"b”
list(a='b')[['a']]
##[1] "b"

# [] accept vectors as its argument
list(a='b')[c('a','a')]
##$a
##[1] "b”
##$a
##[1] "b”
list(a='b')[[c('a','a')]]
##Error in list(a = "b")[[c("a", "a")]] : subscript out of bounds
