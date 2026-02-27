par(mfrow = c(1,1))

# 创建数据
x <- c(0,0.25,0.5,0.75,1)
y_Suburbs <- c(42.21917415,42.21917415,42.21917415,42.21917415,42.21917415)
y_Downtown <- c(21.67289474,21.67289474,21.67289474,21.67289474,21.67289474)

y_CDP_Suburbs <- c(1210.571992,8736.027437,17246.58075,25788.51556,34791.09371)
y_CDP_Downtown <- c(1083.184461,5855.19177,11471.07243,18313.48131,24066.67777)

y_EP_Suburbs <- c(3701.97279,3188.517874,2816.804977,2344.27363,384.6829207)
y_EP_Downtown <- c(1856.179915,1565.361817,1334.50603,986.8035124,53.02430824)

par(bg="#F2EBE5")

# 绘制折线图
plot(x, y_CDP_Suburbs, xlab="The proportion of BETs (%)",ylab="Carbon Emission (kg)",type = 'l', col="#D5E490",lwd=2, main="Figure 7a Carbon Emission Comparison")
lines(x,y_CDP_Downtown, type = 'l', col="#831A21", lwd=2)
text(1,35000,"CDP",cex=1)
text(1,25000,"CDP",cex=1)



lines(x,y_Suburbs, type = 'l',col="#D5E490",lwd=2)
lines(x,y_Downtown, type = 'l',col="#831A21",lwd=2)
text(0.2,200,"CP",cex=1)
text(0.2,200,"CP",cex=1)


lines(x,y_EP_Suburbs, type = 'l',col="#D5E490",lwd=2)
lines(x,y_EP_Downtown, type = 'l',col="#831A21",lwd=2)
text(0.8,2500,"EP",cex=1)
text(0.8,1000,"EP",cex=1)

legend("topleft",
       legend = c("Suburbs","Downtown"),
       fill = c("#D5E490","#831A21"),
       bty="n",
       cex=1)




