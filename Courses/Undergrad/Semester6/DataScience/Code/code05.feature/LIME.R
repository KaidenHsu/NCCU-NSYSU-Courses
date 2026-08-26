iris <- iris

iris$class <- as.numeric(iris$Species == "setosa")

set.seed(2345)
intrain <- runif(nrow(iris)) < 0.75
train <- iris[intrain,]
test <- iris[!intrain,]

head(train)

##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species class
## 1          5.1         3.5          1.4         0.2  setosa     1
## 2          4.9         3.0          1.4         0.2  setosa     1
## 3          4.7         3.2          1.3         0.2  setosa     1
## 4          4.6         3.1          1.5         0.2  setosa     1
## 5          5.0         3.6          1.4         0.2  setosa     1
## 6          5.4         3.9          1.7         0.4  setosa     1

source("lime_iris_example.R")

input <- as.matrix(train[, 1:4])
model <- fit_iris_example(input, train$class)

library(lime)
explainer <- lime(train[,1:4],
                  model = model,
                  bin_continuous = TRUE,
                  n_bins = 10)

(example <- test[5, 1:4, drop=FALSE])
explanation <- lime::explain(example,
                             explainer,
                             n_labels = 1,
                             n_features = 4)
plot_features(explanation)

(example <- test[c(13, 24), 1:4])
test$class[c(13,24)]
explanation <- explain(example,
                       explainer,
                       n_labels = 1,
                       n_features = 4,
                       kernel_width = 0.5)

plot_features(explanation)
