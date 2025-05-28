import scala.io.StdIn.readInt
import scala.collection.mutable.BitSet

/** 
 * Objeto principal que implementa la Criba de Eratóstenes en Scala.
 * El programa solicita un número n al usuario y calcula todos los números primos hasta n.
 * También mide el tiempo de ejecución y el consumo de memoria.
 */
object CribaEratostenes {

  /**
   * Función que ejecuta el algoritmo de la Criba de Eratóstenes.
   * @param n Límite superior hasta donde se buscan los números primos.
   * @return Una secuencia ordenada con todos los números primos hasta n.
   */
  def criba(n: Int): Seq[Int] = {
    val primos = BitSet(2 to n: _*)  // Inicializa el conjunto con todos los posibles primos

    // Elimina múltiplos de cada número primo desde 2 hasta √n
    for (i <- 2 to math.sqrt(n).toInt if primos.contains(i)) {
      for (j <- i * i to n by i) {
        primos -= j
      }
    }

    primos.toSeq.sorted  // Devuelve la lista de primos ordenada
  }

  /**
   * Función principal del programa. Lee entrada, ejecuta la criba, y muestra métricas.
   */
  def main(args: Array[String]): Unit = {
    println("Ingrese la cantidad:")
    val n = readInt()

    // Medición de memoria y tiempo antes de ejecutar el algoritmo
    val runtime = Runtime.getRuntime()
    runtime.gc()  // Sugerencia al recolector de basura para mayor precisión

    val memoriaAntes = runtime.totalMemory() - runtime.freeMemory()
    val tiempoInicio = System.nanoTime()

    val primos = criba(n)

    val tiempoFin = System.nanoTime()
    val memoriaDespues = runtime.totalMemory() - runtime.freeMemory()

    // Cálculo de métricas
    val tiempoSegundos = (tiempoFin - tiempoInicio).toDouble / 1e9
    val memoriaUsadaMB = (memoriaDespues - memoriaAntes).toDouble / (1024 * 1024)

    // Salida de resultados
    println(s"\nPrimos hasta $n: ${primos.length} encontrados")
    println("Lista de primos:")
    println(primos.mkString(", "))
    println(f"\nTiempo de ejecución: $tiempoSegundos%.6f segundos")
    println(f"Memoria utilizada (aproximada): $memoriaUsadaMB%.3f MB")
  }
}
