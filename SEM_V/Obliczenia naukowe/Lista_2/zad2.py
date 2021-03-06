#
#   @author Mateusz Laskowski
#

################# DRAW PLOT OF THE FUNCTION #################

import matplotlib.pyplot as plt
import numpy as np
from numpy import exp, log as ln

t = np.arange(0, 40, 0.2)
def func(x):
    return (exp(1)**x) * ln(1 + exp(-x))
plt.plot(t, func(t), 'r')
plt.show()