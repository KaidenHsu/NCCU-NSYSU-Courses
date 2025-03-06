# German bank credit dataset
d <- read.table(paste('http://archive.ics.uci.edu/ml/','machine-learning-databases/statlog/german/german.data',sep=''),stringsAsFactors=F,header=F)
head(d)

# schema documentation or data dictionary
colnames(d) <- c('Status.of.existing.checking.account',
   'Duration.in.month',  'Credit.history', 'Purpose',
   'Credit.amount', 'Savings account/bonds',
   'Present.employment.since',
   'Installment.rate.in.percentage.of.disposable.income',
   'Personal.status.and.sex', 'Other.debtors/guarantors',
   'Present.residence.since', 'Property', 'Age.in.years',
   'Other.installment.plans', 'Housing',
   'Number.of.existing.credits.at.this.bank', 'Job',
   'Number.of.people.being.liable.to.provide.maintenance.for',
   'Telephone', 'foreign.worker', 'Good.Loan')

# postprocess
d$Good.Loan <- as.factor(ifelse(d$Good.Loan==1,'GoodLoan','BadLoan'))

# Building a map to interpret loan use codes
mapping <- list(
   'A40'='car (new)',
   'A41'='car (used)',
   'A42'='furniture/equipment',
   'A43'='radio/television',
   'A44'='domestic appliances')

for(i in 1:(dim(d))[2]) {             	# Note: 1 
   if(class(d[,i])=='character') {
      d[,i] <- as.factor(as.character(mapping[d[,i]]))  	# Note: 2 
   }
}

summary(d$Purpose)

# Summary of Good.Loan and Purpose
table(d$Purpose,d$Good.Loan)
