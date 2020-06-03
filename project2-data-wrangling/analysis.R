library(dplyr)
library(ggplot2)
source('metric_functions.R')

# Read city data
baltimore <- read.csv('data/prepped/baltimore_race.csv')
charleston <- read.csv('data/prepped/charleston_race.csv')
chicago <- read.csv('data/prepped/chicago_race.csv')
columbus <- read.csv('data/prepped/columbus_race.csv')
dayton <- read.csv('data/prepped/dayton_race.csv')
denver <- read.csv('data/prepped/denver_race.csv')
kc <- read.csv('data/prepped/kc_race.csv')
memphis <- read.csv('data/prepped/memphis_race.csv')
milwaukee <- read.csv('data/prepped/milwaukee_race.csv')
ok_city <- read.csv('data/prepped/ok_city_race.csv')
pittsburgh <- read.csv('data/prepped/pittsburgh_race.csv')
st_louis <- read.csv('data/prepped/st_louis_race.csv')
syracuse <- read.csv('data/prepped/syracuse_race.csv')
wichita <- read.csv('data/prepped/wichita_race.csv')


cities <- list(baltimore, charleston, chicago, columbus, dayton, denver, kc, memphis, milwaukee, ok_city,
            pittsburgh, st_louis, syracuse, wichita)
names <- c('baltimore', 'charleston', 'chicago', 'columbus', 'dayton', 'denver', 'kc', 'memphis', 'milwaukee', 'ok_city',
              'pittsburgh', 'st_louis', 'syracuse', 'wichita')

isolations <- lapply(cities, isolation)
correlations <- lapply(cities, correlation)
interactions <- lapply(cities, interaction)
dissimilarities <- lapply(cities, dissimilarity)
small.areas <- lapply(cities, custom)

df <- data.frame(names, I(isolations), I(correlations), I(interactions), I(dissimilarities), I(small.areas))


## Visualization demos

diss.bar = ggplot(df, aes(x = names, y= as.numeric(dissimilarities))) + 
  geom_bar(stat = 'identity', fill = "#187BCD") + labs(x = 'City Names', y = "Dissimilarities") +
  ggtitle("Segregation Dissimilarity by City")

scatter1 = ggplot(df, aes(x=as.numeric(dissimilarities), y=as.numeric(isolations), color=as.numeric(correlations))) +
  geom_point() + labs(x = 'Dissimilarities', y = 'Isolations', color = 'Correlations') +
  ggtitle("Dissimilarity vs. Isolation vs. Correlation")

scatter2 = ggplot(df, aes(x=as.numeric(dissimilarities), y=as.numeric(small.areas), color=as.numeric(correlations))) + 
  geom_point() + labs(x = 'Dissimilarities', y = 'Small Area Ratio', color = 'Correlations') +
  ggtitle("Dissimilarity vs. Correlation by Small Area Ratio")

