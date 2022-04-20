require './Tablero.rb'
require './Juego.rb'

if __FILE__ == $0
    puts "Nombre jugador 1:"
    jug1 = gets
    puts "Jugar contra IA (S ó N):"
    ia = gets
    if ia.upcase == "S\n"
        jug2 = "IA\n"
        mod = 2
    else
        puts "Nombre jugador 2:"
        jug2 = gets
        mod = 1
    end
    puts "Elige una dificultad (1, 2 ó 3):"
    dif = gets
    juego = Juego.new(dif, jug1, jug2, mod)
    juego.jugador1.colocar_barcos
    if mod == 2
        juego.jugador2.colocar_barcos_IA
    else
        juego.jugador2.colocar_barcos
    end
    while juego.vivo
        juego.turno
    end
    exit
end
