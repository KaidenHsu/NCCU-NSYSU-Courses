# Calculates the minimum sample size required
estimate <- function(targetRate,difference,errorProb) {
    ceiling(-log(errorProb)*targetRate/(difference^2))
}

(est <- estimate(0.045,0.004,0.05))

# measure large performance differences with high confidence
estimate(0.045,0.005,0.04)
# measure small performance differences with even moderate confidence.
estimate(0.045,0.003,0.06)



# Calculates the error probability for a given sample size
errorProb <- function(targetRate,difference,size) { 	# Note: 1 
   pbinom(ceiling((targetRate-difference)*size),
      size=size,prob=targetRate) 
}

print(errorProb(0.045,0.004,est))



# Binary search to find the threshold where fEventuallyNegative becomes non-positive
binSearchNonPositive <- function(fEventuallyNegative) { 	# Note: 3 
  low <- 1
  high <- low+1
  while(fEventuallyNegative(high)>0) {
    high <- 2*high
  }
  while(high>low+1) {
    m <- low + (high-low) %/% 2
    if(fEventuallyNegative(m)>0) {
       low <- m
    } else {
       high <- m
    }
  }
  high
}

# Calculate the actual sample size needed to achieve the desired error probability
actualSize <- function(targetRate,difference,errorProb) {
   binSearchNonPositive(function(n) {
       errorProb(targetRate,difference,n) - errorProb })
}

size <- actualSize(0.045,0.004,0.05) 	# Note: 4 
print(size) 
## [1] 7623
print(errorProb(0.045,0.004,size))
## [1] 0.04983659
