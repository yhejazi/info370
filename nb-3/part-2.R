# Part 2: Assess grade differences between men and women in an Informartics course

# Set up
library(dplyr)
library(tidyr)
library(ggplot2)

# Load data
grades <- read.csv('grades.csv')

# How many students are there of each sex?
f.rows <- nrow(grades %>% filter(sex == 'f'))
m.rows <- nrow(grades %>% filter(sex == 'm'))

# Calculate averages for each assignment for each sex 
# Hint: use `summarize_all`
averages <- grades %>%
    group_by(sex) %>% summarize_all(mean)


# Create a scatter plot showing the average female score (x) v.s. male score (y)
# Add a 45 degree line to the graph
# Hint: this requires reshaping
averages.drop <- averages[-c(2, 11, 12)]
reshaped <- gather(averages.drop, assignment, score, -sex)

reshaped <- spread(reshaped, sex, score)

ggplot(reshaped, aes(x=f, y=m)) +
  geom_point(size=2, shape=23) +
  geom_smooth(method=lm)

# Perform a T test on the "total" grade.
# Is there an observed and significant different by sex?

# unpaired by sex, but paired when comparing assignments
diff.means <- mean(reshaped$m) - mean(reshaped$f)

se <- sqrt(
  sd(reshaped$m)^2/nrow(reshaped) +
    sd(reshaped$f)^2/nrow(reshaped)
)

t <- 2.365

ci.lower <- diff.means - t * se
ci.upper <- diff.means + t * se

# Now run a t-test on each assignment (feel free to use a loop)
t.test(reshaped$m, reshaped$f)


# Make histograms of a3 togther
ggplot(grades, aes(grades[, 'a3'], fill = sex)) + geom_density(alpha = 0.2)

# Was assignment 4 harder than assignment 5 (plot the difference)
ggplot(grades, aes(x=a4, y=a5, color=sex)) + geom_point() + geom_smooth(method=lm)

