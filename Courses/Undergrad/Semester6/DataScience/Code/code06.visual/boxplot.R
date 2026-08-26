library(ggplot2)

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()

# re-order
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy))

# for long variable names
ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = reorder(class, hwy, FUN = median), y = hwy)) +
  coord_flip()
