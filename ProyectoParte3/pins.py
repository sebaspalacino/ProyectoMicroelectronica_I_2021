import seaborn as sns
import pandas as pd
import numpy as np
import re as re
import matplotlib.pyplot as plt
from scipy.stats.kde import gaussian_kde

X = []
Y = []

f = open("system_performance.def", "r")

for line in f:
    m = re.search(r'\S (\S*) \S* (\d*) ([+-]\d*) .*', line)
    if m != None:
        X_1 = m.group(2)
        X.append(X_1)
    # print(X)
        Y_1 = m.group(3)
        Y.append(Y_1)
    # print(Y)

    else:
        print('None')
# Pasamos los arrays de bytes a que sean de enteros
for i in range(0, len(X)):
    X[i] = int(X[i])
print(X)
for j in range(0, len(Y)):
    Y[j] = int(Y[j])

# Sacamos longitud, valores minimos y maximos de los arrays
size_x = len(X)
print(size_x)
size_y = len(Y)
print(size_y)
xmin = min(X)
xmax = max(X)
ymin = min(Y)
ymax = max(Y)

# Utilizamos las funciones de la libreria scipy.kde
# Sacado de: https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.gaussian_kde.html
density = gaussian_kde(np.vstack([X, Y]))
xi, yi = np.mgrid[xmin:xmax:size_x**0.5*1j, ymin:ymax:size_y**0.5*1j]
zi = density(np.vstack([xi.flatten(), yi.flatten()]))

fig = plt.figure(figsize=(7, 8))
ax1 = fig.add_subplot(211)
ax2 = fig.add_subplot(212)

ax1.pcolormesh(xi, yi, zi.reshape(xi.shape), alpha=1)
ax2.contourf(xi, yi, zi.reshape(xi.shape), alpha=1)

ax1.set_xlim(xmin, xmax)

ax1.set_ylim(ymin, ymax)

ax2.set_xlim(xmin, xmax)

ax2.set_ylim(ymin, ymax)
plt.show()
