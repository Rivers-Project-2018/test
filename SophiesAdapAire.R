library(readr)
River_Aire_Data <- read_csv("Desktop/University_of_Leeds/R/ArmleyF1707Stage_and_Flow15min_25Decto30Dec.csv", 
                            col_names = TRUE, col_types = cols(X4 = col_skip(), X5 = col_skip(), 
                                                               X6 = col_skip(), X7 = col_skip())) #Importing stage and flow data file + naming file

t=River_Aire_Data$Time 
Q=River_Aire_Data$Flow
h=River_Aire_Data$Height

library(readxl)
Rating_Curves <- read_excel("Desktop/University_of_Leeds/R/Rating Curves.xlsx", 
                            sheet = "Sheet2", col_types = c("numeric", 
                                                            "numeric", "numeric", "numeric", 
                                                            "numeric", "skip", "skip", "skip", 
                                                            "skip", "skip", "skip", "skip", 
                                                            "skip", "skip", "skip"))

AireC=Rating_Curves$Aire_C # simplifying Rating Curve data names
Airea=Rating_Curves$Aire_a
Aireb=Rating_Curves$Aire_b

hA=seq(from=0.16, to=6, by=0.01)

QA=matrix(nrow=585, ncol=1)

for(i in 1:585) { 
  if(hA[i]<0.685) QA[i]=AireC[1]*(hA[i]-Airea[1])^Aireb[1]
  if(0.685<=hA[i] & hA[i]<1.917) QA[i]=AireC[2]*(hA[i]-Airea[2])^Aireb[2]
  if(1.917<=hA[i]) QA[i]=AireC[3]*(hA[i]-Airea[3])^Aireb[3]
  ## John Verzani (p.470)
}

Qt=219.1 # Qt
QfFEV=Q[139:243] # Q values above Qt
lQfFEV=length(QfFEV)

QAF=matrix(nrow=lQfFEV, ncol=1)
QAFc=matrix(nrow=lQfFEV, ncol=1)

for(i in 1:lQfFEV) { 
  QAFc[i]=QfFEV[i]-Qt
  QAF[i]=QAFc[i]*(Tfs/lQfFEV)
  ## John Verzani (p.470)
}

FEVA=sum(QAF) # currently returning as 182038239 when *(Tfs/i) and 74545341 when *(Tfs/lQfFEV)

# individual plot code in the comments based on John Verzani (p.104-5)
# plot(t, Q, xlab="t [day]", ylab="Q [m³/s]") 
# plot(h, Q, xlab="h [m]", ylab="Q [m³/s]")
# plot(h, t, xlab="h [m]", ylab="t [day]")

t_min=min(t) # Setting the min and max points for t, h, Q
t_max=max(t)
h_min=0
h_max=6
Q_min=0
Q_max=350
QA_min=0
QA_max=350
ht=3.9

t_sc=(t-t_min)/(t_max-t_min) # Creating the scaled vectors of t, h, Q
h_sc=(h-h_min)/(h_max-h_min)
hA_sc=(hA-h_min)/(h_max-h_min)
Q_sc=(Q-Q_min)/(Q_max-Q_min)
QA_sc=(QA-QA_min)/(QA_max-QA_min)

plot(0,0, axes=FALSE, xlim=cbind(-1,1), ylim=cbind(-1,1), type="l", xlab="", ylab="")
lines(x=t_sc, y=Q_sc, type="l") # John Verzani (p.104-5)

segments(-0.795, 0.8577143, 1, 0.8577143, lty=2) # 0.8577143 = 300.2/350; -19/24 = -(4.77)/(6)
text(1, 67/70, labels="Qm")

segments(-0.65, 0.626, 1, 0.626, lty=2)  # 0.626 = 219.1/350; -0.65 = -(3.9)/(6)
text(1, 29/40, labels="Qt")

segments(9/32, -1/4, 9/32, 1, lty=2) # 9/32=(26.125-25)/(t_max-t_min)
segments(35/64, -1/4,35/64, 1, lty=2) # 35/64=(27.1875-25)/(t_max-t_min)

polygon(t_sc[136:264], Q_sc[138:266], col="grey") # David Alexander Lillis (2014; p.50-58); look at scaled data and use [,]

text(cbind(0,0.25,0.5,0.75,1),cbind(-0.1,-0.1,-0.1,-0.1,-0.1), labels=cbind(25,26,27,28,29), cex=0.75) #adding in axis points by text function
text(cbind(-0.1,-0.1,-0.1,-0.1,-0.1,-0.1,-0.1),cbind(1/7,2/7,3/7,4/7,5/7,6/7,1), labels=cbind(50,100,150,200,250,300,350), cex=0.75)

segments(35/64, 0.626, 9/32, 0.626, lty=1, lwd=2)
segments(35/64, 0.8577143, 9/32, 0.8577143, lty=1, lwd=2)
segments(9/32, 0.626, 9/32, 0.8577143, lty=1, lwd=2)
segments(35/64, 0.626, 35/64, 0.8577143, lty=1, lwd=2)

lines(x=-hA_sc, y=QA_sc, type="l") # John Verzani (p.104-5)
lines(x=-hA_sc, y=(1.173536)*hA_sc-(0.03114967), lty=2, col="black", xlim=cbind(-1,0), ylim=cbind(0,1)) 
# y found by two equations; (1) 0.9996063341 = 0.8783333m+c, (2) 0.000144571 = 0.02666667m+c SSS (1)-(2) => m=1.173536, c=-0.03114967; (1) 0.9996063341 = QA_sc[512,], 0.8783333 = hA_sc[512,], (2) 0.000144571 = min(QA_sc), 0.02666667 = min(hA_sc)

segments(-0.795, -1, -0.795, 0.8577143, lty=2) # -0.795 = 4.77/6
text(-101/120, -1, labels="hm")
segments(-0.65, -1, -0.65, 0.626, lty=2) # -0.65 = 3.9/6
text(-167/240, -1, labels="ht")

lines(x=-h_sc, y=-t_sc, type="l") # John Verzani (p.104-5)

axis(1, at = NULL, labels = FALSE, tick = TRUE, pos = 0,0, lwd.ticks=0)

mtext("Day", 1) # Adding axis labels
mtext("Discharge [m³/s]", 3)

text(cbind(-0.1,-0.1,-0.1,-0.1), cbind(-0.25,-0.5,-0.75,-1), labels=cbind(26,27,28,29), cex=0.75) #adding in axis points by text function
text(cbind(-1/6,-2/6,-3/6,-4/6,-5/6,-1), cbind(-0.1,-0.1,-0.1,-0.1,-0.1,-0.1), labels=cbind(1,2,3,4,5,6), cex=0.75)

axis(2, at = NULL, labels = FALSE, tick = TRUE, pos = 0,0, lwd.ticks=0)

arrows(9/32,-0.245,35/64,-0.245, length=0.1) # (Paul Murrell, R Graphics, pg 79)
arrows(35/64,-0.245,9/32,-0.245, length=0.1)
text(53/128, -0.33, labels="Tf")

text(0.625, -0.71875, labels="FEV ≈ 9.34 Mm³
     Tf = 32 hrs
     Qt = 219.1 m³/s
     Qm = 300.2 m³/s
     ht = 3.9 m
     hm = 4.77 m", cex=0.65) # (Bokhove, et al., 2018)

mtext("Height [m]", 2, las=1) 
mtext("Day", 4, las=1)
title(main="River Aire Data")