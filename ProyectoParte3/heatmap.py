import seaborn as sns
import pandas as pd
import numpy as np
import re as re
import matplotlib.pyplot as plt
from scipy.stats.kde import gaussian_kde

X=[]
Y=[]

f = open("system_area.def", "r")
#information = f.read()

#cells = sns.load_dataset("information")
#ax = sns.heatmap()


#import numpy as np
#import matplotlib.pyplot as plt

#x = np.random.rayleigh(50, size=5000)
#y = np.random.rayleigh(50, size=5000)


#plt.hist2d(x,y, bins=[np.arange(0,400,5),np.arange(0,300,5)])

#plt.show()

#En teoria esto lee el archivo
for line in f:
	m = re.search(r'- \S* (\S*) \+ \S* \( (\d*) (\d*) \) .*', line) #group(0) no es, group(1) es el nombre de la celda, group(2) es la coordenada en X, group(3) es la coordenada en Y
	if m != None:	
		if  (m.group(1)!= 'FILL'):
			#scontinue
			#print(m.group(1))
			X_1 = m.group(2)
			#print(X_1)
			X.append(X_1)
			#print(X)
			Y_1 = m.group(3)
			#print(Y_1)
			Y.append(Y_1)
			#print(Y)
		else:
			Z=0
			#print(m.group(1))
		
	else:
		print('None')	

#print(len(X))
#print(len(Y))		
#size_x = len(X)
#size_y = len(Y)
#X_int = int(X)
#Y_int = int(Y)
#xmin = min(X_int)
#xmax = max(X_int)
#xmin = min(X)
#xmax = max(X)
#print(xmin)
#print(xmax)
#print(xmin)
#print(xmax)
#ymin = min(Y)
#ymax = max(Y)
#print(ymin)
#print(ymax)
#print(ymin)
#print(ymax)
#data = [X Y]
#ax = sns.heatmap()

for i in range(0,len(X)):
	X[i] = int(X[i])

for j in range(0, len(Y)):
	Y[j] = int(Y[j])	


size_x = len(X)
size_y = len(Y)
xmin = min(X)
xmax = max(X)
ymin = min(Y)
ymax = max(Y)

density = gaussian_kde(np.vstack([X, Y]))
xi, yi = np.mgrid[xmin:xmax:size_x**0.5*1j, ymin:ymax:size_y**0.5*1j]
zi = density(np.vstack([xi.flatten(), yi.flatten()]))

fig = plt.figure(figsize=(7,8))
ax1 = fig.add_subplot(211)
ax2 = fig.add_subplot(212)

ax1.pcolormesh(xi, yi, zi.reshape(xi.shape), alpha=1)
ax2.contourf(xi, yi, zi.reshape(xi.shape), alpha=1)

ax1.set_xlim(xmin, xmax)

ax1.set_ylim(ymin, ymax)

ax2.set_xlim(xmin, xmax)

ax2.set_ylim(ymin, ymax)
plt.show()

















