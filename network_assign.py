# -*- coding: utf-8 -*-
"""
Created on Mon Feb  8 19:09:27 2021

@author: Amarnadh Tadi
"""

import pandas as pd
import numpy as np
import networkx as nx 
import matplotlib.pyplot as plt

# Degree Centrality
data = pd.read_csv(r"C:\Users\Amarnadh Tadi\Desktop\datascience\assign7\connecting_routes.csv",header=None)
data.columns
data1=data.iloc[:,[0,6,1,2,3,4,5,7,8]]
data2=data1.iloc[:,2:]
data2.columns
data2.columns=["flights", " ID", "main Airport”, “main Airport ID", "Destination ","Destination  ID","haults","machinary"]


g = nx.Graph()

g = nx.from_pandas_edgelist(data2, source = "main Airport”, “main Airport ID", target = "Destination  ID")

print(nx.info(g))

b = nx.degree_centrality(g)  # Degree Centrality
print(b) 

pos = nx.spring_layout(g, k = 0.15)
%matplotlib inline
nx.draw_networkx(g, pos, node_size = 25, node_color = 'blue')

# closeness centrality
closeness = nx.closeness_centrality(g)
print(closeness)

## Betweeness Centrality 
b = nx.betweenness_centrality(g) # Betweeness_Centrality
print(b)