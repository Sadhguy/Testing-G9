# frozen_string_literal: true

require './Tablero'
require './Barco'

# Clase que modela al Jugador del juego
class Jugador # rubocop:disable Metrics/ClassLength
  attr_accessor :nombre, :tablero, :tablero_privado, :barcos, :cant_barcos, :largo_barcos

  def initialize(dif, nombre)
    difs = [7, 14, 21]
    barcs = [2, 3, 5, 6, 4, 7, 1, 9, 3]
    @nombre = nombre
    @lado = difs[dif.to_i - 1]
    @tablero = Tablero.new(@lado)
    @tablero_privado = Tablero.new(@lado)
    @cant_barcos = 1 #3 * difs[dif.to_i - 1] / 7
    @largo_barcos = barcs.take(@cant_barcos)
    inicializar_barcos
  end

  def inicializar_barcos
    barcos = []
    @largo_barcos.each { |l| barcos.push(Barco.new(l)) }
    @barcos = barcos
  end

  def colocar_barcos_ia(colocados) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      randcol = ('A'..'Z').to_a
      randc = rand(@lado - @barcos[colocados].largo - 1)
      randfil = rand(0..(@lado - @barcos[colocados].largo))
      randy = rand(2)
      cas = if randy == 0 # rubocop:disable Style/NumericPredicate
              randcol[randc] + randfil.to_s + randcol[randc] + \
                (randfil + @barcos[colocados].largo - 1).to_s
            else
              randcol[randc] + randfil.to_s + \
                randcol[randc + @barcos[colocados].largo - 1] + randfil.to_s
            end
      return cas
  end

  def rectificar_tableros
    (1..@lado).each do |f|
      (1..(@lado - 1)).each do |c|
        @tablero.casillas[f][c] = @tablero_privado.casillas[f][c] if @tablero_privado.casillas[f][c] != '#'
      end
    end
  end

  #def obtener_tablero
  #  puts "**********\nTablero de #{@nombre}**********"
  #  @tablero.print_tablero
  #end

  ##def disparar(jugador)
  ##  puts 'Inserte casilla a disparar (Ej: A0):'
  ##  cas = gets
  ##  respuesta = jugador.tablero_privado.revisar_casilla(cas[1], cas[0])
  ##  if respuesta[0]
  ##    jugador.rectificar_tableros
  ##    jugador.actualizar_barcos(respuesta[1][0], respuesta[1][1])
  ##    true
  ##  else
  ##    false
  ##  end
  ##end

  def disparar_ia(jugador) # rubocop:disable Metrics/AbcSize
    randcol = ('A'..'Z').to_a
    randc = rand(@lado)
    randfil = rand(@lado)
    cas = randcol[randc] + randfil.to_s
    return cas
  end

  def actualizar_barcos(fil, col)
    @barcos.each { |b| b.revisar_disparo(fil, col) }
  end
end
