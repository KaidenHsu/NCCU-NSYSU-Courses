library(arules)
#Reading in the book data
bookbaskets <- read.transactions("bookdata.tsv.gz", format="single",
                sep="\t", cols=c("userid", "title"), rm.duplicates=T)

class(bookbaskets)
bookbaskets
dim(bookbaskets)
colnames(bookbaskets)[1:5]
rownames(bookbaskets)[1:5]

# the distribution of transaction sizes
basketSizes <- size(bookbaskets)
summary(basketSizes)

# Examining data
quantile(basketSizes, probs=seq(0,1,0.1))
library(ggplot2)
ggplot(data.frame(count=basketSizes)) +
  geom_density(aes(x=count), binwidth=1) +
  scale_x_log10()

# Frequent books
bookFreq <- itemFrequency(bookbaskets)
sum(bookFreq)
bookCount <- (bookFreq/sum(bookFreq))*sum(basketSizes)
summary(bookCount)
orderedBooks <- sort(bookCount, decreasing=T)
orderedBooks[1:10]
orderedBooks[1]/dim(bookbaskets)[1]

# Finding the association rules
#   Preprocessing
bookbaskets_use <- bookbaskets[basketSizes > 1]
dim(bookbaskets_use)

# Decide support & confidence
100/dim(bookbaskets_use)[1]
rules <- apriori(bookbaskets_use, parameter =list(support = 0.002, confidence=0.75))
summary(rules)

# Scoring rules
measures <- interestMeasure(rules,
              measure=c("coverage", "fishersExactTest"),
              transactions=bookbaskets_use)

# The five most confident rules discovered in the data
inspect(head((sort(rules, by="confidence")), n=5))

# Finding rules with restrictions
brules <- apriori(bookbaskets_use,
                  parameter =list(support = 0.001, confidence=0.6),
                  appearance=list(rhs=c("The Lovely Bones: A Novel"),
                  default="lhs"))
summary(brules)

# Inspecting rules
brulesConf <- sort(brules, by="confidence")
inspect(head(brulesConf, n=5))
inspect(head(lhs(brulesConf), n=5))

# Inspecting rules with restrictions
brulesSub <- subset(brules, subset=!(lhs %in% "Lucky : A Memoir"))
brulesConf <- sort(brulesSub, by="confidence")
inspect(head(lhs(brulesConf), n=5))

