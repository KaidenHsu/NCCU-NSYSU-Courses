slices <- c(10, 12, 4, 16, 8)
lbls <- c("US", "UK", "Australia", "Germany", "France")
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels
lbls <- paste(lbls,"%",sep="") # ad % to labels

pdf("test1.pdf")
pie(slices,labels = lbls, main="Pie Chart of Countries")
pie(slices,labels = lbls, main="Pie.Chart.of.Countries")
dev.off()
