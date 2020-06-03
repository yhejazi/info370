# Part 1: Generate random data to demonstrate the Central Limit Theorem

# Create a "population" of 10,000 values, uniformly distributed between 0 and 100
population <- runif(10000, 1, 100)

# Draw a histogran of your population to view its shape
hist(population)

# Use the `sample` function to draw 100 value from the population (without replacement)
sam <- sample(population, 100, replace=FALSE)

# What is the difference between the mean of your population and the mean of your sample?
mean(population)
mean(sam)
diff = mean(population) - mean(sam)

# Now take 1000 samples from your population, keeping track of the mean of each sample. 
# Feel free to do this in a loop, or writing a function an using lapply
means <- vector()
for(i in 1:1000) {
  s <- sample(population, 100, replace=FALSE)
  means <- c(means, mean(s))
}

# What is the difference between the mean of your means and the populaiton mean?
mean(population)
mean(means)

# Draw a histogram of the means of your samples
hist(means)
