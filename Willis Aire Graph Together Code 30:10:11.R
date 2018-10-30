#AIRE DATA#

load("~/.RData")
Day <- Aire_Data$Day
View(Aire_Data)
Aire_Data <- read.csv(file.choose(), header = T)

#Define all variables from data#

Riverheight <- Aire_Data$Riverheight
Flowrate <- Aire_Data$Flowrate
Day <- Aire_Data$Day

#Create vectors for each variable#

Riverheight_vector <- c(Riverheight)
Flowrate_vector <- c(Flowrate)
Day_vector <- c(Day)

scalevector <- function(x) {return(((x-min(x)) / (max(x)-min(x))))}

#Vectors for scaled variables#

Riverheight_scaled <- scalevector(Riverheight_vector)
Flowrate_scaled <- scalevector(Flowrate_vector)
Day_scaled <- scalevector(Day_vector)

#Combine scaled vectors#

Negative_riverheight <- -(Riverheight_scaled)
HeightandDay <- c(Negative_riverheight, Day_scaled, Negative_riverheight)
Two_flowrate <- c(Flowrate_scaled, Flowrate_scaled)
Negative_day <- -(Day_scaled)
FlowrateandDay <- c(Negative_day, Two_flowrate)

#Scale the lines#

scaledht <- (3.9 - min(Riverheight)) / (max(Riverheight) - min(Riverheight))
scaledhm <- (4.77 - min(Riverheight)) / (max(Riverheight) - min(Riverheight))
scaledqm <- (300.2 - min(Flowrate)) / (max(Flowrate) - min(Flowrate))
scaledqt <- (219.1 - min(Flowrate)) / (max(Flowrate) - min(Flowrate))

#Plot all data together#

plot(HeightandDay, FlowrateandDay, pch=".", axes=FALSE, xlab=NA, ylab=NA, xaxt='n', yaxt='n', main="Aire graph")
polygon(cbind(c(scalevector(26.42708), (Day_scaled[137:265]), scalevector(27.77083)), c(scalevector(219.1), (Flowrate_scaled[137:265]), scalevector(219.1))), col ="110000")
axis(side=1, cex.axis=0.5, pos=0, at=c(-1.0,-(5/6),-(4/6),-0.5,-(2/6),-(1/6),0.0,0.2,0.4,0.6,0.8,1.0),labels=c("6","5","4","3","2","1","25","26","27","28","29","30"))
axis(side=2,cex.axis=0.5, pos=0, at=c(-1.0,-(4/5),-(3/5),-(2/5),-(1/5),0.0,1/7,2/7,3/7,4/7,5/7,6/7,1),labels=c("30","29","28","27","26","25","50","100","150","200","250","300","350"), las=1)
text(x=0, y=-1 ,label="t", cex=0.5, pos=4, font=3)
abline(v=-(scaledht), lty=3)
abline(v=-(scaledhm), lty=3)
abline(h=scaledqm, lty=3)
abline(h=scaledqt, lty=3)
segments(x0=0, y0=0, x1 = -max(Riverheight_scaled), y1 = max(Flowrate_scaled), lty=2)
segments(x0=Day_scaled[137], y0=scaledqm, x1=Day_scaled[265], y1=scaledqm)
segments(x0=Day_scaled[137], y0=scaledqt, x1=Day_scaled[137], y1=scaledqm)
segments(x0=Day_scaled[265], y0=scaledqt, x1=Day_scaled[265], y1=scaledqm)
segments(x0=Day_scaled[137], y0=-0.35, x1=Day_scaled[137], y1=scaledqt, lty=3)
segments(x0=Day_scaled[265], y0=-0.35, x1=Day_scaled[265], y1=scaledqt, lty=3)
arrows(x0=Day_scaled[137], y0=-0.35, x1=Day_scaled[265], y1=-0.35, length = 0.05, code=3)

#Graph labels#

text(x=Day_scaled[201], y=-0.35, label="Tf", cex=0.5, pos=1, font=3)
text(x=Day_scaled[400], y=-0.55, label="FEV ≈ 9.34Mm^3", cex=0.5)
text(x=Day_scaled[418], y=-0.62, label="Tf = 32.00hrs", cex=0.5)
text(x=Day_scaled[424], y=-0.69, label="hT = 3.90m", cex=0.5)
text(x=Day_scaled[424], y=-0.76, label="hM = 4.77m", cex=0.5)
text(x=Day_scaled[390], y=-0.83, label="Qt = 219.1", cex=0.5)
text(x=Day_scaled[444], y=-0.82 ,label=expression("m"^3), cex=0.5)
text(x=Day_scaled[464], y=-0.82 ,label="/s", cex=0.5)
text(x=Day_scaled[380], y=-0.9, label="Qm = 300.2", cex=0.5)
text(x=Day_scaled[444], y=-0.89 ,label=expression("m"^3), cex=0.5)
text(x=Day_scaled[464], y=-0.89,label="/s", cex=0.5)
text(x=0.03, y=-1 ,label="[day]", cex=0.5, pos=4)
text(x=0, y=1 ,label="Q", cex=0.5, pos=4, font=3)
text(x=0.05, y=1 ,label=expression("[m"^3), cex=0.5)
text(x=0.045, y=0.99 ,label="/s]", cex=0.5, pos=4)
text(x=0.93, y=-0.02 ,label="t", cex=0.5, pos=1, font=3)
text(x=1, y=-0.02 ,label="[day]", cex=0.5, pos=1)
text(x=-0.98, y=-0.01 ,label=bquote(bar(h)), cex=0.5, pos=3, font=3)
text(x=-0.92, y=-0.01 ,label="[m]", cex=0.5, pos=3)
text(x=-(scaledht), y=-1 ,label="hT", cex=0.5, pos=4, font=3)
text(x=-(scaledhm), y=-1 ,label="hM", cex=0.5, pos=4, font=3)
text(x=1, y=scaledqm ,label="Qm", cex=0.5, pos=1, font=3)
text(x=1, y=scaledqt ,label="Qt", cex=0.5, pos=1, font=3)

