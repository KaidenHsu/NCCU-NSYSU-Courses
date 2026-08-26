d = data.frame(x=c(1,2,3), y=c('x','y','z'))

# Select columns
d[,1]
d[,'x']
d[['x']]
d$x

# Select rows
d[c(1,3),]
subset(d,c(T,F,T))
