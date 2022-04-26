# frozen_string_literal: true

require './tablero'
require './juego'

if __FILE__ == $PROGRAM_NAME
  puts 'Nombre jugador 1:'
  jug1 = gets
  mod = 3
  while mod == 3
    puts 'Jugar contra IA (S ó N):'
    ia = gets
    case ia.upcase
    when "S\n"
      jug2 = "IA\n"
      mod = 2
    when "N\n"
      puts 'Nombre jugador 2:'
      jug2 = gets
      mod = 1
    end
  end
  puts 'Elige una dificultad (1, 2 ó 3):'
  dif = gets
  juego = Juego.new(dif, jug1, jug2, mod)
  juego.jugador1.colocar_barcos
  if mod == 2
    juego.jugador2.colocar_barcos_ia
  else
    juego.jugador2.colocar_barcos
  end
  juego.turno while juego.vivo
  exit
end
