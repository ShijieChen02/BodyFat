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

# Model 1 :use abdomen as waist
cat('\nModel 1:')
kfold(bf,BODYFAT~log(HEIGHT- NECK)+log(ABDOMEN), 5)

# Model 2 : MOdel 1 if no NECK ( Model 2 is our final)
cat('\nModel 2:')
kfold(bf,BODYFAT~log(HEIGHT)+log(ABDOMEN), 5)

# we choose the first in ordered_possible models(in model_selection part)
cat('\nModel 3:')
kfold(bf,BODYFAT ~WEIGHT+ HEIGHT+ ADIPOSITY +ABDOMEN +WRIST, 5)
