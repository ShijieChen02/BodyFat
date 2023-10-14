library(ggplot2)
bf = read.csv("BodyFat.csv")
head(bf)

# Siri Equation
bf$bf_predict = 495/bf$DENSITY-450
bf_outlier = order(abs(bf$bf_predict-bf$BODYFAT), decreasing = TRUE)[1:10]
bf$outlier = 1:dim(bf)[1] %in% bf_outlier
bf[bf_outlier,c("BODYFAT","bf_predict")]
# outliers 48,96 have top2 diff, 182 has impossible values
bf_outlier = c(48,96,182)


#BMI Formula
bf$bmi_predict = 0.4536*bf$WEIGHT/(bf$HEIGHT*0.0254)^2
bmi_outlier = order(abs(bf$bmi_predict-bf$ADIPOSITY), decreasing = TRUE)[1:10]
bf$outlier = 1:dim(bf)[1] %in% bmi_outlier
bf[bmi_outlier,c("ADIPOSITY","bmi_predict","WEIGHT","HEIGHT")]
# outliers 42,163,221 have top3 diff
bmi_outlier = c(42,163,221)

bf = bf[-c(bf_outlier,bmi_outlier), ]
write.table(bf,"clean_data.csv",row.names=FALSE,col.names=TRUE,sep=",")

for(x in 2:17){
  p = ggplot(data = bf,aes(x=bf[,x]))+
  geom_boxplot()+
  xlab(colnames(bf)[x]) 
  print(p)
}
#ALL look normal

