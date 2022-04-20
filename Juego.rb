require './Tablero.rb'
require './Jugador.rb'

class Juego
    attr_accessor :jugador1
    attr_accessor :jugador2
    attr_accessor :vivo

    def initialize(dif, jug1, jug2)
        @jugador1 = Jugador.new(dif, jug1)
        @jugador2 = Jugador.new(dif, jug2)
        @turno = @jugador1
        @noturno = @jugador2
        @vivo = true
    end

    def turno
        puts "**********\nTurno de "+@turno.nombre+"**********"
        breaker = true
        while breaker
            if @turno.disparar(@noturno)
                breaker = false
            end
        end
        revisar_jugador
        if self.vivo
            @noturno.get_tablero
            terminar_turno
        end
    end

    def terminar_turno
        if @turno == @jugador1
            @turno = @jugador2
            @noturno = @jugador1
        else
            @turno = @jugador1
            @noturno = @jugador2
        end
    end

    def revisar_jugador
        h = 0
        for b in @noturno.barcos
            if !b.vivo
                h += 1
            end
        end
        if h == @noturno.cant_barcos
            terminar_juego
        end
    end

    def terminar_juego
        puts "**********El juego a terminado**********"
        puts "********El ganador es #{@turno.nombre}!********"
        @vivo = false
    end
end