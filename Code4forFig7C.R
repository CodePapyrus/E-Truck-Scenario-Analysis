par(mfrow = c(3,1))
a
b
c

# Figure 1
draw_data <- as.matrix(data.frame(CP_A=c(63547.29881,43372.90731),
                                  CP_B=c(63547.29881,43372.90731),
                                  CP_C=c(63547.29881,43372.90731),
                                  CP_D=c(63547.29881,43372.90731),
                                  CP_E=c(63547.29881,43372.90731)))
colnames(draw_data) <- c("0%","25%","50%","75%","100%")  

# categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

a <- barplot(draw_data, main="Figure 6c Total Cost Comparison", xlab="CP", col=colors, horiz=TRUE, beside=TRUE, cex.axis=2, cex.names=2, cex.lab=2, cex.main=2)
# a <- barplot(draw_data, main="Figure 6c Total Cost Comparison", xlab="CP", col=colors, beside=TRUE, cex.axis=2, cex.names=2, cex.lab=2, cex.main=2)

par(bg="#F2EBE5")

# Figure 2
draw_data <- as.matrix(data.frame(CDP_A=c(1723.991908,1581.110666),
                                  CDP_B=c(7856.991908,4438.610666),
                                  CDP_C=c(14277.49191,7333.110666),
                                  CDP_D=c(19992.99191,10714.61067),
                                  CDP_E=c(26855.49191,14597.11067)))
colnames(draw_data) <- c("0%","25%","50%","75%","100%") 

# categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

b <- barplot(draw_data, xlab="CDP", col=colors, horiz=TRUE, beside=TRUE, cex.axis=2, cex.names=2, cex.lab=2)
# b <- barplot(draw_data, xlab="CDP", col=colors, beside=TRUE, cex.axis=2, cex.names=2, cex.lab=2)

legend("bottomright",
       legend=c("Suburbs","Downtown"),
       fill=c("#D5E490","#831A21"),
       bty="n",
       cex=2)

# Figure 3
draw_data <- as.matrix(data.frame(EP_A=c(1442.589052,1296.896373),
                                  EP_B=c(7455.089052,4545.896373),
                                  EP_C=c(13887.08905,7851.396373),
                                  EP_D=c(19721.08905,10828.39637),
                                  EP_E=c(26851.08905,14596.89637)))
colnames(draw_data) <- c("0%","25%","50%","75%","100%") 

# categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

c <- barplot(draw_data, xlab="EP", col=colors, horiz=TRUE, beside=TRUE, cex.axis=2, cex.names=2, cex.lab=2)
# c <- barplot(draw_data, xlab="EP", col=colors, beside=TRUE, cex.axis=2, cex.names=2, cex.lab=2)
