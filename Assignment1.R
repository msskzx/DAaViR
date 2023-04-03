# execute only once!
# install.packages("dslabs") 
# execute in every new script
library(dslabs)

# Section 1
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

# 6. What is the outcome of the following sum 1 + 1/22 + 1/32 + · · · + 1/1002?
# Thanks to Euler, we know it approximates to π2/6. 
#Compute the sum and check that it is close to the approximation.
approximation <- pi^2/6
approximation
actual <- sum(1/seq(1:100)^2)
actual

# Section 2
# 1. Load the US murders dataset from the dslabs package executing the following command:
data(murders)
str(murders)
names(murders)
class(murders$region)
levels(murders$region)
table(murders$region)

# Section 3
# 1. Use the function c to create a vector with the average high temperatures
# in January for Beijing, Lagos, Paris, Rio de Janeiro, San Juan, and Toronto, 
# which are 35, 88, 42, 84, 81, and 30 degrees Fahrenheit. Call the object temp.
temp <- c(35, 88, 42, 84, 81, 30)

# 2. Now create a vector with the city names and call the object city.
city <- c("Beijing", "Lagos", "Paris", "Rio de Janeiro", "San Juan", "Toronto")

# 3. Use the names function and the objects defined in the previous exercises to
# associate the temperature data with its corresponding city.
names(temp) <- city
temp
temp[1:3]
temp[c("Beijing", "Lagos")]

# 8. Create a vector of numbers that starts at 6, does not pass 55,
# and adds numbers in increments of 4/7: 6, 6 + 4/7, 6 + 8/7, and so on.
# How many numbers does the vector have? Hint: use seq and length.
four_sevens <- seq(6, 55, 4/7)
four_sevens
length(four_sevens)

# Section 4
# 1. Use the $ operator to access the population size and store it as the object pop.
# Then use the sort function to redefine pop so that it is sorted. Finally, 
# use the [ operator to report the smallest population size.
# Confirm this is the minimum value using the min function.
pop <- murders$population
sorted_pop <- sort(pop)
smallest <- sorted_pop[1]
smallest == min(pop)

# 2. Now instead of the smallest population size, find the index of the entry
#with the smallest population size. Hint: use order instead of sort.
pop <- murders$population
ordered_pop <- order(pop)
smallest_idx <- ordered_pop[1]

# 3. We can actually perform the same operation as in the previous exercise
# using the function which.min. Write one line of code that does this.
which.min(pop)

# 4. Now we know what the smallest population is and the row which contains it. 
# What is the name of this state?
murders$state[which.min(murders$population)]


# 5. Use the rank function to determine the population rank of each state from
# smallest population size to biggest. Save these ranks in an object called ranks,
# then create a data frame with the state name and its rank. Call the data frame my_df.
rank_population <- rank(murders$population)
rank_population
my_df <- data.frame(state=murders$state, rank=rank_population)
my_df

# Section 5
temp <- c(35, 88, 42, 84, 81, 30)
city <- c("Beijing", "Lagos", "Paris", "Rio de Janeiro", "San Juan", "Toronto") 
names(temp) <- city
# 1. Use the temp vector to create a different vector temp_F that converts the
# temperature from Fahrenheit to Celsius. The conversion is C = 59 × (F − 32).
temp_F <- 59*(temp - 32)

# 2. The is.na function returns a logical vector that tells us which entries are NA.
# Assign this logical vector to an object called ind and
# determine how many NAs does na_example have.
data("na_example")
str(na_example)
mean(na_example)
is_na_array <- is.na(na_example)
table(is_na_array)

# 3. Now compute the average again, but only for the entries that are not NA.
mean(na_example, na.rm=TRUE)
mean(na_example[!is_na_array])
