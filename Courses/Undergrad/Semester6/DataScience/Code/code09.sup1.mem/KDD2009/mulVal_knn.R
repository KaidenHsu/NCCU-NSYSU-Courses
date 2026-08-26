# example 6.11 of section 6.3.1 
# (example 6.11 of section 6.3.1)  : Memorization methods : Building models using many variables : Variable selection 
# Title: Basic variable selection 

#    Each variable we use represents a chance of explaining
# more of the outcome variation (a chance of building a better
# model) but also represents a possible source of noise and
# overfitting. To control this effect, we often preselect
# which subset of variables we’ll use to fit. Variable
# selection can be an important defensive modeling step even
# for types of models that “don’t need it” (as seen with
# decision trees in section 6.3.2).  Listing 6.11 shows a
# hand-rolled variable selection loop where each variable is
# scored according to a deviance inspired score, where a
# variable is scored with a bonus proportional to the change
# in in scaled log likelihood of the training data.  We could
# also try an AIC (Akaike information criterion) by
# subtracting a penalty proportional to the complexity of the
# variable (which in this case is 2^entropy for categorical
# variables and a stand-in of 1 for numeric variables).  The
# score is a bit ad hoc, but tends to work well in selecting
# variables. Notice we’re using performance on the calibration
# set (not the training set) to pick variables. Note that we
# don’t use the test set for calibration; to do so lessens the
# reliability of the test set for model quality confirmation.

logLikelyhood <- function(outCol,predCol) { 	# Note: 1 
  sum(ifelse(outCol==pos,log(predCol),log(1-predCol)))
}

selVars <- c()
minStep <- 5
baseRateCheck <- logLikelyhood(dCal[,outcome],
   sum(dCal[,outcome]==pos)/length(dCal[,outcome]))

for(v in catVars) {  	# Note: 2 
  pi <- paste('pred',v,sep='')
  liCheck <- 2*((logLikelyhood(dCal[,outcome],dCal[,pi]) -
      baseRateCheck))
  if(liCheck>minStep) {
     print(sprintf("%s, calibrationScore: %g",
        pi,liCheck))
     selVars <- c(selVars,pi)
  }
}

for(v in numericVars) { 	# Note: 3 
  pi <- paste('pred',v,sep='')
  liCheck <- 2*((logLikelyhood(dCal[,outcome],dCal[,pi]) -
      baseRateCheck))
  if(liCheck>=minStep) {
     print(sprintf("%s, calibrationScore: %g",
        pi,liCheck))
     selVars <- c(selVars,pi)
  }
}

# Note 1: 
#   Define a convenience function to compute log 
#   likelihood. 

# Note 2: 
#   Run through categorical variables and pick 
#   based on a deviance improvement (related to 
#   difference in log likelihoods; see chapter 
#   3). 

# Note 3: 
#   Run through numeric variables and pick 
#   based on a deviance improvement. 

##########################################################################
# example 6.19 of section 6.3.3 
# (example 6.19 of section 6.3.3)  : Memorization methods : Building models using many variables : Using nearest neighbor methods 
# Title: Running k-nearest neighbors 

library('class')
nK <- 200
knnTrain <- dTrain[,selVars]  	# Note: 1 
knnCl <- dTrain[,outcome]==pos 	# Note: 2 
knnPred <- function(df) { 	# Note: 3 
    knnDecision <- knn(knnTrain,df,knnCl,k=nK,prob=T)
    ifelse(knnDecision==TRUE, 	# Note: 4 
       attributes(knnDecision)$prob,
       1-(attributes(knnDecision)$prob))
}
print(calcAUC(knnPred(dTrain[,selVars]),dTrain[,outcome]))
## [1] 0.7443927
print(calcAUC(knnPred(dCal[,selVars]),dCal[,outcome]))
## [1] 0.7119394
print(calcAUC(knnPred(dTest[,selVars]),dTest[,outcome]))
## [1] 0.718256

# Note 1: 
#   Build a data frame with only the variables we 
#   wish to use for classification. 

# Note 2: 
#   Build a vector with the known training 
#   outcomes. 

# Note 3: 
#   Bind the knn() training function with our data 
#   in a new function. 

# Note 4: 
#   Convert knn’s unfortunate convention of 
#   calculating probability as “proportion of the 
#   votes for the winning class” into the more useful 
#   “calculated probability of being a positive 
#   example.” 

##########################################################################
# example 6.20 of section 6.3.3 
# (example 6.20 of section 6.3.3)  : Memorization methods : Building models using many variables : Using nearest neighbor methods 
# Title: Platting 200-nearest neighbor performance 

dCal$kpred <- knnPred(dCal[,selVars])
ggplot(data=dCal) +
   geom_density(aes(x=kpred,
      color=as.factor(churn),linetype=as.factor(churn)))

##########################################################################
# example 6.21 of section 6.3.3 
# (example 6.21 of section 6.3.3)  : Memorization methods : Building models using many variables : Using nearest neighbor methods 
# Title: Plotting the receiver operating characteristic curve 

plotROC <- function(predcol,outcol) {
   perf <- performance(prediction(predcol,outcol==pos),'tpr','fpr')
   pf <- data.frame(
      FalsePositiveRate=perf@x.values[[1]],
      TruePositiveRate=perf@y.values[[1]])
   ggplot() +
      geom_line(data=pf,aes(x=FalsePositiveRate,y=TruePositiveRate)) +
      geom_line(aes(x=c(0,1),y=c(0,1)))
}
print(plotROC(knnPred(dTest[,selVars]),dTest[,outcome]))
