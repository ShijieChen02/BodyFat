library(olsrr)

# All combinations
lmfit <- lm(BODYFAT~AGE+WEIGHT+HEIGHT+ADIPOSITY+NECK+CHEST+ABDOMEN+WRIST,data=bf)
all_posible = ols_step_all_possible(lmfit)

# other criteria like AIC perfoms worse than adjr
odered_possible = all_possible[order(all_possible$adjr,decreasing = TRUE),]

# choose the model whose adjr is the greatesr while numver of predicotrs <=5.
odered_possible = odered_possible[odered_posible$n<=5,]
write.table(odered_possible,"odered_possible.csv",row.names=FALSE,col.names=TRUE,sep=",")
