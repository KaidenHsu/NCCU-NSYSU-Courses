#Building simulated A/B test data
set.seed(123515)
d <- rbind( 	# Note: 1 
   data.frame(group='A',converted=rbinom(100000,size=1,p=0.05)), 	# Note: 2 
   data.frame(group='B',converted=rbinom(10000,size=1,p=0.055)) 	# Note: 3 
)

#Summarizing the A/B test into a contingency table
tab <- table(d)
print(tab)

# the null hypothesis : conversion is independent of group
fisher.test(tab)

# observed A and B rates
(aConversionRate <- tab['A','1']/sum(tab['A',]))
## [1] 0.05021
(bConversionRate <- tab['B','1']/sum(tab['B',]))
## [1] 0.0602
(commonRate <- sum(tab[,'1'])/sum(tab))
## [1] 0.05111818

# Frequentist significance test
print(pbinom( 	
   lower.tail=F, 	
   q=tab['B','1']-1, 	
   size=sum(tab['B',]), 	
   prob=commonRate 	
   )) 
