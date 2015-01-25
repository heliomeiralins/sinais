from abc import ABCMeta

from matplotlib import pyplot as plt
import numpy as np
from scipy import signal


class Circuit(metaclass=ABCMeta):

    def impulse_response(self, T=None, p=100000):
        if T is not None:
            T = np.linspace(0, T, p)
        return signal.impulse(self.system, T=T)

    def step_response(self, T=None, p=100000):
        if T is not None:
            T = np.linspace(0, T, p)
        return signal.step(self.system, T=T)

    def bode(self):
        w, mag, phase = signal.bode(self.system)
        plt.clf()
        plt.semilogx(w, mag)
        plt.xlabel('freq')
        plt.ylabel('magnitude (db)')
        plt.figure()
        plt.semilogx(w, phase)
        plt.xlabel('freq')
        plt.ylabel('phase')
        plt.show()

    def plot_impulse_response(self, T=None):
        t, v = self.impulse_response(T=T)
        plt.clf()
        plt.plot(t, v)
        plt.show()

    def plot_step_response(self, T=None):
        t, v = self.step_response(T=T)
        plt.clf()
        plt.plot(t, v)
        plt.show()

    def output(self, V, T, p=100000):
        t = np.linspace(0, T, p)
        V = np.vectorize(V)
        v = V(t)
        return signal.lsim(self.system, v, t)


class RCCircuit(Circuit):

    def __init__(self, r, c):
        self.r = r
        self.c = c
        self.system = signal.lti([1], [r * c, 1])


class RLCircuit(Circuit):

    def __init__(self, r, l):
        self.r = r
        self.l = l
        self.system = signal.lti([1, 0], [1, r / l])


class RLC1Circuit(Circuit):

    def __init__(self, r, l, c):
        self.r = r
        self.c = c
        self.l = l
        self.system = signal.lti([r / l, 0], [1, r / l, 1 / (c * l)])


class RLC2Circuit(Circuit):

    def __init__(self, r, l, c):
        self.r = r
        self.c = c
        self.l = l
        self.system = signal.lti([1, 0, 1 / (l * c)], [1, r / l, 1 / (c * l)])


class RLC3Circuit(Circuit):

    def __init__(self, r, l, c):
        self.r = r
        self.c = c
        self.l = l
        self.system = signal.lti([1], [l * c, r * c, 1])
