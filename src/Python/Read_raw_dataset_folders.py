#----------------------------------------------------------------------------------------
# Script to load and read the Raw dataset from the folder
#----------------------------------------------------------------------------------------
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import argparse
import os

ap   = argparse.ArgumentParser()
ap.add_argument("-d", "--dataset", required=True,help="path to input dataset")
args = vars(ap.parse_args())

pathBD = os.path.join(os.getcwd(),args["dataset"])

subfolders = [os.path.join(pathBD, name)
				for root, dirs, files in os.walk(pathBD)
					for name in dirs]

nclasses = len(subfolders)

n_samples = 5000;
n_phases  = 3
n_rep     = 5
Data      = np.ndarray(shape = (nclasses, n_rep, n_samples, n_phases))
for n, classe in enumerate(subfolders):
	path  = subfolders[n]
	files = [os.path.join(path, fname)
				for root, dirs, files in os.walk(path)
					for fname in files
						if fname.endswith((".csv"))]
	nfiles = len(files)
	
	for f in range(0, nfiles):
		df = pd.read_csv(files[f], header = None)
		Signals = df.to_numpy();
		Data[n,f,:,:] = Signals

print("[INFO] Data shape = {}".format(Data.shape))
print("[INFO] Data[1,5,1:10,:] = \n {}".format(Data[1,4,1:10,:]))