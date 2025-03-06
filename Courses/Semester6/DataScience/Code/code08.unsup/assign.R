sqr_edist <- function(x, y) {
  sum((x-y)^2)
}

assign_cluster <- function(newpt, centers,xcenter=0, xscale=1) {
  xpt <- (newpt - xcenter)/xscale
  dists <- apply(centers, 1, 	FUN=function(c0){sqr_edist(c0, xpt)})
  which.min(dists)
}

# An example of assigning points to clusters
rnorm.multidim <- function(n, mean, sd, colstr="x") {
  ndim <- length(mean)
  data <- NULL
  for(i in 1:ndim) {
    col <- rnorm(n, mean=mean[[i]], sd=sd[[i]])
    data<-cbind(data, col)
  }
  cnames <- paste(colstr, 1:ndim, sep='')
  colnames(data) <- cnames
  data
}

mean1 <- c(1, 1, 1)
sd1 <- c(1, 2, 1)

mean2 <- c(10, -3, 5)
sd2 <- c(2, 1, 2)

mean3 <- c(-5, -5, -5)
sd3 <- c(1.5, 2, 1)

clust1 <- rnorm.multidim(100, mean1, sd1)
clust2 <- rnorm.multidim(100, mean2, sd2)
clust3 <- rnorm.multidim(100, mean3, sd3)

toydata <- rbind(clust3, rbind(clust1, clust2))
tmatrix <- scale(toydata)
tcenter <- attr(tmatrix, "scaled:center")
tscale<-attr(tmatrix, "scaled:scale")
kbest.t <- 3
tclusters <- kmeans(tmatrix, kbest.t, nstart=100, iter.max=100)
tclusters$size
unscale <- function(scaledpt, centervec, scalevec) {
  scaledpt*scalevec + centervec
}
unscale(tclusters$centers[1,], tcenter, tscale)
Mean2
assign_cluster(rnorm.multidim(1, mean1, sd1),
               tclusters$centers,
               tcenter, tscale)
