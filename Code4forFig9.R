#车辆在不同载重限制下，对运输结果的影响。

par(mfrow = c(3,1))


#1图
draw_data <- as.matrix(data.frame(weight_limitations=c(604507.0975,436006.7708)))
#rownames <- c("")



#categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

a <- barplot(draw_data,main="Figure 9(a) BETs' Weight Limitations Comparison",xlab="TC (yuan)",ylab = "2.5 (t)",col=colors,horiz = TRUE,beside= TRUE
             )

par(bg="#F2EBE5")

#legend("topright",
 #      legend = c("Suburbs","Downtown"),
  #     fill = c("#D5E490","#831A21"),
   #    bty="n",
    #   cex=1)

#2图
draw_data <- as.matrix(data.frame(weight_limitations=c(604507.0975,436006.7708)))
rownames <- c("6t")



#categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

b <- barplot(draw_data,xlab="TC (yuan)",ylab = "6 (t)",col=colors,horiz = TRUE,beside= TRUE)




#3图
draw_data <- as.matrix(data.frame(weight_limitations=c(604507.0975,436006.7708)))
rownames <- c("12t")



#categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

c <- barplot(draw_data,xlab="TC (yuan)",ylab = "12 (t)",col=colors,horiz = TRUE,beside= TRUE)






