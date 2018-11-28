setwd("C:/Users/meaus/OneDrive/4th Year/CS 5780/CS5780")

train<- read.csv("train.csv",header = TRUE) #reading the training data
test<- read.csv("test.csv",header = TRUE) #reading the test data

names(train)
names(test)


#install.packages("dplyr") **needs to be run the first time to install the package)
library(dplyr)
#isRetweet,retweeted, screenName,favorited, truncated, replytoSN are all irrelevant
#replyToSN, created, longitude, latitude,replytoUID is mostly NAs

filtered <- select(train, "id","text","favoriteCount","id.1","statusSource","screenName","retweetCount","label")
features <- select(train, "id","text","favoriteCount","id.1","statusSource","screenName","retweetCount")
lbls <- select(train,"label")