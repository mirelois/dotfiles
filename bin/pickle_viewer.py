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

    ax_master = fig.axes[0]
    for ax in fig.axes:
        if ax is not ax_master:
            ax_master.get_shared_y_axes().join(ax_master, ax)

    plt.show(block=True)

exit()

