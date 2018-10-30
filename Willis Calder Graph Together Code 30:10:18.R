#CALDER DATA#

#Import Calder data#

Calder_data <- read.csv(file.coose(), header = T)

Calder_Flowrate <- Calder_data$Flowrate
Calder_Height <- Calder_data$Riverheight
Calder_Day <- Calder_data$Day

#Create vectors for each variable#

Calder_Riverheight_vector <- c(Calder_Height)
Calder_Flowrate_vector <- c(Calder_Flowrate)
Calder_Day_vector <- c(Calder_Day)

scalevector <- function(x) {return(((x-min(x)) / (max(x)-min(x))))}

#Vectors for scaled variables#

Calder_Riverheight_scaled <- scalevector(Calder_Riverheight_vector)
Calder_Flowrate_scaled <- scalevector(Calder_Flowrate_vector)
Calder_Day_scaled <- scalevector(Calder_Day_vector)

#Combine scaled vectors#

Calder_Negative_riverheight <- -(Calder_Riverheight_scaled)
Calder_HeightandDay <- c(Calder_Negative_riverheight, Calder_Day_scaled, Calder_Negative_riverheight)
Calder_Two_flowrate <- c(Calder_Flowrate_scaled, Calder_Flowrate_scaled)
Calder_Negative_day <- -(Calder_Day_scaled)
Calder_FlowrateandDay <- c(Calder_Negative_day, Calder_Two_flowrate)

#Scale the lines#

Calder_scaledht <- (4.5 - min(Calder_Height)) / (max(Calder_Height) - min(Calder_Height))
Calder_scaledhm <- (5.25 - min(Calder_Height)) / (max(Calder_Height) - min(Calder_Height))
Calder_scaledqm <- (197.5 - min(Calder_Flowrate)) / (max(Calder_Flowrate) - min(Calder_Flowrate))
Calder_scaledqt <- ((142 - min(Calder_Flowrate)) / (max(Calder_Flowrate) - min(Calder_Flowrate)))

#Plot all data together#

plot(Calder_HeightandDay, Calder_FlowrateandDay, pch=".", axes=FALSE, xlab=NA, ylab=NA, xaxt='n', yaxt='n', main="Calder Graph")
polygon((cbind(c(scalevector(26.35417), (Calder_Day_scaled[130:164]), scalevector(26.69792)), c((scalevector(164.1)), (Calder_Flowrate_scaled[130:163]), scalevector(164.1)))), col ="110000")
axis(side=1, cex.axis=0.5, pos=0, at=c(-(4731/4466),-(533/638),-(2731/4466),-(1731/4466),-(731/4466),0.25,0.5,0.75,1.0),labels=c("6","5","4","3","2","26","27","28","29"))
axis(side=2,cex.axis=0.5, pos=0, at=c(-1.0,-(3/4),-(2/4),-(1/4),0.0,2413/11593,4643/11593,7143/11593,9643/11593,1.047442422),labels=c("29","28","27","26","25","50","100","150","200","250"), las=1)
text(x=0, y=-1 ,label="t", cex=0.5, pos=4, font=3)
abline(v=-(Calder_scaledht), lty=3)
abline(v=-(Calder_scaledhm), lty=3)
abline(h=Calder_scaledqm, lty=3)
abline(h=Calder_scaledqt, lty=3)
segments(x0=0, y0=0, x1 = -max(Calder_Riverheight_scaled), y1 = max(Calder_Flowrate_scaled), lty=2)
segments(x0=Calder_Day_scaled[131], y0=scaledqt, x1=Calder_Day_scaled[165], y1=scaledqt)
segments(x0=Calder_Day_scaled[131], y0=scaledqm, x1=Calder_Day_scaled[165], y1=scaledqm)
segments(x0=Calder_Day_scaled[131], y0=scaledqt, x1=Calder_Day_scaled[131], y1=scaledqm)
segments(x0=Calder_Day_scaled[165], y0=scaledqt, x1=Calder_Day_scaled[165], y1=scaledqm)
segments(x0=Calder_Day_scaled[131], y0=-0.35, x1=Calder_Day_scaled[131], y1=scaledqt, lty=3)
segments(x0=Calder_Day_scaled[165], y0=-0.35, x1=Calder_Day_scaled[165], y1=scaledqt, lty=3)
arrows(x0=Calder_Day_scaled[131], y0=-0.35, x1=Calder_Day_scaled[165], y1=-0.35, length = 0.05, code=3)

#Graph labels#

text(x=Calder_Day_scaled[148], y=-0.35, label="Tf", cex=0.5, pos=1, font=3)
text(x=Calder_Day_scaled[330], y=-0.55, label="FEV ≈ 1.65Mm^3", cex=0.5)
text(x=Calder_Day_scaled[350], y=-0.62, label="Tf = 8.25hrs", cex=0.5)
text(x=Calder_Day_scaled[350], y=-0.69, label="hT = 4.50m", cex=0.5)
text(x=Calder_Day_scaled[350], y=-0.76, label="hM = 5.25m", cex=0.5)
text(x=Calder_Day_scaled[320], y=-0.83, label="Qt = 142.0", cex=0.5)
text(x=Calder_Day_scaled[370], y=-0.82 ,label=expression("m"^3), cex=0.5)
text(x=Calder_Day_scaled[385], y=-0.82 ,label="/s", cex=0.5)
text(x=Calder_Day_scaled[320], y=-0.9, label="Qm = 197.5", cex=0.5)
text(x=Calder_Day_scaled[370], y=-0.89 ,label=expression("m"^3), cex=0.5)
text(x=Calder_Day_scaled[385], y=-0.89,label="/s", cex=0.5)
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


