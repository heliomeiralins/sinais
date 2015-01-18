from abc import ABCMeta, abstractmethod
import numpy as np
from scipy.integrate import odeint
from sympy import Symbol, lambdify, diff
import matplotlib.pyplot as plt


class Circuit(metaclass=ABCMeta):

    t = Symbol('t')

    def __init__(self, R=0, C=0, L=0):
        self._r = R
        self._c = C
        self._l = L

    def integrate_current(self, V, time, step):
        Vin_prime = lambdify(Circuit.t, diff(V, Circuit.t), 'numpy')
        Vin = lambdify(Circuit.t, V, 'numpy')
        result = odeint(self.f,  # system of differential equations
                        self.initial(Vin(0)),  # initial conditions
                        np.arange(0, time, step),  # time
                        args=(Vin, Vin_prime))  # passes as arguments to self.f
        return result

    @abstractmethod
    def f():
        """System of differential equations for the circuit's current"""
        pass

    @abstractmethod
    def initial():
        """Initial values of the circuit"""
        pass

    @abstractmethod
    def output(self, V, time, step):
        r = self.integrate_current(V, time, step)
        r = r[:, 0]
        return r


class RCCircuit(Circuit):

    def f(self, i, t, Vin, Vin_prime):
        """i' = -i/RC + Vin'/R"""
        return -i / (self._r * self._c) + Vin_prime(t) / self._r

    def initial(self, v0):
        return v0 / self._r

    def output(self, V, time, step, plot=False):
        r = super().output(V, time, step)
        Vin = lambdify(Circuit.t, V, 'numpy')
        time_range = np.arange(0, time, step)
        ret = np.add(Vin(time_range), -self._r * r)
        if plot:
            plt.plot(time_range, ret)
            plt.show()
        return ret
