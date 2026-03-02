# Impact of different vehicle weight limits on transportation results

par(mfrow = c(3,1))

# Figure 1
draw_data <- as.matrix(data.frame(weight_limitations=c(604507.0975,436006.7708)))
# rownames <- c("")

# categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

a <- barplot(draw_data, main="Figure 9(a) BETs' Weight Limitations Comparison", 
             xlab="TC (yuan)", ylab="2.5 (t)", col=colors, horiz=TRUE, beside=TRUE)

par(bg="#F2EBE5")

# legend("topright",
#        legend = c("Suburbs","Downtown"),
#        fill = c("#D5E490","#831A21"),
#        bty="n",
#        cex=1)

# Figure 2
draw_data <- as.matrix(data.frame(weight_limitations=c(604507.0975,436006.7708)))
rownames <- c("6t")

# categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

b <- barplot(draw_data, xlab="TC (yuan)", ylab="6 (t)", col=colors, horiz=TRUE, beside=TRUE)

# Figure 3
draw_data <- as.matrix(data.frame(weight_limitations=c(604507.0975,436006.7708)))
rownames <- c("12t")

# categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

c <- barplot(draw_data, xlab="TC (yuan)", ylab="12 (t)", col=colors, horiz=TRUE, beside=TRUE)
