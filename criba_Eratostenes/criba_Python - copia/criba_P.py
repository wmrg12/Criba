import tracemalloc
import numpy as np
from numba import njit
import time

# Criba de Eratóstenes
@njit
def criba_eratostenes_numba(n):
      # Crea un arreglo de booleanos del tamaño n+1 inicializado en True (suponiendo que todos los números son primos)
    primos = np.ones(n + 1, dtype=np.bool_) 
    #  0 y 1 no son primos, por lo tanto, se marcan como False
    primos[0] = False
    primos[1] = False
    # Recorre desde 2 hasta la raíz cuadrada de n
    for i in range(2, int(n ** 0.5) + 1):
        if primos[i]:
             # Marca como no primos (False) todos los múltiplos de i
            for j in range(i * i, n + 1, i):
                primos[j] = False
    # Devuelve un array con los índices donde primos[i] == True, es decir, los números primos encontrados
    return np.where(primos)[0]  

if __name__ == "__main__":
    try:
        # Medición de tiempo, Solicita al usuario un número
        n = int(input("Ingrese la cantidad: "))
        #Inicia el seguimiento de memoria
        tracemalloc.start()
        t_inicio = time.time()
        # Ejecuta la criba optimizada
        lista_primos = criba_eratostenes_numba(n)
        t_fin = time.time()
        #Obtiene el consumo de memoria
        memoria_actual, memoria_pico = tracemalloc.get_traced_memory()
        tracemalloc.stop() 
        print(f"\nPrimos hasta {n}: {len(lista_primos)} encontrados")
        print("Lista de primos:")
        print(lista_primos)
        print(f"\nTiempo de ejecución: {t_fin - t_inicio:.6f} segundos")
        #Muestra el tiempo y memoria utilizados
        print(f"\nTiempo de ejecución: {t_fin - t_inicio:.6f} segundos")
        print(f"Memoria pico usada: {memoria_pico / 1024:.2f} KB") 
    except ValueError:
         # Manejo de errores si el usuario no ingresa un entero válido
        print("Por favor ingrese un número entero válido.")
