AireData <- read.csv("Aire data.csv", header = TRUE)
day <- AireData$Day
flowrate <- AireData$Flowrate
height <- AireData$Riverheight

### Create vectors for each variable ###
dayvector <- c(day)
flowvector <- c(flowrate)
heightvector <- c(height)

### Create function to scale data to between 0 and 1 ###
scalevector <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}

### Create vectors for each variable with scaled data ###
scaledday <- scalevector(dayvector)
scaledflow <- scalevector(flowvector)
scaledheight <- scalevector(heightvector)

### Combine scaled vectors to allow one graph ###
negativeheight <- -(scaledheight)
heightandday <- c(negativeheight, scaledday, negativeheight)
twoflow <- c(scaledflow, scaledflow)
negativeday <- -(scaledday)
flowandday <- c(negativeday, twoflow)

### Scale values of straight lines ###
scaledht <- (3.9 - min(height)) / (max(height) - min(height))
scaledhm <- (4.77 - min(height)) / (max(height) - min(height))
scaledqm <- (300.2 - min(flowrate)) / (max(flowrate) - min(flowrate))
scaledqt <- (219.1 - min(flowrate)) / (max(flowrate) - min(flowrate))

### Plot graph and straight lines ###
plot(heightandday, flowandday, pch=".", axes=FALSE, xlab=NA, ylab=NA, xaxt='n', yaxt='n', main="Aire graph")
axis(side=1, cex.axis=0.5, pos=0, at=c(-(4874/4091),-(3874/4091),-(2874/4091),-(1874/4091),-(874/4091),0.2,0.4,0.6,0.8,1.0),labels=c("6","5","4","3","2","26","27","28","29","30"))
axis(side=2,cex.axis=0.5, pos=0, at=c(-1.0,-(4/5),-(3/5),-(2/5),-(1/5),0.0,1/7,2/7,3/7,4/7,5/7,6/7,1),labels=c("30","29","28","27","26","0","50","100","150","200","250","300","350"), las=1)
polygon(x=scaledday[137:265], y=scaledflow[139:267], col="grey")
abline(v=-(scaledht), lty=3)
abline(v=-(scaledhm), lty=3)
abline(h=scaledqm, lty=3)
abline(h=scaledqt, lty=3)
segments(x0=0, y0=0, x1 = -max(scaledheight), y1 = max(scaledflow), lty=2)
segments(x0=scaledday[137], y0=scaledqt, x1=scaledday[265], y1=scaledqt)
segments(x0=scaledday[137], y0=scaledqm, x1=scaledday[265], y1=scaledqm)
segments(x0=scaledday[137], y0=scaledqt, x1=scaledday[137], y1=scaledqm)
segments(x0=scaledday[265], y0=scaledqt, x1=scaledday[265], y1=scaledqm)
segments(x0=scaledday[137], y0=-0.35, x1=scaledday[137], y1=scaledqt, lty=3)
segments(x0=scaledday[265], y0=-0.35, x1=scaledday[265], y1=scaledqt, lty=3)
arrows(x0=scaledday[137], y0=-0.35, x1=scaledday[265], y1=-0.35, length = 0.05, code=3)

### Axes and line labels ###
text(x=0, y=-1 ,label="t", cex=0.5, pos=4, font=3)
text(x=0.03, y=-1 ,label="[day]", cex=0.5, pos=4)
text(x=0, y=1 ,label="Q", cex=0.5, pos=4, font=3)
text(x=0.135, y=1 ,label=expression("[m"^3), cex=0.5)
text(x=0.125, y=0.99 ,label="/s]", cex=0.5, pos=4)
text(x=0.93, y=-0.05 ,label="t", cex=0.5, pos=1, font=3)
text(x=1, y=-0.05 ,label="[day]", cex=0.5, pos=1)
text(x=-0.98, y=-0.01 ,label=bquote(bar(h)), cex=0.5, pos=3, font=3)
text(x=-0.92, y=-0.01 ,label="[m]", cex=0.5, pos=3)
text(x=-(scaledht), y=-1 ,label="hT", cex=0.5, pos=4, font=3)
text(x=-(scaledhm), y=-1 ,label="hM", cex=0.5, pos=4, font=3)
text(x=1, y=scaledqm ,label="Qm", cex=0.5, pos=1, font=3)
text(x=1, y=scaledqt ,label="Qt", cex=0.5, pos=1, font=3)
text(x=scaledday[201], y=-0.35, label="Tf", cex=0.5, pos=1, font=3)
text(x=scaledday[400], y=-0.55, label="FEV ≈ 9.34Mm^3", cex=0.5)
text(x=scaledday[418], y=-0.62, label="Tf = 32.00hrs", cex=0.5)
text(x=scaledday[424], y=-0.69, label="hT = 3.90m", cex=0.5)
text(x=scaledday[424], y=-0.76, label="hM = 4.77m", cex=0.5)
text(x=scaledday[390], y=-0.83, label="Qt = 219.1", cex=0.5)
text(x=scaledday[444], y=-0.82 ,label=expression("m"^3), cex=0.5)
text(x=scaledday[464], y=-0.82 ,label="/s", cex=0.5)
text(x=scaledday[380], y=-0.9, label="Qm = 300.2", cex=0.5)
text(x=scaledday[444], y=-0.89 ,label=expression("m"^3), cex=0.5)
text(x=scaledday[464], y=-0.89,label="/s", cex=0.5)
