# 创建数据
x <- c(0,0.25,0.5,0.75,1)
y_Suburbs <- c(0,0,0,0,0)
y_Downtown <- c(0,0,0,0,0)

y_CDP_Suburbs <- c(655.5,6788.5,13209,18924.5,25787)
y_CDP_Downtown <- c(694,3551.5,6446,9827.5,13710)

y_EP_Suburbs <- c(378.5,6391,12823,18657,25787)
y_EP_Downtown <- c(410,3659,6964.5,9941.5,13710)

par(bg="#F2EBE5")

# 绘制折线图
plot(x, y_CDP_Suburbs, xlab="The proportion of BETs (%)",ylab="Cargo Damage (kg)",type = 'l', col="#D5E490",lwd=2, main="Figure 7b Cargo Damage Comparison")
lines(x,y_CDP_Downtown, type = 'l', col="#831A21", lwd=2)
text(1,13800,"CDP",cex=1)
text(1,26000,"CDP",cex=1)



lines(x,y_Suburbs, type = 'l',col="#D5E490",lwd=2)
lines(x,y_Downtown, type = 'l',col="#831A21",lwd=2)
text(0.2,50,"CP",cex=1)
text(0.2,50,"CP",cex=1)


lines(x,y_EP_Suburbs, type = 'l',col="#D5E490",lwd=2)
lines(x,y_EP_Downtown, type = 'l',col="#831A21",lwd=2)
text(0.2,5100,"EP",cex=1)
text(0.2,2500,"EP",cex=1)

legend("topleft",
       legend = c("Suburbs","Downtown"),
       fill = c("#D5E490","#831A21"),
       bty="n",
       cex=1)




