setwd("C:/Users/meaus/OneDrive/4th Year/CS 5780/CS5780")

train<- read.csv("train.csv",header = TRUE) #reading the training data
test<- read.csv("test.csv",header = TRUE) #reading the test data

names(train)
names(test)


#install.packages("dplyr") **needs to be run the first time to install the package)
library(dplyr)
library(randomForest)
library(Boruta)
#isRetweet,retweeted, screenName,favorited, truncated, replytoSN are all irrelevant
#replyToSN, created, longitude, latitude,replytoUID is mostly NAs
#statusSource is missing from test

filtered <- select(train, "id","favoriteCount","id.1","screenName","retweetCount","label")
testfil <-  select(test, "id","favoriteCount","id.1","screenName","retweetCount")
features <- select(train, "id","favoriteCount","id.1","screenName","retweetCount")
lbls <- select(train,"label")


bor.results <- Boruta(train,train$label,maxRuns=101,doTrace=0)


rf <- randomForest(features, as.factor(lbls$label), ntree=100, importance=TRUE)
pred <- data.frame(id = test$id)
pred$label <- predict(rf, testfil)
write.csv(pred, "random_forest_benchmark.csv")

#remove NA values
#remove columns or impute NA values for the ones that are mostly NAs
#figure out how to use statusSource
#split the time into time of day and date columns
#diffuse the correlation between favoriteCount and retweet counts
#parse the text of the tweets (word count feature engineering)