custdata <- read.table('custdata.tsv',header=TRUE,sep='\t')
load("exampleData.rData")

custdata$income.lt.20K <- custdata$income < 20000
summary(custdata$income.lt.20K)

# Converting age into ranges
brks <- c(0, 25, 65, Inf)  	# Note: 1 
custdata$age.range <- cut(custdata$age,
    breaks=brks, include.lowest=T) 	# Note: 2 
summary(custdata$age.range) 	# Note: 3 

#Code1
summary(custdata$age)
meanage <- mean(custdata$age)
custdata$age.normalized <- custdata$age/meanage

#Code2
meanage <- mean(custdata$age)  	# Note: 1 
stdage <- sd(custdata$age)     	# Note: 2 
custdata$age.normalized <- (custdata$age-meanage)/stdage

custdata$income.fix <- log10(custdata$income)

signedlog10 <- function(x) {
 ifelse(abs(x) <= 1, 0, sign(x)*log10(abs(x)))
}
custdata$income.fix <- signedlog10(custdata$income)

# Sampling for modeling and validation
custdata$gp <- runif(dim(custdata)[1])
testSet <- subset(custdata, custdata$gp <= 0.1)
trainingSet <- subset(custdata, custdata$gp > 0.1)

# Record grouping
hh <- unique(hhdata$household_id) 
households <- data.frame(household_id = hh, gp = runif(length(hh))) 
hhdata <- merge(hhdata, households, by="household_id")
