kfold <- function(data,expr,fold){
  mse <- c()
  adj_r_suqare <- c()
  for(i in 1:fold){
    train_test_split <- sample(1:nrow(data),floor(nrow(data)/10))
    test <- data[train_test_split,]
    train <- data[-train_test_split,]
    model <- lm(expr, train)
    predicted.values <- predict(object = model,test)
    adj_r_suqare[i] <- summary(model)$adj.r.squared
    mse[i] <- sqrt(mean((predicted.values-test$BODYFAT)^2))
  }
  
  cat('\n')
  print(expr)
  cat('avg_adj_r_square:',mean(adj_r_suqare),'\n')
  cat('avg_mse:',mean(mse),'\n')
  cat('sd_mse:',sd(mse),'\n')
}

# use abdomen as waist
# upcoming: convenient
kfold(bf,BODYFAT~log(HEIGHT- NECK)+log(ABDOMEN), 5)

# if no NECK, substitude:
kfold(bf,BODYFAT~log(HEIGHT)+log(ABDOMEN), 5)

# from top10, we choose the minimun num of predictors
# upcoming: accurate
kfold(bf,BODYFAT ~ DENSITY+WEIGHT+ADIPOSITY, 5)
