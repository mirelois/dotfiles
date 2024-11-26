#!/home/utilizador/Documents/HasLab/PI/env/bin/python3

import pickle as pkl
import sys

import matplotlib
matplotlib.use('Qt5Agg')
import matplotlib.pyplot as plt


file = sys.argv[1]

print(file)

with open(file, "rb") as fid:
    fig = pkl.load(fid)

plt.show(block=True)

exit()

