import matplotlib.pyplot as plt
import pandas as pd

plt.rcParams["figure.figsize"] = [10,10]
plt.rcParams['axes.edgecolor']='white'

armley=pd.read_csv('Calder Data.csv')
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

scaledht = (4.5-min(height))/(max(height)-min(height))
scaledhm = (5.25-min(height))/(max(height)-min(height))
scaledqm = (197.5-min(flow))/(max(flow)-min(flow))
scaledqt = (142-min(flow))/(max(flow)-min(flow))

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

ax.plot([67/200,67/200,67/200],[scaledqt,scaledqm,-1/5], 'black', linestyle='--', linewidth=1)
ax.plot([67/160,67/160,67/160],[scaledqt,scaledqm,-1/5], 'black', linestyle='--', linewidth=1)
ax.plot([67/200,67/160],[-1/5,-1/5], 'black', linewidth=1)
ax.plot([67/200,67/200],[scaledqm,scaledqt], 'black',linewidth=1.5)
ax.plot([67/200,67/160],[scaledqm,scaledqm], 'black',linewidth=1.5)
ax.plot([67/200,67/160],[scaledqt,scaledqt], 'black',linewidth=1.5)
ax.plot([67/160,67/160],[scaledqm,scaledqt], 'black',linewidth=1.5)

ticks_x = [-4731/4466,-533/638,-2731/4466,-1731/4466,-731/4466,1/4,2/4,3/4,1]
#done by doing (2-min(height))/(max(height)-min(height)) to find where 2 should be positioned on the axis.
ticks_y = [-1,-3/4,-2/4,-1/4,2413/11593,4643/11593,7143/11593,9643/11593,1.047442422]
ax.set_xticks(ticks_x)
ax.set_yticks(ticks_y)
Ticks_x = [6,5,4,3,2,26,27,28,29]
Ticks_y = [29,28,27,26,50,100,150,200,250]
ax.set_xticklabels(Ticks_x)
ax.set_yticklabels(Ticks_y)
ax.spines['left'].set_position('center')
ax.spines['bottom'].set_position('center')
ax.spines['left'].set_color('black')
ax.spines['bottom'].set_color('black')
ax.tick_params(axis='x', colors='black', direction='out', length=10, width=1)
ax.tick_params(axis='y', colors='black', direction='out', length=10, width=1)

ax.fill_between(scaledday, scaledflow, scaledqt, where=scaledflow >= scaledqt, facecolor='gray')

plt.title('Calder Graph')

plt.text(-0.7, -1,'$h_t$')
plt.text(-13/15, -1,'$h_m$')
plt.text(1, scaledqm,'$Q_m$')
plt.text(1, scaledqt,'$Q_t$')
plt.text(0.45,0.675,'F.E.V.', size=15)
plt.text(0.363,-0.19,'$T_f$')
plt.text(0.331,-0.212,'<')
plt.text(0.4,-0.212,'>')

plt.text(0, 1.05,'Flow $[m^3/s]$', size=10)
plt.text(0.75, -0.13,'Day in December', size=10)
plt.text(-0.35, -1.09,'Day in December', size=10)
plt.text(-1.1, 0.02,'Height $[m]$', size=10)

plt.text(-0.015,1.07,'^')
plt.text(-0.011,-1.11,'v')
plt.text(1.08,-0.015,'>')
plt.text(-1.1,-0.015,'<')

plt.text(0.4,-0.4,'$F.E.V.≈1.65Mm^3$', size=15)
plt.text(0.4,-0.475,'$T_f=8.25hrs$', size=15)
plt.text(0.4,-0.55,'$h_t=4.5m$', size=15)
plt.text(0.4,-0.625,'$h_m=5.25m$', size=15)
plt.text(0.4,-0.7,'$Q_t=142.0m^3/s$', size=15)
plt.text(0.4,-0.775,'$Q_m=197.5m^3/s$', size=15)