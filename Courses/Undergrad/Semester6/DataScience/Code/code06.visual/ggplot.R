library("ggplot2")
# won???t supply those names. That saves typing, and, by reducing the amount of boilerplate, makes it easier to see what???s different between plots
ggplot(data = faithful, mapping = aes(x = eruptions)) + 
  geom_freqpoly(binwidth = 0.25)

ggplot(faithful, aes(eruptions)) + 
  geom_freqpoly(binwidth = 0.25)
