# frozen_string_literal: true

require './Tablero'
require './Jugador'

class Juego
  attr_accessor :jugador1, :jugador2, :vivo

  def initialize(dif, jug1, jug2, mod)
    @jugador1 = Jugador.new(dif, jug1)
    @jugador2 = Jugador.new(dif, jug2)
    @turno = @jugador1
    @noturno = @jugador2
    @vivo = true
    @mod = mod
  end

  def turno
    puts "**********\nTurno de #{@turno.nombre}**********"
    breaker = true
    while breaker
      if @mod == 2 && @turno == @jugador2
        breaker = false if @turno.disparar_IA(@noturno)
      elsif @turno.disparar(@noturno)
        breaker = false
      end
    end
    revisar_jugador
    if vivo
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
    @noturno.barcos.each do |b|
      h += 1 unless b.vivo
    end
    terminar_juego if h == @noturno.cant_barcos
  end

  def terminar_juego
    puts '**********El juego a terminado**********'
    puts "********El ganador es #{@turno.nombre}!********"
    @vivo = false
  end
end
