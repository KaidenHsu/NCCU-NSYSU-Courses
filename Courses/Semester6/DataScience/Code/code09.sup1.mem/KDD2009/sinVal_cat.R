# example 6.2 of section 6.2.1 
# (example 6.2 of section 6.2.1)  : Memorization methods : Building single-variable models : Using categorical features 
# Title: Plotting churn grouped by variable 218 levels 

table218 <- table(
   Var218=dTrain[,'Var218'], 	# Note: 1 
   churn=dTrain[,outcome], 	# Note: 2 
   useNA='ifany') 	# Note: 3 
print(table218)

##       churn
## Var218    -1     1
##   cJvF 19245  1220
##   UYBR 17860  1618
##   <NA>   423   152
# Note this listing was updated: 10-14-2014 as some of results in the book were
# accidentally from older code.  Will update later listings as we go forward.

# Note 1: 
#   Tabulate levels of Var218. 

# Note 2: 
#   Tabulate levels of churn outcome. 

# Note 3: 
#   Include NA values in tabulation. 

####################################################################
# example 6.3 of section 6.2.1 
# (example 6.3 of section 6.2.1)  : Memorization methods : Building single-variable models : Using categorical features 
# Title: Churn rates grouped by variable 218 codes 

print(table218[,2]/(table218[,1]+table218[,2]))
##       cJvF       UYBR       <NA>
## 0.05994389 0.08223821 0.26523297

####################################################################
# example 6.4 of section 6.2.1 
# (example 6.4 of section 6.2.1)  : Memorization methods : Building single-variable models : Using categorical features 
# Title: Function to build single-variable models for categorical variables 

mkPredC <- function(outCol,varCol,appCol) { 	# Note: 1 
   pPos <- sum(outCol==pos)/length(outCol) 	# Note: 2 
   naTab <- table(as.factor(outCol[is.na(varCol)]))
   pPosWna <- (naTab/sum(naTab))[pos] 	# Note: 3 
   vTab <- table(as.factor(outCol),varCol)
   pPosWv <- (vTab[pos,]+1.0e-3*pPos)/(colSums(vTab)+1.0e-3) 	# Note: 4 
   pred <- pPosWv[appCol] 	# Note: 5 
   pred[is.na(appCol)] <- pPosWna 	# Note: 6 
   pred[is.na(pred)] <- pPos 	# Note: 7 
   pred 	# Note: 8 
}

# Note 1: 
#   Given a vector of training outcomes (outCol), 
#   a categorical training variable (varCol), and a 
#   prediction variable (appCol), use outCol and 
#   varCol to build a single-variable model and then 
#   apply the model to appCol to get new 
#   predictions. 

# Note 2: 
#   Get stats on how often outcome is positive 
#   during training. 

# Note 3: 
#   Get stats on how often outcome is positive for 
#   NA values of variable during training. 

# Note 4: 
#   Get stats on how often outcome is positive, 
#   conditioned on levels of training variable. 

# Note 5: 
#   Make predictions by looking up levels of 
#   appCol. 

# Note 6: 
#   Add in predictions for NA levels of 
#   appCol. 

# Note 7: 
#   Add in predictions for levels of appCol that 
#   werenot known during training. 

# Note 8: 
#   Return vector of predictions. 

####################################################################
# example 6.5 of section 6.2.1 
# (example 6.5 of section 6.2.1)  : Memorization methods : Building single-variable models : Using categorical features 
# Title: Applying single-categorical variable models to all of our datasets 

for(v in catVars) {
  pi <- paste('pred',v,sep='')
  dTrain[,pi] <- mkPredC(dTrain[,outcome],dTrain[,v],dTrain[,v])
  dCal[,pi] <- mkPredC(dTrain[,outcome],dTrain[,v],dCal[,v])
  dTest[,pi] <- mkPredC(dTrain[,outcome],dTrain[,v],dTest[,v])
}

####################################################################
library('ROCR')

calcAUC <- function(predcol,outcol) {
    perf <- performance(prediction(predcol,outcol==pos),'auc')
    as.numeric(perf@y.values)
 }

for(v in catVars) {
   pi <- paste('pred',v,sep='')
   aucTrain <- calcAUC(dTrain[,pi],dTrain[,outcome])
   if(aucTrain>=0.8) {
      aucCal <- calcAUC(dCal[,pi],dCal[,outcome])
      print(sprintf("%s, trainAUC: %4.3f calibrationAUC: %4.3f",
        pi,aucTrain,aucCal))
   }
}

## [1] "predVar200, trainAUC: 0.828 calibrationAUC: 0.527"
## [1] "predVar202, trainAUC: 0.829 calibrationAUC: 0.522"
## [1] "predVar214, trainAUC: 0.828 calibrationAUC: 0.527"
## [1] "predVar217, trainAUC: 0.898 calibrationAUC: 0.553"

