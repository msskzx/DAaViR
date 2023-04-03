# execute only once!
# install.packages("dslabs") 
# execute in every new script
library(dslabs)



# 1. What is the sum of the first 100 positive integers?
n <- 100
result <- n*(n+1)/2
result

# 3. Use seq function instead
n <- 1000
required_sequence <- seq(1:n)
sum(required_sequence)

# 4. Use one line of code to compute the logarithm, in base 10, of the square root of 100.
log10(sqrt(100))
