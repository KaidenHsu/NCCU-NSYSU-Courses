library(tidyverse)

# plot
ggplot(data = diamonds) + 
 geom_bar(mapping = aes(x = cut))

# count 
diamonds %>% 
  count(cut)

# A variable is continuous 
ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5)

# count
diamonds %>% 
  count(cut_width(carat, 0.5))

#overlay multiple histograms in the same plot
smaller <- diamonds %>% 
  filter(carat < 3)
ggplot(data = smaller, mapping = aes(x = carat, colour = cut)) +
  geom_freqpoly(binwidth = 0.1)
