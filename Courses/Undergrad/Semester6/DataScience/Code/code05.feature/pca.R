# Credit by thiagogm, https://www.r-bloggers.com/computing-and-visualizing-pca-in-r/

# Load data
data(iris)
head(iris, 3)
# log transform
log.ir <- log(iris[, 1:4])
ir.species <- iris[, 5]
# apply PCA - scale. = TRUE is highly advisable, but default is FALSE. 
ir.pca <- prcomp(log.ir, center = TRUE, scale. = TRUE)

print(ir.pca)

# summary method
summary(ir.pca)
# plot method (scree plot)
plot(ir.pca, type = "l")

library(ggbiplot)
g <- ggbiplot(ir.pca, obs.scale = 1, var.scale = 1, groups = ir.species)
g <- g + scale_color_discrete(name = '')
g <- g + theme(legend.direction = 'horizontal', legend.position = 'top')
print(g)

# ellipse: draw a normal data ellipse for each group
# ellipse.prob = 0.68 (68% of data falls within +-1 SD)
g <- ggbiplot(ir.pca, obs.scale = 1, var.scale = 1, 
              groups = ir.species, ellipse = TRUE, 
              circle = TRUE)
g <- g + scale_color_discrete(name = '')
g <- g + theme(legend.direction = 'horizontal', 
               legend.position = 'top')
print(g)

sum(ir.pca$rotation[1,]*ir.pca$rotation[1,])

# Predict PCs
predict(ir.pca, newdata=tail(log.ir, 2))
