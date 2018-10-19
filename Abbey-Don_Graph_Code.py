import matplotlib.pyplot as plt
import pandas as pd

plt.rcParams["figure.figsize"] = [10,10]
plt.rcParams['axes.edgecolor']='white'

armley=pd.read_csv('Don Data.csv')
day = armley['Day in December']
flow = armley['Flow Rate (m^3/s)']
height = armley['Height (m)']

def scale(x):
    return ((x-min(x))/(max(x)-min(x)))

scaledday = scale(day)
scaledflow = scale(flow)
scaledheight = scale(height)
negday = -(scaledday)
negheight = -(scaledheight)

scaledht = (2.9-min(height))/(max(height)-min(height))
scaledhm = (4.06-min(height))/(max(height)-min(height))
scaledqm = (225.9-min(flow))/(max(flow)-min(flow))
scaledqt = (164.1-min(flow))/(max(flow)-min(flow))

a = ((max(height)-min(height))/(max(height)-min(height)))
b = ((max(flow)-min(flow))/(max(flow)-min(flow)))

fig, ax = plt.subplots()

ax.plot(scaledday, scaledflow, 'black', linewidth=2)
ax.plot(negheight, negday, 'black', linewidth=2)
ax.plot(negheight, scaledflow, 'black', linewidth=2)

ax.plot([0,-1*a], [0,b], 'black', linestyle='--', marker='', linewidth=2)

ax.plot([-scaledht,-scaledht],[-1,1], 'black', linestyle='--', linewidth=1)
ax.plot([-scaledhm,-scaledhm],[-1,1], 'black', linestyle='--', linewidth=1)
ax.plot([-1,1],[scaledqt,scaledqt], 'black', linestyle='--', linewidth=1)
ax.plot([-1,1],[scaledqm,scaledqm], 'black', linestyle='--', linewidth=1)

ax.plot([1/8,1/8,1/8],[scaledqt,scaledqm,-1/5], 'black', linestyle='--', linewidth=1)
ax.plot([107/400,107/400,107/400],[scaledqt,scaledqm,-1/5], 'black', linestyle='--', linewidth=1)
ax.plot([1/8,107/400],[-1/5,-1/5], 'black', linewidth=1)
ax.plot([1/8,1/8],[scaledqm,scaledqt], 'black',linewidth=1.5)
ax.plot([1/8,107/400],[scaledqm,scaledqm], 'black',linewidth=1.5)
ax.plot([1/8,107/400],[scaledqt,scaledqt], 'black',linewidth=1.5)
ax.plot([107/400,107/400],[scaledqm,scaledqt], 'black',linewidth=1.5)

ticks_x = [-4481/4156,-3481/4156,-2481/4156,-1481/4156,-481/4156,1/4,2/4,3/4,1]
#done by doing (2-min(height))/(max(height)-min(height)) to find where 2 should be positioned on the axis.
ticks_y = [-1,-3/4,-2/4,-1/4,1024/6249,758/2083,3524/6249,4774/6249,2008/2083,1.164026244]
ax.set_xticks(ticks_x)
ax.set_yticks(ticks_y)
Ticks_x = [6,5,4,3,2,26,27,28,29]
Ticks_y = [29,28,27,26,50,100,150,200,250,300]
ax.set_xticklabels(Ticks_x)
ax.set_yticklabels(Ticks_y)
ax.spines['left'].set_position('center')
ax.spines['bottom'].set_position('center')
ax.spines['left'].set_color('black')
ax.spines['bottom'].set_color('black')
ax.tick_params(axis='x', colors='black', direction='out', length=10, width=1)
ax.tick_params(axis='y', colors='black', direction='out', length=10, width=1)

ax.fill_between(scaledday, scaledflow, scaledqt, where=scaledflow >= scaledqt, facecolor='gray')

plt.title('Don Graph')

plt.text(-0.57, -1,'$h_t$')
plt.text(-0.85, -1,'$h_m$')
plt.text(1, scaledqm,'$Q_m$')
plt.text(1, scaledqt,'$Q_t$')
plt.text(0.3,0.73,'F.E.V.', size=15)
plt.text(0.185,-0.19,'$T_f$')
plt.text(0.12,-0.212,'<')
plt.text(0.25,-0.212,'>')

plt.text(0, 1.05,'Flow $[m^3/s]$', size=10)
plt.text(0.75, -0.13,'Day in December', size=10)
plt.text(-0.35, -1.09,'Day in December', size=10)
plt.text(-1.1, 0.02,'Height $[m]$', size=10)

plt.text(-0.015,1.07,'^')
plt.text(-0.011,-1.11,'v')
plt.text(1.08,-0.015,'>')
plt.text(-1.1,-0.015,'<')

plt.text(0.4,-0.4,'$F.E.V.≈3.00Mm^3$', size=15)
plt.text(0.4,-0.475,'$T_f=13.50hrs$', size=15)
plt.text(0.4,-0.55,'$h_t=2.90m$', size=15)
plt.text(0.4,-0.625,'$h_m=4.06m$', size=15)
plt.text(0.4,-0.7,'$Q_t=164.1m^3/s$', size=15)
plt.text(0.4,-0.775,'$Q_m=225.9m^3/s$', size=15)