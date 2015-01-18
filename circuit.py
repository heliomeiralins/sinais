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
    def _output():
        """Calculate the output, given the current"""
        pass

    def output(self, V, time, step, plot=False):
        i = self.integrate_current(V, time, step)
        i = i[:, 0]
        Vin = lambdify(Circuit.t, V, 'numpy')
        time_range = np.arange(0, time, step)
        output = self._output(Vin, i, time_range)
        if plot:
            Vin = np.vectorize(Vin)
            plt.plot(time_range, Vin(time_range))
            plt.plot(time_range, output)
            plt.show()
        return output


class RCCircuit(Circuit):

    def f(self, i, t, Vin, Vin_prime):
        """i' = -i/RC + Vin'/R"""
        return -i / (self._r * self._c) + Vin_prime(t) / self._r

    def initial(self, v0):
        return v0 / self._r

    def _output(self, Vin, i, time_range):
        return np.add(Vin(time_range), -self._r * i)
