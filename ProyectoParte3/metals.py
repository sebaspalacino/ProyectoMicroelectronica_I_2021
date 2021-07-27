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
f = open("system_area.def", "r")

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
        print('None')


print(X2)
# if  (m.group(1)!= 'FILL'):
# scontinue
# print(m.group(1))

# print(X_1)

# print(X)

# print(Y_1)

# print(Y)
# else:
# print(m.group(1))

start_point = [X, Y]
end_point = [X2, Y2]
rectangulo = cv2.rectangle(start_point, end_point)



