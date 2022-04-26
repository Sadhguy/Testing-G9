# frozen_string_literal: true

require './tablero'
require './barco'

# Clase que modela al Jugador del juego
class Jugador # rubocop:disable Metrics/ClassLength
  attr_accessor :nombre, :tablero, :tablero_privado, :barcos, :cant_barcos

  def initialize(dif, nombre)
    difs = [7, 14, 21]
    barcs = [2, 3, 5, 6, 4, 7, 1, 9, 3]
    @nombre = nombre
    @lado = difs[dif.to_i - 1]
    @tablero = Tablero.new(@lado)
    @tablero_privado = Tablero.new(@lado)
    @cant_barcos = 3 * difs[dif.to_i - 1] / 7
    @largo_barcos = barcs.take(@cant_barcos)
    inicializar_barcos
  end

  def inicializar_barcos
    barcos = []
    @largo_barcos.each { |l| barcos.push(Barco.new(l)) }
    @barcos = barcos
  end

  def colocar_barcos # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    puts "**********\nTurno de #{nombre}**********"
    colocados = 0
    @tablero_privado.print_tablero
    while colocados < @cant_barcos
      puts "Barco #{colocados} => largo #{@largo_barcos[colocados]}"
      puts 'Desde y hasta qué casilla quieres poner este barco (Ej: A2A5):'
      cas = gets
      cas_norm = normalizar_coordenadas_barcos(cas)
      respuesta = @tablero_privado.revisar_para_barcos(cas_norm[0], cas_norm[1], cas_norm[2], cas_norm[3], \
                                                       @barcos[colocados].largo)
      if respuesta[0] == true
        @tablero_privado.print_tablero
        @barcos[colocados].casillas = respuesta[1]
        colocados += 1
      else
        case respuesta[1]
        when 0
          puts 'Casilla invalida'
        when 1
          puts 'No es posible colocar el barco en esa posición'
        when 2
          puts 'No puedes colocar los barcos de forma diagonal'
        end
        puts 'Prueba nuevamente'
      end
    end
  end

  def colocar_barcos_ia # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    puts "**********\nTurno de IA\n**********"
    puts "**********\nMe llamo inteligencia artificial pero soy bastante tontx\n**********"
    colocados = 0
    @tablero_privado.print_tablero
    while colocados < @cant_barcos
      puts "Barco #{colocados} => largo #{@largo_barcos[colocados]}"
      puts 'Desde y hasta qué casilla quieres poner este barco (Ej: A2A5):'
      cas = random_coodinates(colocados)
      cas_norm = normalizar_coordenadas_barcos(cas)
      respuesta = @tablero_privado.revisar_para_barcos(cas_norm[0], cas_norm[1], cas_norm[2], cas_norm[3],
                                                       @barcos[colocados].largo)
      if respuesta[0] == true
        @tablero_privado.print_tablero
        @barcos[colocados].casillas = respuesta[1]
        colocados += 1
      else
        puts 'Prueba nuevamente'
      end
    end
  end

  def random_coodinates(colocados) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    randcol = ('A'..'Z').to_a
    randc = rand(@lado + @barcos[colocados].largo - 1)
    randfil = rand(0..(@lado - @barcos[colocados].largo))
    randy = rand(2)
    if randy == 0 # rubocop:disable Style/NumericPredicate
      randcol[randc] + randfil.to_s + randcol[randc] + \
        (randfil + @barcos[colocados].largo - 1).to_s
    else
      randcol[randc] + randfil.to_s + \
        randcol[randc + @barcos[colocados].largo - 1] + randfil.to_s
    end
  end

  def rectificar_tableros
    (1..@lado).each do |f|
      (1..(@lado - 1)).each do |c|
        @tablero.casillas[f][c] = @tablero_privado.casillas[f][c] if @tablero_privado.casillas[f][c] != '#'
      end
    end
  end

  def obtener_tablero
    puts "**********\nTablero de #{@nombre}**********"
    @tablero.print_tablero
  end

  def disparar(jugador) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    puts 'Inserte casilla a disparar (Ej: A0):'
    cas = gets
    cas_norm = normalizar_coordenadas_disparo(cas)
    respuesta = jugador.tablero_privado.revisar_casilla(cas_norm[0], cas_norm[1])
    if respuesta[0]
      jugador.rectificar_tableros
      jugador.actualizar_barcos(respuesta[1][0], respuesta[1][1])
      case respuesta[2]
      when 0
        puts '**********AGUA!**********'
      when 1
        puts '**********FUEGO!**********'
      end
      true
    else
      puts 'Casilla no disponible'
      false
    end
  end

  def disparar_ia(jugador) # rubocop:disable  Metrics/MethodLength, Metrics/AbcSize
    puts 'Inserte casilla a disparar (Ej: A0):'
    cas = coordenada_de_disparo
    cas_norm = normalizar_coordenadas_disparo(cas)
    respuesta = jugador.tablero_privado.revisar_casilla(cas_norm[0], cas_norm[1])
    puts 'Casilla no disponible' if respuesta[0] == false
    return unless respuesta[0]

    case respuesta[2]
    when 0
      puts '**********AGUA!**********'
    when 1
      puts '**********FUEGO!**********'
    end
    jugador.rectificar_tableros
    jugador.actualizar_barcos(respuesta[1][0], respuesta[1][1])
    true
  end

  def coordenada_de_disparo
    randcol = ('A'..'Z').to_a
    randc = rand(@lado)
    randfil = rand(@lado)
    randcol[randc] + randfil.to_s
  end

  def actualizar_barcos(fil, col)
    @barcos.each do |b|
      hundido = b.revisar_disparo(fil, col)
      puts '**********BARCO HUNDIDO!**********' if hundido == true
    end
  end

  def normalizar_coordenadas_disparo(coords)
    fil = ''
    col = ''
    coords.each_char do |c|
      if '0123456789'.include? c
        fil += c
      elsif 'abcdefghijklmnopqrstuvwxyz'.include? c.downcase
        col = c
      end
    end
    [fil, col]
  end

  def normalizar_coordenadas_barcos(coords) # rubocop:disable Metrics/MethodLength
    fil1 = ''
    fil2 = ''
    col1 = ''
    col2 = ''
    ind = 0
    puts coords
    coords.each_char do |c|
      if '0123456789'.include? c
        if ind == 1
          fil1 += c
        else
          fil2 += c
        end
      elsif 'abcdefghijklmnopqrstuvwxyz'.include? c.downcase
        if ind.zero?
          col1 = c
        else
          col2 = c
        end
        ind += 1
      end
    end
    puts "FIL1 => #{fil1}"
    puts "COL1 => #{col1}"
    puts "FIL2 => #{fil2}"
    puts "COL2 => #{col2}"
    [col1, fil1, col2, fil2]
  end
end
