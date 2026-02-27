#车辆在不同载重限制下，对运输结果的影响。
par(mfrow = c(3,1))

#1图
draw_data <- as.matrix(data.frame(weight_limitations=c(231006.1356,167005.8111)))
#rownames <- c("800","300","200")



#categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

a <- barplot(draw_data,main="Figure 9(b) BETS' Weight Limitations Comparison",xlab="TC (yuan)",ylab="2.5 (t)",xlim=c(0,3e+05),col=colors,horiz = TRUE,beside= TRUE)

par(bg="#F2EBE5")

legend("topright",
       legend = c("Suburbs","Downtown"),
       fill = c("#D5E490","#831A21"),
       bty="n",
       cex=1)

#2图

draw_data <- as.matrix(data.frame(weight_limitations=c(98505.2832,70504.94876)))
#rownames <- c("800","300","200")



#categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

b <- barplot(draw_data,xlab="TC (yuan)",ylab="6 (t)",xlim=c(0,3e+05),col=colors,horiz = TRUE,beside= TRUE)

#3图

draw_data <- as.matrix(data.frame(weight_limitations=c(50004.60517,36504.29046)))
#rownames <- c("800","300","200")



#categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

c <- barplot(draw_data,xlab="TC (yuan)",ylab="12 (t)",xlim=c(0,3e+05),col=colors,horiz = TRUE,beside= TRUE)

