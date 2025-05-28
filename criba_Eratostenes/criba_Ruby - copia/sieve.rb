require 'benchmark'
require 'memory_profiler'

class EratosthenesSieve
  attr_reader :limit, :primes

  def initialize(limit)
    @limit = limit
    @primes = []
  end

  def run
    sieve = Array.new(@limit + 1, true)
    sieve[0] = sieve[1] = false

    (2..Math.sqrt(@limit)).each do |i|
      next unless sieve[i]
      (i*i).step(@limit, i) { |j| sieve[j] = false }
    end

    @primes = sieve.each_index.select { |i| sieve[i] }
  end
end

class SieveRunner
  def self.execute
    puts "Ingrese la cantidad:"
    n = gets.to_i

    sieve = EratosthenesSieve.new(n)
    memory_report = nil

    time = Benchmark.measure do
      memory_report = MemoryProfiler.report { sieve.run }
    end

    puts "\n🔢 Primos hasta #{n}: #{sieve.primes.size} encontrados"
    puts sieve.primes.join(', ')
    puts "\n⏱ Tiempo de ejecución: #{time.real.round(6)} segundos"
    puts "\n💾 Reporte de uso de memoria:"
    puts "Total allocated: #{memory_report.total_allocated_memsize} bytes (#{memory_report.total_allocated} objects)"
    puts "Total retained:  #{memory_report.total_retained_memsize} bytes (#{memory_report.total_retained} objects)"
  end
end

SieveRunner.execute if __FILE__ == $0
