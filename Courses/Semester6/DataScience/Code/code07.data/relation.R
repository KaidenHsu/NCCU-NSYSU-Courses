custdata <- read.table('custdata.tsv',header=TRUE,sep='\t')
load("exampleData.rData")

x <- runif(100)   	# Note: 1 
y <- x^2 + 0.2*x   	# Note: 2 
ggplot(data.frame(x=x,y=y), aes(x=x,y=y)) + geom_line()

# SCATTER PLOTS AND SMOOTHING CURVES   
custdata2 <- subset(custdata, (custdata$age > 0 & custdata$age < 100 & custdata$income > 0))

# line plot not a good idea
ggplot(custdata2, aes(x=custdata2$age,y=custdata2$income)) + geom_line()

# SCATTER PLOTS 
ggplot(custdata2, aes(x=age, y=income)) + geom_point() + ylim(0, 200000)

# linear fit
ggplot(custdata2, aes(x=age, y=income)) + geom_point() + stat_smooth(method="lm") + ylim(0, 200000)
cor(custdata2$age, custdata2$income)

# smoothing curve
ggplot(custdata2, aes(x=age, y=income)) + geom_point() + geom_smooth() + ylim(0, 200000)

# high-volume situations => HEXBIN PLOTS
library(hexbin) 	# Note: 1 
ggplot(custdata2, aes(x=age, y=income)) +
   geom_hex(binwidth=c(5, 10000)) +   	# Note: 2 
   geom_smooth(color="white", se=F) +  ylim(0,200000)

# smoothing curve for boolean variables
ggplot(custdata2, aes(x=age, y=as.numeric(health.ins))) + 
geom_point(position=position_jitter(w=0.05, h=0.05)) +  geom_smooth()

# stacked bar chart FOR TWO CATEGORICAL VARIABLES
ggplot(custdata) + geom_bar(aes(x=marital.stat,
   fill=health.ins)) 	# Note: 1 

# Side-by-side bar chart
ggplot(custdata) + geom_bar(aes(x=marital.stat,
   fill=health.ins),
   position="dodge")      	# Note: 2 

# filled bar chart
ggplot(custdata) + geom_bar(aes(x=marital.stat,
   fill=health.ins),
   position="fill")        	# Note: 3

# Plotting data with a rug
ggplot(custdata2) +                                          	# Note: 1 
   geom_bar(aes(x=housing.type, fill=marital.stat ), position="dodge") +
   theme(axis.text.x = element_text(angle = 45, hjust = 1))   	# Note: 2 


# Plotting a bar chart without facets
ggplot(custdata2) +                                          	# Note: 3 
   geom_bar(aes(x=marital.stat), position="dodge", fill="darkgray") +
   facet_wrap(~housing.type, scales="free_y") +                
   theme(axis.text.x = element_text(angle = 45, hjust = 1))   

