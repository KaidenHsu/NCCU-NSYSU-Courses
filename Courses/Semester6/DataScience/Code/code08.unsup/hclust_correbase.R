x=matrix (rnorm (30*3) , ncol =3)
dd=as.dist(1- cor(t(x)))
plot(hclust (dd, method ="complete"), main=" Complete Linkage with Correlation -Based Distance ", xlab="", sub ="")