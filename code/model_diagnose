
par(mfrow=c(2,2))
plot(lm(BODYFAT~log(HEIGHT- NECK)+log(ABDOMEN),bf))



par(mfrow=c(2,2))
plot(lm(BODYFAT~log(HEIGHT)+log(ABDOMEN),bf))


par(mfrow=c(2,2))
plot(lm(BODYFAT ~ WEIGHT+ HEIGHT+ ADIPOSITY +ABDOMEN +WRIST,bf))


#remove influential point 39
bf = bf[-39,]
write.table(bf,'final_data.csv',row.names=FALSE,col.names=TRUE,sep=",")



par(mfrow=c(2,2))
plot(lm(BODYFAT~log(HEIGHT- NECK)+log(ABDOMEN),bf))



par(mfrow=c(2,2))
plot(lm(BODYFAT~log(HEIGHT)+log(ABDOMEN),bf))


par(mfrow=c(2,2))
plot(lm(BODYFAT ~ WEIGHT+ HEIGHT+ ADIPOSITY +ABDOMEN +WRIST,bf))
