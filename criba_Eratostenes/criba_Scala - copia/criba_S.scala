import scala.io.StdIn.readInt
import scala.collection.mutable.BitSet

object CribaEratostenes {
  def criba(n: Int): Seq[Int] = {
    val primos = BitSet(2 to n: _*)  

    for (i <- 2 to math.sqrt(n).toInt if primos.contains(i)) {
      for (j <- i * i to n by i) {
        primos -= j  
      }
    }

    primos.toSeq.sorted
  }

  def main(args: Array[String]): Unit = {
    println("Ingrese la cantidad:")
    val n = readInt()

    val t1 = System.nanoTime()
    val resultado = criba(n)
    val t2 = System.nanoTime()

    val duracionSeg = (t2 - t1).toDouble / 1e9

    println(s"\nPrimos hasta $n: ${resultado.length} encontrados")
    println("Lista de primos:")
    println(resultado.mkString(", "))
    println(f"\nTiempo de ejecución: $duracionSeg%.6f segundos")
  }
}
