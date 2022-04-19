require './Tablero.rb'

if __FILE__ == $0
    difs = [7, 14, 21]
    puts "Elige una dificultad (1, 2 ó 3):"
    dif = gets
    tablero = Tablero.new
    tablero.lado = difs[dif.to_i()-1]
    tablero.crear_tablero
    tablero.print_tablero
end