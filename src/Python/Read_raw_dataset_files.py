#----------------------------------------------------------------------------------------
# Script to load and read the Raw dataset from the files seperated into folders
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

n_samples = 5000
n_classes = 13
n_phases  = 3
n_rep     = 5
Data      = np.ndarray(shape = (n_classes, n_rep, n_samples, n_phases))

files = [os.path.join(pathBD, fname)
			for root, dirs, files in os.walk(pathBD)
				for fname in files
					if fname.endswith((".csv"))]

nfiles = len(files)
val    = 0
for f in range(0, nfiles):
	flag = (f+1)%n_rep
	if flag == 0:
		val = val + 1;
		ind = val
	else:
		ind = val + 1

	rep = int(((files[f].split("_"))[-1].split("."))[0])

	df = pd.read_csv(files[f], header = None)
	Data[ind-1,rep-1,:,:] = df.to_numpy()

print("[INFO] Data shape = {}".format(Data.shape))
print("[INFO] Data[1,5,1:10,:] = \n {}".format(Data[1,4,1:10,:]))