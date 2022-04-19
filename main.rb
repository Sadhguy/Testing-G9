require './Tablero.rb'
require './Juego.rb'

if __FILE__ == $0
    puts "Nombre jugador 1:"
    jug1 = gets
    puts "Nombre jugador 2:"
    jug2 = gets
    puts "Elige una dificultad (1, 2 ó 3):"
    dif = gets
    juego = Juego.new(dif, jug1, jug2)
    while juego.vivo
        juego.turno
    end
end