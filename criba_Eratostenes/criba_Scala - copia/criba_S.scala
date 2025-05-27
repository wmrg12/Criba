// Criba de Eratóstenes en Scala con entrada por consola y salida de lista de primos

import scala.io.StdIn.readInt

object CribaEratostenes {
  def criba(n: Int): Seq[Int] = {
    val primos = Array.fill(n + 1)(true)
    primos(0) = false
    primos(1) = false

    for (i <- 2 to math.sqrt(n).toInt if primos(i)) {
      for (j <- i * i to n by i) {
        primos(j) = false
      }
    }

    primos.zipWithIndex.collect { case (true, i) => i }
  }

  def main(args: Array[String]): Unit = {
    println("Ingrese la cantidad:")
    val n = readInt()
    val resultado = criba(n)

    println(s"\nPrimos hasta $n: ${resultado.length} encontrados")
    println("Lista de primos:")
    println(resultado.mkString(", "))
  }
}
