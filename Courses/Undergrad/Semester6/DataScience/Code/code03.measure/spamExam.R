library(ggplot2) 

# load data
spamD <- read.table('spamD.tsv',header=T,sep='\t')
spamTrain <- subset(spamD,spamD$rgroup>=10)
spamTest <- subset(spamD,spamD$rgroup<10)
spamVars <- setdiff(colnames(spamD),list('rgroup','spam'))

# build model
spamFormula <- as.formula(paste('spam=="spam"',
   paste(spamVars,collapse=' + '),sep=' ~ '))
spamModel <- glm(spamFormula,family=binomial(link='logit'), data=spamTrain)

# apply model
spamTrain$pred <- predict(spamModel,newdata=spamTrain, type='response')
spamTest$pred <- predict(spamModel,newdata=spamTest, type='response')

# print predicted result
print(with(spamTrain,table(y=spam,glmPred=pred>0.5)))
print(with(spamTest,table(y=spam,glmPred=pred>0.5)))
sample <- spamTest[c(7,35,224,327),c('spam','pred')]
print(sample)
cM <- table(truth=spamTest$spam, prediction=spamTest$pred>0.5)
print(cM)

# Making a double density plot
ggplot(data=spamTest) + 
  geom_density(aes(x=pred,color=spam,linetype=spam))

# AUC evaluation
library('ROCR')
eval <- prediction(spamTest$pred,spamTest$spam)
plot(performance(eval,"tpr","fpr"))
print(attributes(performance(eval,'auc'))$y.values[[1]])

# LOG LIKELIHOOD
likeli_model <- sum(ifelse(spamTest$spam=='spam', log(spamTest$pred), log(1-spamTest$pred)))
likeli_model/dim(spamTest)[[1]]

# Computing the null model’s log likelihood
# pNull is the proportion of emails that are spam
pNull <- sum(ifelse(spamTest$spam=='spam',1,0))/dim(spamTest)[[1]]
likeli_nullModel <- sum(ifelse(spamTest$spam=='spam',1,0))*log(pNull) + sum(ifelse(spamTest$spam=='spam',0,1))*log(1-pNull)

# calculate pseudo R-squared
S <- 0
1 - (-2*(likeli_model-S))/(-2*(likeli_nullModel-S))
#0.56
# The result (0.56) suggests that approximately 56% of the uncertainty
# in the dependent variable is explained by the predictors in the model,
# as compared to a model with no predictors.
