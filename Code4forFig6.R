# Carbon emissions
par(mfrow = c(3,1))

# Figure 6a
draw_data <- as.matrix(data.frame(CDP=c(17246.58075,11471.07243),
                                  CP=c(42.21917415,21.67289474),
                                  EP=c(2816.804977,1334.50603)))
rownames <- c("CDP","CP","EP")

#categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

a <- barplot(draw_data, main="Figure 6a Carbon Emission Comparison", xlab="Carbon Emission", col=colors, horiz=TRUE, beside=TRUE)

par(bg="#F2EBE5")

legend("topright",
       legend=c("Suburbs","Downtown"),
       fill=c("#D5E490","#831A21"),
       bty="n",
       cex=1)

###########################################################################################################
# Cargo damage
draw_data <- as.matrix(data.frame(CDP=c(28717.65318,6446),
                                  CP=c(0,0),
                                  EP=c(4151.311008,6964.5)))
rownames <- c("CDP","CP","EP")

#categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

a <- barplot(draw_data, main="Figure 6b Cargo Damage Comparison", xlab="Cargo Damage", col=colors, horiz=TRUE, beside=TRUE)

#par(bg="#F2EBE5")

legend("topright",
       legend=c("Suburbs","Downtown"),
       fill=c("#D5E490","#831A21"),
       bty="n",
       cex=1)

#########################################################################################################
# Total cost
# Figure 6c
draw_data <- as.matrix(data.frame(CDP=c(14277.49191,7333.110666),
                                  CP=c(63547.29881,43372.90731),
                                  EP=c(13887.08905,7851.396373)))
rownames <- c("CDP","CP","EP")

#categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

a <- barplot(draw_data, main="Figure 6c Total Cost Comparison", xlab="Total Cost", col=colors, horiz=TRUE, beside=TRUE)

#par(bg="#F2EBE5")
legend("topright",
       legend=c("Suburbs","Downtown"),
       fill=c("#D5E490","#831A21"),
       bty="n",
       cex=1)
