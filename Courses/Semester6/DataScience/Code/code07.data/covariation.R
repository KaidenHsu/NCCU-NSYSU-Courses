# how the price of a diamond varies with its quality?
# It???s hard to see the difference in distribution because the overall counts differ so much:
ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)

# use density, that the area under each frequency polygon is one.
ggplot(data = diamonds, mapping = aes(x = price, y = ..density..)) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)

# by boxplot
ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot()

ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot(notch=T)
