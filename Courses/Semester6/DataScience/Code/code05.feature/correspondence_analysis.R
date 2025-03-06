# This code is excerpted from the website:
# Understanding the Math of Correspondence Analysis
# https://www.displayr.com/math-correspondence-analysis/


# contingency table
N = matrix(c(5, 18, 19, 12, 3, 7, 46, 29, 40, 7, 2, 20, 39, 49, 16), 
           nrow = 5,
           dimnames = list(
             "Level of education" = c("Some primary", "Primary completed", "Some secondary", "Secondary completed", "Some tertiary"),
             "Category of readership" = c("Glance", "Fairly thorough", "Very thorough")))  

# compute observed proportions
n = sum(N) # n = sum of all entries in the table
P = N/n

# row and column masses
column.masses = colSums(P)
row.masses = rowSums(P)

# expected proportions E
# the value that we would expect to see under the assumption that
# there is no relationship between education and readership.
E = row.masses %o% column.masses

# residuals
R = (P - E)

# indexed residuals I
I = R / E

# singular values, eigenvalues & variance
Z = I * sqrt(E)
SVD = svd(Z)
rownames(SVD$u) = rownames(P)
rownames(SVD$v) = colnames(P)

eigenvalues = SVD$d^2

# standard coordinates
standard.coordinates.rows = sweep(SVD$u, 1, sqrt(row.masses), "/")
standard.coordinates.columns = sweep(SVD$v, 1, sqrt(column.masses), "/")

# principal coordinates
principal.coordinates.rows = sweep(standard.coordinates.rows, 2, SVD$d, "*")
principal.coordinates.columns = sweep(standard.coordinates.columns, 2, SVD$d, "*")

# quality
pc = rbind(principal.coordinates.rows, principal.coordinates.columns) 
# Calculate proportion table
prop_table = prop.table(pc ^ 2, 1)
# Round the results to three decimal places
round(prop_table, 3)
