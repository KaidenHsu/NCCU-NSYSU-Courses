library('rpart')
load('GCDData.RData')

# Step1: A decision tree model for finding bad loan applications (11th week)
model <- rpart(Good.Loan ~
   Duration.in.month +
   Installment.rate.in.percentage.of.disposable.income +
   Credit.amount  +
   Other.installment.plans,
   data=d,
   control=rpart.control(maxdepth=4),
   method="class")
   
# Step2: plotting the confusion matrix
resultframe <- data.frame(Good.Loan=creditdata$Good.Loan,
                           pred=predict(model, type="class"))
(rtab <- table(resultframe))
