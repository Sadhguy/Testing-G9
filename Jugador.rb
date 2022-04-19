require './Tablero.rb'
class Jugador
    attr_accessor :nombre
    attr_accessor :tablero

    def initialize(dif, nombre)
        difs = [7, 14, 21]
        @nombre = nombre
        @tablero = Tablero.new(difs[dif.to_i()-1])
        @barcos = difs[dif.to_i()-1] - 2
    end

    def get_tablero
        puts "**********\nTablero de "+@nombre+"**********"
        @tablero.print_tablero
    end

    def disparar(jugador)
        puts "Inserte casilla a disparar (Ej: A0):"
        cas = gets
        if jugador.tablero.revisar_casilla(cas[0], cas[1]) == 1
            return true
        end
    end

end