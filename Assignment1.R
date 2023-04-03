# install.packages("dslabs") # execute only once!
library(dslabs) # execute in every new script

# 1. What is the sum of the first 100 positive integers?
# The formula for the sum of integers from 1 to n is n(n + 1)/2.
# Define n = 100 and then use R to compute the sum from 1 to 100 using the formula.
# What is the value of the sum?

n <- 100
result <- n*(n+1)/2
result
