d <- data.frame(y=(1:10)^2,x=1:10)
# a linear regression model is fit to the data in the data frame d,
# with y as the dependent variable and x as the independent variable
model <- lm(y~x,data=d)
d$prediction <- predict(model,newdata=d)
library('ggplot2')
ggplot(data=d) + geom_point(aes(x=x,y=y)) +
  geom_line(aes(x=x,y=prediction),color='blue') +
  geom_segment(aes(x=x,y=prediction,yend=y,xend=x)) + scale_y_continuous('')

#absolute error
sum(abs(d$prediction-d$y))

#mean absolute error
sum(abs(d$prediction-d$y))/length(d$y)

#relative absolute error 
sum(abs(d$prediction-d$y))/sum(abs(d$y))
