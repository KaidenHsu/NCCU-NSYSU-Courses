nflips <- 100
nheads <- c(25, 45, 50, 60) # number of heads
# what are the probabilities of observing at most that number of heads on a fair coin?
left.tail <- pbinom(nheads, nflips, 0.5)
sprintf("%2.2f", left.tail)
# [1] "0.00" "0.18" "0.54" "0.98”

# the probabilities of observing more than that number of heads on a fair coin?
right.tail <- pbinom(nheads, nflips, 0.5, lower.tail=F)
sprintf("%2.2f", right.tail)
# [1] "1.00" "0.82" "0.46" "0.02"
