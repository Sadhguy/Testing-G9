# frozen_string_literal: true

# Clase que modela el tablero
class Tablero
  attr_accessor :casillas, :lado, :letras

  def initialize(lado)
    @lado = lado
    @letras = %w[A B C D E F G H I J K L M
                 N O P Q R S T U V W X Y Z]
    @casillas = crear_tablero
  end

  def crear_tablero # rubocop:disable Metrics/MethodLength
    tablero = []
    cont = 0
    let = @letras.take(@lado)
    tablero.push(let)
    (1..@lado).each do |_f|
      fil = []
      (0..(@lado - 1)).each do |c|
        fil.push(cont) if c == 0 # rubocop:disable Style/NumericPredicate
        fil.push(0)
      end
      cont += 1
      tablero.push(fil)
    end
    tablero
  end

  def print_tablero
    (0..@lado).each do |f|
      p @casillas[f]
    end
  end

  def pintar_casilla(fil, col, ind)
    case ind
    when 1
      @casillas[fil][col] = 'X'
    when 2
      @casillas[fil][col] = 'o'
    when 3
      @casillas[fil][col] = '#'
    end
  end

  def revisar_casilla(fil, col) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    f = fil.to_i
    return unless (@letras.include? col.upcase) && ((0..(@lado - 1)).include? f)

    c = @letras.find_index(col.upcase)
    case @casillas[f + 1][c + 1]
    when 0
      pintar_casilla(f + 1, c + 1, 2)
      [true, [f + 1, c + 1], 0]
    when '#'
      pintar_casilla(f + 1, c + 1, 1)
      [true, [f + 1, c + 1], 1]
    else
      [false]
    end
  end

  def revisar_para_barcos(col1, fil1, col2, fil2, largo) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    fil1 = fil1.to_i
    fil2 = fil2.to_i
    col1 = @letras.find_index(col1.upcase)
    col2 = @letras.find_index(col2.upcase)
    tablero_provisional = self
    if !((0..(@lado - 1)).include?  col1) || !((0..(@lado - 1)).include? fil1) || \
       !((0..(@lado - 1)).include?  col2) || !((0..(@lado - 1)).include? fil2)
      return [false, 0]
    end

    if col1 == col2
      fils = 0
      cas = []
      (0..(largo - 1)).each do |i|
        return [false, 1] unless (@casillas[fil1 + 1 + i][col1 + 1]) == 0 # rubocop:disable Style/NumericPredicate

        fils += 1
        tablero_provisional.pintar_casilla(fil1 + 1 + i, col1 + 1, 3)
        cas.push([fil1 + 1 + i, col1 + 1])
      end
      if fils == largo
        @casillas = tablero_provisional.casillas
        [true, cas]
      else
        [false, 1]
      end
    elsif fil1 == fil2
      cols = 0
      cas = []
      (0..(largo - 1)).each do |i|
        return [false, 1] unless (@casillas[fil1 + 1][col1 + 1 + i]) == 0 # rubocop:disable Style/NumericPredicate

        cols += 1
        tablero_provisional.pintar_casilla(fil1 + 1, col1 + 1 + i, 3)
        cas.push([fil1 + 1, col1 + 1 + i])
      end
      if cols == largo
        @casillas = tablero_provisional.casillas
        [true, cas]
      else
        [false, 1]
      end
    else
      [false, 2]
    end
  end
end
