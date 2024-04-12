import numpy as np

def _gauss_exponent(x, mu, sigma):
    t = ((x - mu) / sigma)**2
    return np.exp(-t / 2)

def gauss(x, mu=0, sigma=1):
    A = sigma * np.sqrt(2 * np.pi)
    return _gauss_exponent(x, mu, sigma) / A

