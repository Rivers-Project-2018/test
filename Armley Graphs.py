import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os

armley=pd.read_csv('Aire Data.csv')

day = armley['Day in December']
flow = armley['Flow Rate (m^3/s)']
plt.plot(day,flow)
plt.gcf().autofmt_xdate() #makes the x axis go into itallics#
plt.xlabel('Day in December 2015')
plt.ylabel('Flow Rate $[m^3/s]$')
plt.title('Flow Rate of the River Aire at Armley')
plt.show()

height = armley['Height (m)']
plt.plot(day,height)
plt.gcf().autofmt_xdate()
plt.xlabel('Day in December 2015')
plt.ylabel('Height [m]')
plt.title('Height of the River Aire at Armley')
plt.show()

plt.plot(height,flow)
plt.gcf().autofmt_xdate()
plt.xlabel('Height [m]')
plt.ylabel('Flow $[m^3/s]$')
plt.title('The Rating Curve of the River Aire at Armley')
a = [1.126,5.217]
b = [32,344]
plt.plot(a, b, 'gray', linestyle='--', marker='')
plt.show()
#################
def create_plot(ptype):  
    if ptype == 'Height':
        x = height
        y = day 
    elif ptype == 'Flow':
        x = day
        y = flow
    elif ptype == 'Rating Curve':
        x = height
        y = flow
    return(x, y) 
  
plt.style.use('fivethirtyeight') 
  
fig = plt.figure() 
   
plt1 = fig.add_subplot(222) 
plt2 = fig.add_subplot(223)
plt3 = fig.add_subplot(221) 

x, y = create_plot('Flow') 
plt1.plot(x, y) 
  
x, y = create_plot('Height') 
plt2.plot(-x, y) 

x, y= create_plot('Rating Curve')
plt3.plot(-x, y)
a = [-1.126,-5.217]
b = [32,344]
plt3.plot(a, b, 'gray', linestyle='--', marker='')

fig.subplots_adjust(hspace=-0,wspace=0) 
   
plt.show()
######################
def scale(x):
    return ((x-min(x))/(max(x)-min(x)))

scaledday = scale(day)
scaledflow = scale(flow)
scaledheight = scale(height)

negday = -(scaledday)
negheight = -(scaledheight)

heightandday = negheight + scaledday + negheight
twoflow = scaledflow + scaledflow
flowandday = negday + twoflow

scaledht = (3.9 - min(height)) / (max(height) - min(height))
scaledhm = (4.77 - min(height)) / (max(height) - min(height))
scaledqm = (300.2 - min(flow)) / (max(flow) - min(flow))
scaledqt = (219.1 - min(flow)) / (max(flow) - min(flow))

plt.plot(scaledday,scaledflow, negheight, negday, negheight, scaledflow)
a = [-1.126,-5.217]
b = [32,344]

def singlescale(x,y):
    return ((x-min(y))/(max(y)-min(y)))

a_1 = ((1.126-min(height))/(max(height)-min(height)))
a_2 = 

scaleda = singlescale(a,-height)
    
plt.plot(scaleda, scaledb, 'gray', linestyle='--', marker='')



#can use negative numbers to get appropriate axis and then re-label axis





