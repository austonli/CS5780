setwd("C:/Users/meaus/OneDrive/4th Year/CS 5780/CS5780")

train<- read.csv("mod_train.csv",header = TRUE) #reading the training data
test<- read.csv("mod_test.csv",header = TRUE) #reading the test data
og_train <- read.csv("train.csv",header = TRUE)
og_test <- read.csv("test.csv",header = TRUE)

library(dplyr)
library(randomForest)
library(Boruta)

train_ft <- select(train, "favoriteCount","id","retweetCount","chars","month","year","day","time","label","X.s","isLink","atPerson","isRT")
test_ft <- select(test, "favoriteCount","id","retweetCount","chars","month","year","day","time","X.s","isLink","atPerson","isRT")
features <- select(train, "favoriteCount","id","retweetCount","chars","month","year","day","time","X.s","isLink","atPerson","isRT")

rf <- randomForest(features, as.factor(train_ft$label), ntree=100, importance=TRUE)
pred <- data.frame(id = og_test$id)
pred$label <- predict(rf, test_ft)
write.csv(pred, "random_forest_benchmark_4.csv")

train_prd <-data.frame(id = og_train$id)
train_prd <- predict(rf,train_ft)