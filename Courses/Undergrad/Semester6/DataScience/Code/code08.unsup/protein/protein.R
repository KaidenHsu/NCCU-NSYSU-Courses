print_clusters <- function(labels, k) {
  for(i in 1:k) {
    print(paste("cluster", i))
    print(protein[labels==i,c("Country","RedMeat","Fish","Fr.Veg")])
  }
}

# read data
protein <- read.table("protein.txt", sep="\t", header=TRUE)

# scale your data
vars.to.use <- colnames(protein)[-1]
pmatrix <- scale(protein[,vars.to.use])
pcenter <- attr(pmatrix, "scaled:center")
pscale <- attr(pmatrix, "scaled:scale")

# Hierarchical clustering
d <- dist(pmatrix, method="euclidean")
pfit <- hclust(d, method="ward")
plot(pfit, labels=protein$Country)

# The dendrogram suggests five clusters = > draw the rectangles on the dendrogram
rect.hclust(pfit, k=5)

# Extracting the clusters found by hclust()
groups <- cutree(pfit, k=5)
print_clusters(groups, 5)

# VISUALIZING CLUSTERS by PCA
library(ggplot2)
princ <- prcomp(pmatrix)
nComp <- 4
project <- predict(princ, newdata=pmatrix)[,1:nComp]

project.plus <- cbind(as.data.frame(project),
                      cluster=as.factor(groups),
                      country=protein$Country)

ggplot(project.plus, aes(x=PC1, y=PC2)) +
  geom_point(aes(shape=cluster)) +
  geom_text(aes(label=country),
            hjust=0, vjust=1)

ggplot(project.plus, aes(x=PC3, y=PC4)) +
  geom_point(aes(shape=cluster)) +
  geom_text(aes(label=country),
            hjust=0, vjust=1)

# k-means
library(fpc)
kbest.p<-5
pclusters <- kmeans(pmatrix, kbest.p, nstart=100, iter.max=100)
pclusters
pclusters$centers
pclusters$size
groups <- pclusters$cluster
print_clusters(groups, kbest.p)

set.seed(3)
pclusters <- kmeans(pmatrix, kbest.p, nstart=1, iter.max=100)
pclusters$tot.withinss

set.seed(3)
pclusters <- kmeans(pmatrix, kbest.p, nstart=5, iter.max=100)
pclusters$tot.withinss

pclusters <- kmeans(pmatrix, kbest.p, nstart=5, iter.max=100)
pclusters$tot.withinss

# Evaluating clusterings with different numbers of clusters
library(reshape2)
source("../CH.R")
source("../WSS.R")
clustcrit <- ch_criterion(pmatrix, 10, method="hclust")
critframe <- data.frame(k=1:10, ch=scale(clustcrit$crit), wss=scale(clustcrit$wss))
critframe <- melt(critframe, id.vars=c("k"), variable.name="measure", value.name="score")
ggplot(critframe, aes(x=k, y=score, color=measure)) +
  geom_point(aes(shape=measure)) + geom_line(aes(linetype=measure)) +
  scale_x_continuous(breaks=1:10, labels=1:10)

# THE KMEANSRUNS FUNCTION FOR PICKING K
clustering.ch <- kmeansruns(pmatrix, krange=1:10, criterion="ch")
clustering.ch$bestk
clustering.ch$crit
clustering.asw <- kmeansruns(pmatrix, krange=1:10, criterion="asw")
clustering.asw$bestk
critframe <- data.frame(k=1:10, ch=scale(clustering.ch$crit),
                        asw=scale(clustering.asw$crit))
critframe <- melt(critframe, id.vars=c("k"), variable.name="measure", value.name="score")
ggplot(critframe, aes(x=k, y=score, color=measure)) +geom_point(aes(shape=measure)) + geom_line(aes(linetype=measure)) + scale_x_continuous(breaks=1:10, labels=1:10)

#######################################################
# Use bootstrap to validate the stability of clusters
#######################################################
# Running clusterboot() with hclust
cboot.hclust <- clusterboot(pmatrix, clustermethod=hclustCBI,method="ward.D", k=kbest.p)
summary(cboot.hclust$result)
groups<-cboot.hclust$result$partition
print_clusters(groups, kbest.p)
cboot.hclust$bootmean
cboot.hclust$bootbrd

# Running clusterboot() with k-means
cboot<-clusterboot(pmatrix, clustermethod=kmeansCBI, runs=100,iter.max=100, krange=kbest.p, seed=15555)
groups <- cboot$result$partition
print_clusters(cboot$result$partition, kbest.p)
cboot$bootmean
cboot$bootbrd
