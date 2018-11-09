##Importing matplotlib, pandas and numpy##
import matplotlib.pyplot as plt 
import pandas as pd 
import numpy as np

##Defining the characteristics of the graph parameters##
plt.rcParams["figure.figsize"] = [10,10] 
plt.rcParams['axes.edgecolor']='white' 
 
##Assigning raw data to variables##
armley=pd.read_csv('A.F_River_Aire_Armley_2015_Data.csv') 
day = armley['Day in December '] 
flow = armley['Flow /m^3s^-1'] 
height = armley['Height/m'] 
 
##Defining a scale function##
def scale(x,y):return ((x-min(y))/(max(y)-min(y)))

##Scaling variables in preparation for plotting as subplots##
scaled_day=scale(day,day)
scaled_flow=scale(flow,flow)
neg_scaled_height=-(scale(height,height))
neg_scaled_day=-(scaled_day)

##Renaming command##
fig,ax=plt.subplots()

##Defining coefficients for linear plot on rating curve##
a=scale(max(height),height)
b=scale(max(flow),flow)

##Plotting subplots##
ax.plot(scaled_day,scaled_flow,'black', linewidth=2)
ax.plot(neg_scaled_height, scaled_flow,'black', linewidth=2)
ax.plot(neg_scaled_height,neg_scaled_day,'black', linewidth=2)
ax.plot([0,-1*a],[0,b], 'red',linestyle='--',marker='',linewidth=1.5)

##Centering and formatting axes##
ax.spines['left'].set_position('center')
ax.spines['bottom'].set_position('center')
ax.spines['left'].set_color('black')
ax.spines['bottom'].set_color('black')
ax.tick_params(axis='x',color='black',direction='out',length=10,width=1)
ax.tick_params(axis='y',color='black',direction='out',length=10,width=1)

##Labelling the axis by scaling them in each quadrant. Tick locations calculated by the following equation##
##f(x)=((intended tick label value)-min(variable)/(max(variable)-min(variable))) where variable can be day,flow,heigh##
##Where axis are reversed, the above function was negated.##
##Each quadrant was considered independently##
position_x_ticks=[-4874/4091,-3874/4091,-2874/4091,-1874/4091,-874/4091,0,1/6,2/6,3/6,4/6,5/6,1]
position_y_ticks=[-1,-5/6,-4/6,-3/6,-2/6,-1/6,0,3/52,17/78,59/156,7/13,109/156,67/78,53/52]
ax.set_xticks(position_x_ticks)
ax.set_yticks(position_y_ticks)
label_x_ticks=[6,5,4,3,2,25,26,27,28,29,30,31]
label_y_ticks=[31,30,29,28,27,26,0,50,100,150,200,250,300,350]
ax.set_xticklabels(label_x_ticks)
ax.set_yticklabels(label_y_ticks)

##Giving the graph a title and labelling the axes##
plt.title('Graph to show the flood event of the River Aire (Armley) in December 2015',size=12)
plt.text(0.05, 1.05, 'Q $[m^3/s]$',style='italic',size=10)
plt.text(0.75,-0.15, 't [day]',style='italic',size=10)
plt.text(-1.1, -0.15, 'Stage $[m]$',style='italic',size=10)
plt.text(-0.35,-1.09, 't [day]',style='italic', size=10)

##Defining points of interest on the graph##
scaled_ht=scale(3.90,height)
scaled_hm=scale(4.77,height)
scaled_qt=scale(219.1,flow)
scaled_qm=scale(300.2,flow)

##Highlighting and labelling regions of interest##
ax.plot([-scaled_ht,-scaled_ht],[-1,scaled_qt],'black',linestyle='--',linewidth=1)
ax.plot([-scaled_hm,-scaled_hm],[-1,scaled_qm],'black',linestyle='--',linewidth=1)
ax.plot([-scaled_ht,1],[scaled_qt,scaled_qt],'black',linestyle='--',linewidth=1)
ax.plot([-scaled_hm,1],[scaled_qm,scaled_qm],'black',linestyle='--',linewidth=1)
ax.plot([scale(26.42708,day),scale(26.42708,day)],[-0.2, scaled_qm],'black',linestyle='--',linewidth=1)
ax.plot([scale(27.76042,day),scale(27.76042,day)],[-0.2, scaled_qm],'black',linestyle='--',linewidth=1)
plt.text(-scaled_ht, -1.05, '$h_T$', style='italic', size=11)
plt.text(-scaled_hm, -1.05, '$h_m$', style='italic', size=11)
plt.text(1.05, scaled_qt, '$Q_T$', style='italic', size=11)
plt.text(1.05, scaled_qm, '$Q_m$', style='italic', size=11)
plt.text(0.33,-0.25,'$T_f$',style='italic', size=11)

##Filling in a region of interest##
ax.fill_between(scaled_day,scaled_flow,scaled_qt, where=scaled_flow>=scaled_qt,facecolor='gray')

##Plotting an area which estimates the F.E.V##
##Vertices of square F.E.V region were found by manually extrapolating data points with values cloesest to h_m,h_T, Q_m and Q_T##
##Data values were then scaled##
ax.plot([scale(26.42708,day),scale(26.42708,day)],[scaled_qt, scaled_qm],'black',linewidth=2)
ax.plot([scale(27.76042,day),scale(27.76042,day)],[scaled_qt, scaled_qm],'black',linewidth=2)
ax.plot([scale(26.42708,day),scale(27.76042,day)],[scaled_qt, scaled_qt],'black',linewidth=2)
ax.plot([scale(26.42708,day),scale(27.76042,day)],[scaled_qm, scaled_qm],'black',linewidth=2)
plt.text(0.30,0.7,'F.E.V',style='italic', size=11)

##Listing important variables in the bottom-right quandrant##
plt.text(0.33, -0.5,'F.E.V≈9.34 $Mm^3$', style='italic', size=12)
plt.text(0.33, -0.55,'$T_f=32.00hrs$', style='italic', size=12)
plt.text(0.33, -0.6,'$h_T=3.90m$', style='italic', size=12)
plt.text(0.33, -0.65,'$h_m=4.77m$', style='italic', size=12)
plt.text(0.33, -0.7,'$Q_T=219.1 m^3/s$',style='italic', size=12)
plt.text(0.33, -0.75,'$Q_m=300.2 m^3/s$',style='italic', size=12)

