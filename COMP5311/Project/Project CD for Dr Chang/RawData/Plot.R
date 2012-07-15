# R script to plot test results
# Author: QING Pei
# Last changed: 2011-11-29 12:04PM

# traceroute plot
traceroute <- read.csv(file="traceroutereport.csv",sep=",",head=TRUE)
traceroute$Datetime <- as.POSIXct(strptime(traceroute$Datetime, "%Y-%m-%d %H:%M:%S"))

pdf("fig/traceroute.pdf")
traceroute$target <- as.numeric(traceroute$DestIP)
ntargets <- max(traceroute$target)
xrange <- range(traceroute$Datetime)
yrange <- range(traceroute$hops)
plot(xrange, yrange, type="n", xlab="Timestamp", ylab="Traceroute hops")
colors <- rainbow(ntargets)
linetype <- c(1:ntargets) 
plotchar <- seq(15,15+ntargets,1)
for (i in 1:ntargets) {
	target <- subset(traceroute, target==i)
	lines(target$Datetime, target$hops, type="p", cex = .4,
	lty=linetype[i], col=colors[i], pch=plotchar[i])
}
title("Hops between our host to test targets")
legend(xrange[1], yrange[2], 1:ntargets, cex=0.8, col=colors, pch=plotchar, lty=linetype, title="Target")
dev.off()

# ping plots
ping <- read.csv(file="pingreport.csv",sep=",",head=TRUE)
ping$Datetime <- as.POSIXct(strptime(ping$Datetime, "%Y-%m-%d %H:%M:%S"))

pdf("fig/ping_packetloss.pdf")
ping$target <- as.numeric(ping$DestIP)
ntargets <- max(ping$target)
xrange <- range(ping$Datetime)
yrange <- range(ping$Packet.loss..)
plot(xrange, yrange, type="n", xlab="Timestamp", ylab="Packet loss %")
colors <- rainbow(ntargets)
linetype <- c(1:ntargets) 
plotchar <- seq(15,15+ntargets,1)
for (i in 1:ntargets) {
	target <- subset(ping, target==i)
	lines(target$Datetime, target$Packet.loss.., type="p", cex = .4,
	lty=linetype[i], col=colors[i], pch=plotchar[i])
}
title("Packet loss % of ping tests")
legend(xrange[1], yrange[2], 1:ntargets, cex=0.8, col=colors, pch=plotchar, lty=linetype, title="Target")
dev.off()

pdf("fig/ping_rttmin.pdf")
ping$target <- as.numeric(ping$DestIP)
ntargets <- max(ping$target)
xrange <- range(ping$Datetime)
yrange <- range(ping$RTT.min)/2
plot(xrange, yrange, type="n", xlab="Timestamp", ylab="RTT Min")
colors <- rainbow(ntargets)
linetype <- c(1:ntargets) 
plotchar <- seq(15,15+ntargets,1)
for (i in 1:ntargets) {
	target <- subset(ping, target==i)
	lines(target$Datetime, target$RTT.min, type="p", cex = .4,
	lty=linetype[i], col=colors[i], pch=plotchar[i])
}
title("Min RTT of ping tests")
legend(xrange[1], yrange[2], 1:ntargets, cex=0.8, col=colors, pch=plotchar, lty=linetype, title="Target")
dev.off()

pdf("fig/ping_rttavg.pdf")
ping$target <- as.numeric(ping$DestIP)
ntargets <- max(ping$target)
xrange <- range(ping$Datetime)
yrange <- range(ping$RTT.avg)/2
plot(xrange, yrange, type="n", xlab="Timestamp", ylab="RTT Avg")
colors <- rainbow(ntargets)
linetype <- c(1:ntargets) 
plotchar <- seq(15,15+ntargets,1)
for (i in 1:ntargets) {
	target <- subset(ping, target==i)
	lines(target$Datetime, target$RTT.avg, type="p", cex = .4,
	lty=linetype[i], col=colors[i], pch=plotchar[i])
}
title("Avg RTT of ping tests")
legend(xrange[1], yrange[2], 1:ntargets, cex=0.8, col=colors, pch=plotchar, lty=linetype, title="Target")
dev.off()

pdf("fig/ping_rttmax.pdf")
ping$target <- as.numeric(ping$DestIP)
ntargets <- max(ping$target)
xrange <- range(ping$Datetime)
yrange <- range(ping$RTT.max)/2
plot(xrange, yrange, type="n", xlab="Timestamp", ylab="RTT Max")
colors <- rainbow(ntargets)
linetype <- c(1:ntargets) 
plotchar <- seq(15,15+ntargets,1)
for (i in 1:ntargets) {
	target <- subset(ping, target==i)
	lines(target$Datetime, target$RTT.max, type="p", cex = .4,
	lty=linetype[i], col=colors[i], pch=plotchar[i])
}
title("Max RTT of ping tests")
legend(xrange[1], yrange[2], 1:ntargets, cex=0.8, col=colors, pch=plotchar, lty=linetype, title="Target")
dev.off()

pdf("fig/ping_rttmdev.pdf")
ping$target <- as.numeric(ping$DestIP)
ntargets <- max(ping$target)
xrange <- range(ping$Datetime)
yrange <- range(ping$RTT.mdev)/5
plot(xrange, yrange, type="n", xlab="Timestamp", ylab="RTT Mdev")
colors <- rainbow(ntargets)
linetype <- c(1:ntargets) 
plotchar <- seq(15,15+ntargets,1)
for (i in 1:ntargets) {
	target <- subset(ping, target==i)
	lines(target$Datetime, target$RTT.mdev, type="p", cex = .4,
	lty=linetype[i], col=colors[i], pch=plotchar[i])
}
title("Mdev RTT of ping tests")
legend(xrange[1], yrange[2], 1:ntargets, cex=0.8, col=colors, pch=plotchar, lty=linetype, title="Target")
dev.off()

# owping plot
owping <- read.csv(file="owpingreport.csv",sep=",",head=TRUE)
owping$Datetime <- as.POSIXct(strptime(owping$Datetime, "%Y-%m-%d %H:%M:%S"))
# summary(owping)

pdf("fig/owping_packetloss.pdf")
owping$target <- as.numeric(owping$DestIP)
ntargets <- max(owping$target)
xrange <- range(owping$Datetime)
yrange <- range(owping$Packets.loss..)
plot(xrange, yrange, type="n", xlab="Timestamp", ylab="Packet loss %")
colors <- rainbow(ntargets)
linetype <- c(1:ntargets) 
plotchar <- seq(15,15+ntargets,1)
for (i in 1:ntargets) {
	target <- subset(owping, target==i)
	lines(target$Datetime, target$Packets.loss.., type="p", cex = .4,
	lty=linetype[i], col=colors[i], pch=plotchar[i])
}
title("Packet loss % of owping tests")
legend(xrange[1], yrange[2], 1:ntargets, cex=0.8, col=colors, pch=plotchar, lty=linetype, title="Target")
dev.off()

pdf("fig/owping_min.pdf")
owping$target <- as.numeric(owping$DestIP)
ntargets <- max(owping$target)
xrange <- range(owping$Datetime)
yrange <- (range(owping$One.way.Delay.min, na.rm=TRUE)+700)/5

plot(xrange, yrange, type="n", xlab="Timestamp", ylab="One-way delay min")
colors <- rainbow(ntargets)
linetype <- c(1:ntargets) 
plotchar <- seq(15,15+ntargets,1)
for (i in 1:ntargets) {
	target <- subset(owping, target==i)
	lines(target$Datetime, target$One.way.Delay.min, type="p", cex = .4,
	lty=linetype[i], col=colors[i], pch=plotchar[i])
}
title("Min one-way delay of owping tests")
legend(xrange[1], yrange[2], 1:ntargets, cex=0.8, col=colors, pch=plotchar, lty=linetype, title="Target")
dev.off()

pdf("fig/owping_med.pdf")
owping$target <- as.numeric(owping$DestIP)
ntargets <- max(owping$target)
xrange <- range(owping$Datetime)
yrange <- (range(owping$One.way.Delay.median, na.rm=TRUE)+700)/5

plot(xrange, yrange, type="n", xlab="Timestamp", ylab="One-way delay median")
colors <- rainbow(ntargets)
linetype <- c(1:ntargets) 
plotchar <- seq(15,15+ntargets,1)
for (i in 1:ntargets) {
	target <- subset(owping, target==i)
	lines(target$Datetime, target$One.way.Delay.median, type="p", cex = .4,
	lty=linetype[i], col=colors[i], pch=plotchar[i])
}
title("Median one-way delay of owping tests")
legend(xrange[1], yrange[2], 1:ntargets, cex=0.8, col=colors, pch=plotchar, lty=linetype, title="Target")
dev.off()

pdf("fig/owping_max.pdf")
owping$target <- as.numeric(owping$DestIP)
ntargets <- max(owping$target)
xrange <- range(owping$Datetime)
yrange <- (range(owping$One.way.Delay.max, na.rm=TRUE)+700)/5

plot(xrange, yrange, type="n", xlab="Timestamp", ylab="One-way delay max")
colors <- rainbow(ntargets)
linetype <- c(1:ntargets) 
plotchar <- seq(15,15+ntargets,1)
for (i in 1:ntargets) {
	target <- subset(owping, target==i)
	lines(target$Datetime, target$One.way.Delay.max, type="p", cex = .4,
	lty=linetype[i], col=colors[i], pch=plotchar[i])
}
title("Max one-way delay of owping tests")
legend(xrange[1], yrange[2], 1:ntargets, cex=0.8, col=colors, pch=plotchar, lty=linetype, title="Target")
dev.off()

pdf("fig/owping_err.pdf")
owping$target <- as.numeric(owping$DestIP)
ntargets <- max(owping$target)
xrange <- range(owping$Datetime)
yrange <- range(owping$One.way.Delay.err, na.rm=TRUE)

plot(xrange, yrange, type="n", xlab="Timestamp", ylab="One-way delay err")
colors <- rainbow(ntargets)
linetype <- c(1:ntargets) 
plotchar <- seq(15,15+ntargets,1)
for (i in 1:ntargets) {
	target <- subset(owping, target==i)
	lines(target$Datetime, target$One.way.Delay.err, type="p", cex = .4,
	lty=linetype[i], col=colors[i], pch=plotchar[i])
}
title("Err one-way delay of owping tests")
legend(xrange[1], yrange[2], 1:ntargets, cex=0.8, col=colors, pch=plotchar, lty=linetype, title="Target")
dev.off()

pdf("fig/owping_jitter.pdf")
owping$target <- as.numeric(owping$DestIP)
ntargets <- max(owping$target)
xrange <- range(owping$Datetime)
yrange <- range(owping$One.way.jitter, na.rm=TRUE)/6

plot(xrange, yrange, type="n", xlab="Timestamp", ylab="One-way jitter")
colors <- rainbow(ntargets)
linetype <- c(1:ntargets) 
plotchar <- seq(15,15+ntargets,1)
for (i in 1:ntargets) {
	target <- subset(owping, target==i)
	lines(target$Datetime, target$One.way.jitter, type="p", cex = .4,
	lty=linetype[i], col=colors[i], pch=plotchar[i])
}
title("One-way jitter of owping tests")
legend(xrange[1], yrange[2], 1:ntargets, cex=0.8, col=colors, pch=plotchar, lty=linetype, title="Target")
dev.off()

pdf("fig/owping_hops.pdf")
owping$target <- as.numeric(owping$DestIP)
ntargets <- max(owping$target)
xrange <- range(owping$Datetime)
yrange <- range(owping$Hops, na.rm=TRUE)

plot(xrange, yrange, type="n", xlab="Timestamp", ylab="One-way hops")
colors <- rainbow(ntargets)
linetype <- c(1:ntargets) 
plotchar <- seq(15,15+ntargets,1)
for (i in 1:ntargets) {
	target <- subset(owping, target==i)
	lines(target$Datetime, target$Hops, type="p", cex = .4,
	lty=linetype[i], col=colors[i], pch=plotchar[i])
}
title("Hops of owping tests")
legend(xrange[1], yrange[2], 1:ntargets, cex=0.8, col=colors, pch=plotchar, lty=linetype, title="Target")
dev.off()