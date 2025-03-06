library(ggplot2)
x <- seq(from=-5, to=5, length.out=100) # the interval [-5 5]
f <- dnorm(x)                      # normal with mean 0 and sd 1
ggplot(data.frame(x=x,y=f), aes(x=x,y=y)) + geom_line()

u <- rnorm(1000)
ggplot(data.frame(x=u), aes(x=x)) + geom_density() + 
  geom_line(data=data.frame(x=x,y=f), aes(x=x,y=y), linetype=2)

qnorm(0.75)
pnorm(0.6744898)
