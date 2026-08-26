# load data
d <- read.table('orange_small_train.data.gz',  	# Note: 1 
   header=T,
   sep='\t',
   na.strings=c('NA','')) 	# Note: 2 
churn <- read.table('orange_small_train_churn.labels.txt',
   header=F,sep='\t') 	# Note: 3 
d$churn <- churn$V1 	# Note: 4 
appetency <- read.table('orange_small_train_appetency.labels.txt',
   header=F,sep='\t')
d$appetency <- appetency$V1 	# Note: 5 
upselling <- read.table('orange_small_train_upselling.labels.txt',
   header=F,sep='\t')

d$upselling <- upselling$V1 	# Note: 6 
set.seed(729375) 	# Note: 7 
d$rgroup <- runif(dim(d)[[1]])
dTrainAll <- subset(d,rgroup<=0.9)

# Function to build single-variable models for categorical variables
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

# Running a repeated cross-validation experiment
var <- 'Var217'
aucs <- rep(0,100)
for(rep in 1:length(aucs)) {   	# Note: 1 
   useForCalRep <- rbinom(n=dim(dTrainAll)[[1]],size=1,prob=0.1)>0  	# Note: 2 
   predRep <- mkPredC(dTrainAll[!useForCalRep,outcome],  	# Note: 3 
      dTrainAll[!useForCalRep,var],
      dTrainAll[useForCalRep,var])
   aucs[rep] <- calcAUC(predRep,dTrainAll[useForCalRep,outcome])  	# Note: 4 
 }
mean(aucs)
sd(aucs)

# Empirically cross-validating performance
fCross <- function() {
   useForCalRep <- rbinom(n=dim(dTrainAll)[[1]],size=1,prob=0.1)>0
   predRep <- mkPredC(dTrainAll[!useForCalRep,outcome],
      dTrainAll[!useForCalRep,var],
      dTrainAll[useForCalRep,var])
   calcAUC(predRep,dTrainAll[useForCalRep,outcome])
}
aucs <- replicate(100,fCross())
