import sys
import operator

from matplotlib import pyplot as plt
import numpy as np
from scipy.optimize import curve_fit


from system import RCCircuit, RLCircuit, RLC1Circuit, RLC2Circuit, RLC3Circuit

CONSTRUCTORS = (RCCircuit, RLCircuit, RLC1Circuit, RLC2Circuit, RLC3Circuit)


def f1(t, a):
    return 1 - np.e**(-t / a)


def f2(t, a):
    return np.e**(-t / a)


FUNCS = (f1, f2)


def fit(c):
    t, v = c.step_response()
    fits = [(curve_fit(f, t, v), i) for i, f in enumerate(FUNCS)]
    (p, e), i = min(fits, key=lambda x: x[0][1])
    return p, e, i + 1


def FFT(c):
    t, v = c.impulse_response()
    plt.clf()
    ft = np.fft.fft(v)
    freq = np.fft.fftfreq(t.shape[-1])
    plt.plot(freq, (ft.real**2 + ft.imag**2))
    plt.show()
    return freq, ft


def main():
    print("""Projeto de Sinais e Sistemas 2014.1
    Equipe: Hélio, Diogo e Victor Carriço
    Opções:
    \tSair -> 0
    \tRC -> 1
    \tRL -> 2
    \tRLC1 -> 3
    \tRLC2 -> 4
    \tRLC3 -> 5

    Ex: Circuito RL R=10 L=20
    Escolha uma opção: 2
    Digite os valores dos parâmetros ( na ordem R L C): 10 20
    """)
    while True:
        op = int(input("Escolha uma opção: "))
        if op == 0:
            sys.exit(0)
        params = [float(x) for x in input(
            "Digite os valores dos parâmetros ( na ordem R L C): ").split()]
        c = CONSTRUCTORS[op - 1](*params)
        return FFT(c)

# if __name__ == '__main__':
#     main()
