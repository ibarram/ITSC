#-------------------------------------------------------------------------------------
# Script to load and read the dataset processed from the Matlab file
#-------------------------------------------------------------------------------------
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import argparse
import os
from scipy.io import loadmat

data = loadmat('Data_ITSC.mat', simplify_cells=True)
itsc = data['itsc']

fields_names = list(itsc.keys())
print(fields_names)


sub_fields_names = list(itsc[fields_names[1]].keys())
print(sub_fields_names)

# data information
n_classes = len(fields_names)
n_rep     = len(sub_fields_names)
n_samples = 1000;
n_phases  = 3
Data      = np.ndarray(shape = (n_classes, n_rep, n_samples, n_phases))
for n in range(0, n_classes):
	for r in range(0, n_rep):
		Data[n, r, :, :] = itsc[fields_names[n]][sub_fields_names[r]]

print("[INFO] Data shape = {}".format(Data.shape))
print("[INFO] Data[1,5,1:10,:] = \n {}".format(Data[1,4,1:10,:]))