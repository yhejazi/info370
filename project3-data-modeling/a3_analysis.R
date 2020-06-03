require(ggplot2)
require(ggthemes)
require(dplyr)
require(sandwich)
require(msm)

raw.data <- read.csv('./data/CrowdstormingDataJuly1st.csv', stringsAsFactors = FALSE)

# Grab relevant data
# meanIAT (implicit) and meanExp (explicit) are measurements of country prejudice
col.names = c('player', 'redCards', 'rater1', 'rater2','refNum', 'refCountry', 
              'meanIAT', 'meanExp')
data <- na.omit(raw.data[col.names])

### Exploratory Data Analysis ###

summary(data)

# Compare results of two different raters.
# Are the rating results accurate and fair?
ggplot(data = data, aes(x = rater1)) +
  geom_histogram(binwidth = 0.1) +
  theme_bw() +
  labs(y = "Count", x = "Skintone Rating") + ggtitle("Rater 1")

ggplot(data = data, aes(x = rater2)) +
  geom_histogram(binwidth = 0.1) +
  theme_bw() +
  labs(y="Count", x = "Skintone Rating") + ggtitle("Rater 2")

# Total red cards for each unique player.
# Which player has the most red cards.
player.cards <- group_by(data, player) %>%
  summarize(
    totalRedCards = sum(redCards)
  )

# Total red cards for each unique rater1 skin ratings.
rater1.skin.cards <- group_by(data, rater1) %>%
  summarize(
    totalRedCards = sum(redCards)
  )

# Total red cards for each unique rater2 skin ratings.
rater2.skin.cards <- group_by(data, rater2) %>%
  summarize(
    totalRedCards = sum(redCards)
  )

# Number of red cards given out per skin tone rating from rater1.
ggplot(rater1.skin.cards, aes(x = rater1, y = totalRedCards)) +
  geom_col(width = 0.1) +
  theme_bw() +
  labs(title = "Number of Red Cards Distributed by Rater1's Ratings")

# Number of red cards given out per skin tone rating from rater2.
# Can't use binwidth with aes y? Used geom_col instead to specify y axis as totalRedCards
ggplot(rater2.skin.cards, aes(x = rater2, y = totalRedCards)) +
  geom_col(width = 0.1) +
  theme_bw() +
  labs(title = "Number of Red Cards Distributed by Rater2's Ratings")

ggplot() + 
  geom_line(data = rater1.skin.cards, aes(x = rater1, y = totalRedCards), color = "red") +
  geom_line(data = rater2.skin.cards, aes(x = rater2, y = totalRedCards), color = "blue") +
  xlab('Skin Tone Rating') +
  ylab('Total Received Red Cards') +
  scale_colour_manual("", 
                      breaks = c("Rater 1", "Rater 2"),
                      values = c("red", "blue"))

# redCards distribution.
ggplot(data = data, aes(x = redCards)) +
  geom_histogram(binwidth = 0.5) +
  theme_bw()

# Mean and variance of redCards.
mean(data$redCards)
var(data$redCards)

### Data Preparation ###

# Combine rater1 and rater2 by calculating their mean.
data$skinRating = rowMeans(data[c('rater1', 'rater2')])

# Prep for model 1
data1.cols = c('player', 'skinRating')
skin.data <- unique(na.omit(data[data1.cols]))
summary(skin.data)

data1 <- left_join(player.cards, skin.data)
head(data1)

# Prep for model 2
data2.cols <- c('refCountry', 'meanExp', 'meanIAT', 'skinRating', 'redCards')
data2 <- na.omit(data[data2.cols])
head(data2)
summary(data2)


# We calculate mean of meanExp and meanIAT for each unique country and for eval of prejudice
data2.transformed <- group_by(data2, refCountry) %>%
  summarize(
    totalRedCards = sum(redCards),
    bias = mean((meanExp) + (meanIAT)),
    skinRating = mean(skinRating)
  )

summary(data2.transformed)

### Statistical Modeling ###

# Question 1: are soccer referees more likely to give red cards to dark skin toned players than light skin toned players?
model1 <- glm(totalRedCards ~ skinRating, family="poisson", data = data1)
summary(model1)

data1$pred1 <- predict(model1, type="response")

# The prediction line has a slight positive direction.
graph1 <- ggplot(data1, aes(x = skinRating, y = pred1, color = totalRedCards)) +
  geom_point(aes(y = totalRedCards), alpha=.5, position=position_jitter(h=1)) +
  geom_line(size = 1) +
  labs(x = "Skin Ratings", y = "Predicted # Red Cards Received this Season") +
  scale_colour_gradient(low = "light green", high = "red")

graph1

# Question 2: are soccer referees from countries high in skintone prejudice more likely to award red cards to dark skin toned players?
# Grab columns we are interested for question 2.

# Add bias as covariate.
model2 <- glm(totalRedCards ~ skinRating + bias, family="poisson", data = data2.transformed)
summary(model2)

data2.transformed$pred2 <- predict(model2, type="response")

graph2 <- ggplot(data2.transformed, aes(x = skinRating, y = pred2)) +
  geom_point(aes(y = totalRedCards), alpha=.5, position=position_jitter(h=0.5)) +
  geom_line(size = 1) +
  labs(x = "Skin Ratings", y = "Probability of Observing Red Cards") +
  scale_colour_gradient(low = "light green", high = "red")

graph2
