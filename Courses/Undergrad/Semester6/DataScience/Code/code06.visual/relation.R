x <- runif(100)
y <- x^2 + 0.2*x

library(ggplot2)
ggplot(data.frame(x=x, y=y), aes(x=x, y=y)) + geom_line()
# ggplot(custdata2, aes(x=age, y=income))
#   + geom_point() + geom_smooth + ylim(0, 200000)
