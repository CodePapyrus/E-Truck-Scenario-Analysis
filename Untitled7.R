#绘制不同外包比例，对成本的影响（同样分市区和郊区来进行比较）
#1图
par(mfrow = c(1,1))
draw_data <- as.matrix(data.frame(CP_A=c(604507.0975,436006.7708),
                                  CP_B=c(640806.9921,462106.6657),
                                  CP_C=c(677106.8742,488206.5482),
                                  CP_D=c(713406.7405,514606.4135),
                                  CP_E=c(749706.5862,540706.2596),
                                  CP_F=c(786006.4036,566806.0776),
                                  CP_G=c(822006.1821,592905.8551),
                                  CP_H=c(858305.8944,619005.5683),
                                  CP_I=c(894605.4889,645405.1591),
                                  CP_J=c(930904.7958,671504.4659),
                                  CP_K=c(967200,697600)))
colnames(draw_data) <- c("0","10","20","30","40","50","60","70","80","90","100")  



#categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

a <- barplot(draw_data,main="Figure 8 The impact of outsourcing ratio on transportation costs",xlab="Transportation costs (yuan)",ylab="Outsourcing ratio (%)",col=colors,horiz = TRUE,beside= TRUE)

par(bg="#F2EBE5")




legend("bottomright",
       legend = c("Suburbs","Downtown"),
       fill = c("#D5E490","#831A21"),
       bty="n",
       cex=1)



