library(ggplot2)
library(dplyr)

# by count
ggplot(data = diamonds) +
  geom_count(mapping = aes(x = cut, y = color))

# similar to heatmap
diamonds %>% 
  count(color, cut) %>%  
  ggplot(mapping = aes(x = color, y = cut)) +
  geom_tile(mapping = aes(fill = n))

# two continuous variables
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price))

# add transparency
ggplot(data = diamonds) + 
  geom_point(mapping = aes(x = carat, y = price), alpha = 1 / 100)

# rectangular bins
ggplot(data = diamonds) +
  geom_bin2d(mapping = aes(x = carat, y = price))

# bin one continuous variable into a categorical variable
ggplot(data = diamonds, mapping = aes(x = carat, y = price)) + 
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))
