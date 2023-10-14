library(olsrr)

# All combinations
lmfit <- lm(BODYFAT~AGE+WEIGHT+HEIGHT+ADIPOSITY+NECK+CHEST+ABDOMEN+WRIST,data=bf)
all_posible = ols_step_all_possible(lmfit)

# other criteria like AIC perfoms worse than adjr
top10 = all_posible[order(all_posible$adjr,decreasing = TRUE),][1:10,]

# choose a suitable one from top10
