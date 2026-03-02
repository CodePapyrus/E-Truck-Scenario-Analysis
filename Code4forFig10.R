# Impact of different vehicle mileage limits on transportation results

par(mfrow = c(3,1))

# Figure 1
draw_data <- as.matrix(data.frame(mileage_duration=c(604507.0975,436006.7708)))
rownames <- c("EP")

# categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

a <- barplot(draw_data, main="Figure 10(a) BETs' Mileage Duration Comparison", 
             xlab="TC (yuan)", ylab="300 (KM)", col=colors, horiz=TRUE, beside=TRUE)

par(bg="#F2EBE5")

# legend("topright",
#        legend = c("Suburbs","Downtown"),
#        fill = c("#D5E490","#831A21"),
#        bty="n",
#        cex=1)

# Figure 2
draw_data <- as.matrix(data.frame(mileage_duration=c(604507.0975,436006.7708)))
rownames <- c("CDP")

# categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

b <- barplot(draw_data, xlab="TC (yuan)", ylab="400 (KM)", col=colors, horiz=TRUE, beside=TRUE)

# Figure 3
draw_data <- as.matrix(data.frame(mileage_duration=c(604507.0975,436006.7708)))
rownames <- c("CP")

# categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

c <- barplot(draw_data, xlab="TC (yuan)", ylab="500 (KM)", col=colors, horiz=TRUE, beside=TRUE)
