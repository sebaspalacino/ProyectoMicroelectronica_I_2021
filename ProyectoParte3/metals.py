import seaborn as sns
import pandas as pd
import numpy as np
import re as re
import matplotlib.pyplot as plt
from scipy.stats.kde import gaussian_kde
import cv2


X = []
Y = []

X2 = []
Y2 = []
f = open("system_performance.def", "r")

for line in f:
    # group(0) no es, group(1) es el nombre del metal, group(2) es la coordenada en X1, group(3) es la coordenada en Y1
    m = re.search(r'NEW (metal4) \S* (\d*) (\d*) \S* \S* (\S*) (\S*) .*', line)
    # group(4) es la coordenada en X2, group(5) es la coordenada en Y2
    if m != None:
        X_1 = m.group(2)
        X.append(X_1)
        # print(X)
        Y_1 = m.group(3)
        Y.append(Y_1)
        # print(Y)
        if (m.group(4) == '*'):  # Si hay un * en X_2, se agarra el valor que se tiene en X_1
            X_2 = X_1
            X2.append(X_2)
         #   print(X2)
        if (m.group(5) == '*'):  # Si hay un * en Y_2, se agarra el valor que se tiene en Y_1
            Y_2 = Y_1
            Y2.append(Y_2)
         #   print(Y2)
        else:
            Z = 0
    else:
        print('None') #Si no encuentra match en el archivo, imprime None




#Pasamos los arrays de bytes a que sean de enteros
for i in range(0,len(X)):
	X[i] = int(X[i])

for j in range(0, len(Y)):
	Y[j] = int(Y[j]) 
	
for s in range(0,len(X2)):
	X2[s] = int(X2[s])

for t in range(0, len(Y2)):
	Y2[t] = int(Y2[t])	
	   
print(len(X))
print(len(Y))
print(len(X2))
print(len(Y2))

#Ahora sucede que X2 y Y2 no son del mismo tamaño que X y Y, entonces se hace dos arrays de 0s para rellenar la longitud y que sean igual

print('Prueba')    
Fill_X = np.zeros(807) #799 valores es lo que le falta a X2 para ser igual a X cuando se tiene system_area.def. Para system_performance usar 807
print(len(Fill_X))
Fill_Y = np.zeros(3832)    #3284 valores es lo que le falta a Y2 para ser igual a Y cuando se tiene system_area.def. Para system_performance usar 3832
print(len(Fill_Y))
print(min(Fill_X))
print(max(Fill_X))
print(min(Fill_Y))
print(max(Fill_Y))    

X2f = X2
Y2f = Y2
X2f.extend(Fill_X) #Unimos los vectores para tener la misma longitud
Y2f.extend(Fill_Y)

print('Valores de longitud')
print(len(X2f))
print(len(Y2f))


#Con la funcion quiver, creamos los vectores 
plt.quiver(X, Y, X2, Y2, color='royalblue', units='xy', scale=6)


plt.title('Metal Map 4')
plt.xlim(0, 70000)
plt.ylim(0, 70000)
plt.grid()
plt.show()







