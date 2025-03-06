# Euclidean distance (squared Euclidean distance = L2 distance)
#   when all the data is real-valued (quantitative)
edist(x, y) <- sqrt((x[1]-y[1])^2 + (x[2]-y[2])^2 + ...)

# Hamming distance
#   For categorical variables (male /female , or small /medium /large )
hdist(x, y) <- sum((x[1] != y[1]) + (x[2] != y[2]) + ...)

# Manhattan (city block) distance
#   L1  distance, # of horizontal and vertical units from one point to the other
mdist(x, y) <- sum(abs(x[1]-y[1]) + abs(x[2]-y[2]) + ...)

# Cosine similarity
dot(x, y) <- sum( x[1]*y[1] + x[2]*y[2] + ... )
cossim(x, y) <- dot(x, y)/(sqrt(dot(x,x)*dot(y,y)))
1 - 2*acos(cossim(x,y))/pi
