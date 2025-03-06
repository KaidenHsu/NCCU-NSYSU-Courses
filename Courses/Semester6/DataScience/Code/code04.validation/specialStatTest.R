# Building a synthetic uncorrelated income example
set.seed(235236) 	# Note: 1 
d <- data.frame(EarnedIncome=100000*rlnorm(100),  CapitalGains=100000*rlnorm(100)) 
print(with(d,cor(EarnedIncome,CapitalGains)))

#Calculating the (non)significance of the observed correlation
with(d,cor(EarnedIncome,CapitalGains,method='spearman'))
# [1] 0.03083108
with(d,cor.test(EarnedIncome,CapitalGains,method='spearman'))
#       Spearman's rank correlation rho
#data:  EarnedIncome and CapitalGains
#S = 161512, p-value = 0.7604
#alternative hypothesis: true rho is not equal to 0
#sample estimates:
#       rho
#0.03083108


ctest <- with(d, cor.test(EarnedIncome,CapitalGains,method='spearman'))
sigr::wrapCorTest(ctest)

d <- data.frame(x = c(1,2,3,4,5,6,7,7)
                ,y = c(1,1,2,2,3,3,4,4))
ct <- cor.test(d$x, d$y)
sigr::wrapCorTest(ct)