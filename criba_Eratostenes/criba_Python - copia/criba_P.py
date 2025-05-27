import numpy as np
from numba import njit
import time

# Criba de Eratóstenes
@njit
def criba_eratostenes_numba(n):
    primos = np.ones(n + 1, dtype=np.bool_) 
    primos[0] = False
    primos[1] = False
    for i in range(2, int(n ** 0.5) + 1):
        if primos[i]:
            for j in range(i * i, n + 1, i):
                primos[j] = False
    return np.where(primos)[0]  

if __name__ == "__main__":
    try:
        # Medición de tiempo
        n = int(input("Ingrese la cantidad: "))
        t_inicio = time.time()
        lista_primos = criba_eratostenes_numba(n)
        t_fin = time.time()
        print(f"\nPrimos hasta {n}: {len(lista_primos)} encontrados")
        print("Lista de primos:")
        print(lista_primos)
        print(f"\nTiempo de ejecución: {t_fin - t_inicio:.6f} segundos")
    except ValueError:
        print("Por favor ingrese un número entero válido.")
