# Requiere la biblioteca estándar 'benchmark' para medir el tiempo de ejecución
require 'benchmark'

# Requiere la biblioteca 'memory_profiler' para analizar el uso de memoria del programa
require 'memory_profiler'

# Clase que encapsula la lógica del algoritmo de la Criba de Eratóstenes
class EratosthenesSieve
  # Permite acceder a @limit y @primes desde fuera de la clase
  attr_reader :limit, :primes

  # Constructor que recibe el límite superior n y prepara la estructura para almacenar los primos
  def initialize(limit)
    @limit = limit        # Valor máximo hasta el cual se buscarán números primos
    @primes = []          # Lista donde se almacenarán los números primos encontrados
  end

  # Método principal que ejecuta la Criba de Eratóstenes
  def run
    # Inicializa un arreglo booleano de tamaño (limit + 1), marcando inicialmente todos los números como primos (true)
    sieve = Array.new(@limit + 1, true)
    sieve[0] = sieve[1] = false  # 0 y 1 no son primos

    # Itera desde 2 hasta la raíz cuadrada del límite
    (2..Math.sqrt(@limit)).each do |i|
      next unless sieve[i]  # Si ya fue marcado como no primo, se salta
      # Marca como no primos todos los múltiplos de i, comenzando en i^2
      (i*i).step(@limit, i) { |j| sieve[j] = false }
    end

    # Extrae los índices (números) que siguen marcados como true, es decir, los que son primos
    @primes = sieve.each_index.select { |i| sieve[i] }
  end
end

# Clase que gestiona la ejecución del algoritmo y las métricas de rendimiento
class SieveRunner
  # Método de clase que ejecuta todo el flujo: entrada, procesamiento, y salida
  def self.execute
    puts "Ingrese la cantidad:"          # Solicita el límite superior al usuario
    n = gets.to_i                        # Lee y convierte la entrada a entero

    # Validación adicional: se asegura que el número sea al menos 2 (ya que no hay primos menores a 2)
    if n < 2
      puts "⚠️  Error: Ingrese un número entero mayor o igual a 2 para ejecutar la criba."
      return                             # Sale del método si el número no es válido
    end

    sieve = EratosthenesSieve.new(n)     # Instancia del algoritmo con el valor ingresado
    memory_report = nil                  # Variable para almacenar el reporte de memoria

    # Mide el tiempo de ejecución y genera el reporte de uso de memoria
    time = Benchmark.measure do
      memory_report = MemoryProfiler.report { sieve.run }
    end

    # Muestra resultados al usuario
    puts "\n🔢 Primos hasta #{n}: #{sieve.primes.size} encontrados"
    puts sieve.primes.join(', ')  # Imprime todos los primos separados por coma

    # Muestra métricas de rendimiento
    puts "\n⏱ Tiempo de ejecución: #{time.real.round(6)} segundos"

    # Muestra el reporte de uso de memoria (resumen simple)
    puts "\n💾 Reporte de uso de memoria:"
    puts "Total allocated: #{memory_report.total_allocated_memsize} bytes (#{memory_report.total_allocated} objects)"
    puts "Total retained:  #{memory_report.total_retained_memsize} bytes (#{memory_report.total_retained} objects)"
  end
end

# Ejecuta el programa solo si se está ejecutando directamente (no si es importado como módulo)
SieveRunner.execute if __FILE__ == $0
