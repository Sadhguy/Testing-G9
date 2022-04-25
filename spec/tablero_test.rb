# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require './tablero'

lado = 7

casillas = [
  %w[A B C D E F G],
  ['0', 0, 0, 0, 0, 0, 0, 0],
  ['1', '#', '#', '#', '#', 0, 0, 0],
  ['2', 0, 0, 0, 0, 0, 0, 0],
  ['3', 0, 0, 0, 0, 0, 0, 0],
  ['4', 0, 0, 0, 0, 0, 0, 0],
  ['5', 0, 0, 0, '#', '#', '#', 0],
  ['6', 0, 0, 0, 0, 0, 0, 0]
]

secuencia_disparo_acertado = '**********FUEGO!**********
'

secuencia_disparo_erroneo = '**********AGUA!**********
'

secuencia_de_inputs = %w[A0A8 A0A2 A0A2 B0B2 C0C4]

secuencia_largos_barcos = [9, 3, 3, 3, 5]
total_inputs = 5

secuencia_de_checkeo = 'Casilla invalida
No es posible colocar el barco en esa posición
'

describe Tablero do # rubocop:disable Metrics/BlockLength
  context 'Probando la inicialiazción del tablero' do
    it 'should match Tablero attributes' do
      tablero = Tablero.new(lado)
      expect(tablero.lado).to eq lado
    end
  end

  context 'Probando la creación del tablero' do
    it 'should create Tablero' do
      tablero = Tablero.new(lado)
      tablero.crear_tablero
      (1..(tablero.lado)).each do |y|
        (1..(tablero.lado)).each do |x|
          expect(tablero.casillas[y][x]).to eq 0
        end
      end
    end
  end

  context 'Probando la asignación de letras del tablero' do
    it 'should match Tablero letters' do
      tablero = Tablero.new(lado)
      tablero.crear_tablero
      (0..(tablero.lado - 1)).each do |y|
        expect(tablero.casillas[0][y]).to eq tablero.letras[y]
      end
    end
  end

  context 'Probando la asignación de eventos en el tablero' do
    it 'should match Tablero event' do
      tablero = Tablero.new(lado)
      tablero.crear_tablero
      tablero.pintar_casilla(1, 1, 1)
      tablero.pintar_casilla(2, 2, 2)
      tablero.pintar_casilla(3, 3, 3)
      expect(tablero.casillas[1][1]).to eq 'X'
      expect(tablero.casillas[2][2]).to eq 'o'
      expect(tablero.casillas[3][3]).to eq '#'
    end
  end

  context 'Probando los outputs de eventos en el tablero' do
    it 'should match Tablero output' do
      tablero = Tablero.new(7)
      tablero.casillas = casillas
      (1..(tablero.lado)).each do |x|
        (0..(tablero.lado - 1)).each do |y|
          if tablero.casillas[x][y + 1] == 0
            expect do
              tablero.revisar_casilla(tablero.casillas[x][0], tablero.casillas[0][y])
            end.to output(secuencia_disparo_erroneo).to_stdout
          end
          next unless tablero.casillas[x][y + 1] == '#'

          expect do
            tablero.revisar_casilla(tablero.casillas[x][0], tablero.casillas[0][y])
          end.to output(secuencia_disparo_acertado).to_stdout
        end
      end
    end
  end

  context 'Probando la posibilidad de colocación de barco' do
    it 'should check if possible' do
      tablero = Tablero.new(lado)
      expect do
        (0..(total_inputs - 1)).each do |i|
          tablero.revisar_para_barcos(
            secuencia_de_inputs[i][0],
            secuencia_de_inputs[i][1],
            secuencia_de_inputs[i][2],
            secuencia_de_inputs[i][3],
            secuencia_largos_barcos[i]
          )
        end
      end.to output(secuencia_de_checkeo).to_stdout
    end
  end
end
