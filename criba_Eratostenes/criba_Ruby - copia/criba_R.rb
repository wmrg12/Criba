require 'benchmark'
require 'memory_profiler'

def criba_eratostenes(n)
  primos = Array.new(n + 1, true)
  primos[0] = primos[1] = false

  (2..Math.sqrt(n)).each do |i|
    if primos[i]
      (i*i).step(n, i) { |j| primos[j] = false }
    end
  end

  primos.each_index.select { |i| primos[i] }
end

if __FILE__ == $0
  puts "Ingrese la cantidad:"
  n = gets.to_i

  lista_primos = nil
  reporte_memoria = nil

  tiempo = Benchmark.measure do
    reporte_memoria = MemoryProfiler.report do
      lista_primos = criba_eratostenes(n)
    end
  end

  puts "\nPrimos hasta #{n}: #{lista_primos.size} encontrados"
  puts "Lista de primos:"
  puts lista_primos.join(", ")

  puts "\n⏱ Tiempo de ejecución: #{tiempo.real.round(6)} segundos"

  puts "\n💾 Reporte de uso de memoria:"
  puts "Total allocated: #{reporte_memoria.total_allocated_memsize} bytes (#{reporte_memoria.total_allocated} objects)"
  puts "Total retained:  #{reporte_memoria.total_retained_memsize} bytes (#{reporte_memoria.total_retained} objects)"
end
