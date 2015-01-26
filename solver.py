import sys
import operator

from matplotlib import pyplot as plt
import numpy as np
from scipy.optimize import curve_fit, leastsq
from scipy.signal import find_peaks_cwt


from system import RCCircuit, RLCircuit, RLC1Circuit, RLC2Circuit, RLC3Circuit

CONSTRUCTORS = (RCCircuit, RLCircuit, RLC1Circuit, RLC2Circuit, RLC3Circuit)


def f1(t, a):
    return 1 - np.e**(-t / a)


def f2(t, a):
    return np.e**(-t / a)


def fi1(t, a):
    return np.e**(-t / a) / a


def fi2(t, a):
    return - np.e**(-t / a) / a


def fi3(t, a, b, c):
    return a * np.e**(-b / 2) * np.cos(c * t)

FUNCS = (fi1, fi2)


def fti(s, a=1 / (2 * np.pi)):
    return 1.0 / (1j * a * s + 1)


def fit(c):
    t, v = c.impulse_response()
    fits = [(curve_fit(f, t, v), i) for i, f in enumerate(FUNCS)]
    (p, e), i = min(fits, key=lambda x: x[0][1])
    if e < 1e-10:
        return p, e, i + 1
    if v[0] > 0:
        print("RLC1")
        print("R/L = {}".format(v[0]))
    elif abs(v[0]) < 1e-10:
        print("RLC3")
    else:
        print("RLC2")
        print("R/L = {}".format(-v[0]))
    peaks = find_peaks_cwt(v, np.arange(1, max(t)))
    print(peaks, t[peaks], v[peaks])


def FFT(c):
    t, v = c.impulse_response()
    ft = np.fft.rfft(v)
    freq = np.fft.rfftfreq(t.shape[-1])
    plt.clf()
    plt.plot(freq, abs(ft))
    # plt.plot(freq, )
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
        print(fit(c))

if __name__ == '__main__':
    main()
