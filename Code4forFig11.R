# Impact of different failure time thresholds on transportation results
par(mfrow = c(3,1))

# Figure 1
draw_data <- as.matrix(data.frame(mins=c(604507.0975,436006.7708)))
# rownames <- c("800","300","200")

# categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

a <- barplot(draw_data, main="Figure 11 Failure Rate Comparison", 
             xlab="TC (yuan)", ylab="800 (mins)", xlim=c(0,15e+05), 
             col=colors, horiz=TRUE, beside=TRUE)

par(bg="#F2EBE5")

# legend("topright",
#        legend = c("Suburbs","Downtown"),
#        fill = c("#D5E490","#831A21"),
#        bty="n",
#        cex=1)

# Figure 2
draw_data <- as.matrix(data.frame(mins=c(1529508.026,1119007.713)))
# rownames <- c("800","300","200")

# categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

b <- barplot(draw_data, xlab="TC (yuan)", ylab="300 (mins)", xlim=c(0,15e+05), 
             col=colors, horiz=TRUE, beside=TRUE)

# Figure 3
draw_data <- as.matrix(data.frame(mins=c(248006.2066,178005.8749)))
# rownames <- c("800","300","200")

# categories <- ("Suburbs","Urban") 
colors <- c("#D5E490","#831A21")

c <- barplot(draw_data, xlab="TC (yuan)", ylab="2000 (mins)", xlim=c(0,15e+05), 
             col=colors, horiz=TRUE, beside=TRUE)
