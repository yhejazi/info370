library(dplyr)
# write functions of formulas to use in analysis

# computes and returns the isolation factor of a city
isolation <- function(city) {
  city <- city %>% mutate(isolation = (pop.not.white / sum(pop.not.white)) * (pop.not.white / pop))
  result <- sum(city$isolation)
  return(result)
}

# computes and returns the correlation factor of a city
correlation <- function(city) {
  P <- sum(city$pop.not.white) / sum(city$pop)
  return((isolation(city) - P) / (1 - P))
}

# computes and returns the interaction factor of a city
interaction <- function(city) {
  city <- city %>% mutate(interaction = (pop.not.white / sum(pop.not.white)) * (pop.white / pop))
  result <- sum(city$interaction)
  return(result)
}

# computes and returns the dissimilarity factor of a city
dissimilarity <- function(city) {
  city <- city %>% mutate(dissimilarity = abs((pop.not.white / sum(pop.not.white)) - (pop.white / sum(pop.white))))
  result <- sum(city$dissimilarity) * 0.5
  return(result)
  
}

# computes and returns the the percentage of minorities in small areas, relative to average
# compared to entire population of the city
custom <- function(city) {
  avg.size <- mean(city$pop)
  small <- city %>% filter(pop < avg.size)
  small.sum <- sum(small$pct.not.white)
  
  #big <- city %>% filter(pop >= avg.size)
  big.sum <- sum(city$pct.not.white)
  
  return(small.sum / big.sum)
}