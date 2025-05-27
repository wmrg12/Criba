# Criba de Eratóstenes en Python con entrada desde la terminal

def criba_eratostenes(n):
    primos = [True] * (n + 1)
    primos[0] = primos[1] = False
    for i in range(2, int(n ** 0.5) + 1):
        if primos[i]:
            for j in range(i * i, n + 1, i):
                primos[j] = False
    return [i for i, es_primo in enumerate(primos) if es_primo]

if __name__ == "__main__":
    try:
        n = int(input("Ingrese la cantidad: "))
        lista_primos = criba_eratostenes(n)
        print(f"\n Primos hasta {n}: {len(lista_primos)} encontrados")
        print("Lista de primos:")
        print(lista_primos)
    except ValueError:
        print("Por favor ingrese un numero entero válido.")
