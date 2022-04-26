# frozen_string_literal: true

require 'simplecov'

SimpleCov.profiles.define 'only_jugador_coverage' do
  add_filter 'barco' # Don't include barco stuff
  add_filter 'tablero' # Don't include tablero stuff
end

SimpleCov.start 'only_jugador_coverage'

require './jugador'
require './tablero'

dif = 1
nombre = 'Juan'
casillas = [%w[A B C D E F G], [0, 0, 0, 0, 0, 0, 0, 0], [1, 0, 0, 0, 0, 0, 0, 0],
            [2, 0, 0, 0, 0, 0, 0, 0], [3, 0, 0, 0, 0, 0, 0, 0], [4, 0, 0, 0, 0, 0, 0, 0],
            [5, 0, 0, 0, 0, 0, 0, 0], [6, 0, 0, 0, 0, 0, 0, 0]]
largo1 = 2
largo2 = 3
largo3 = 5

secuencia_colocacion = '**********
Turno de Juan**********
'

secuencia_colocacion_ia = '**********
Turno de IA
**********
**********
Me llamo inteligencia artificial pero soy bastante tontx
**********
'

secuencia_obtencion_tablero = '**********
Tablero de Juan**********
'

secuencia_agua = '**********AGUA!**********
'

secuencia_fuego = '**********FUEGO!**********
'

secuencia_reintente = 'Inserte casilla a disparar (Ej: A0):
Casilla no disponible
'

describe Jugador do # rubocop:disable Metrics/BlockLength
  context 'Probando la creación de jugador' do
    it 'should match Jugador attributes' do
      jugador = Jugador.new(dif, nombre)
      expect(jugador.nombre).to eq nombre
      expect(jugador.tablero.casillas).to eq casillas
    end
  end

  context 'Probando la inicialización de barcos' do
    it 'should initialize all Barcos' do
      jugador_barcos = Jugador.new(dif, nombre)
      jugador_barcos.inicializar_barcos
      expect(jugador_barcos.barcos[0].largo).to eq largo1
      expect(jugador_barcos.barcos[1].largo).to eq largo2
      expect(jugador_barcos.barcos[2].largo).to eq largo3
    end
  end

  context 'Probando la colocación de barcos' do
    it 'should place all Barcos' do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('A0A2', 'invalido', 'B0D2', 'A0A2', 'B0B2', 'C0C4')
      jugador_colocar_barcos = Jugador.new(dif, nombre)
      expect do
        jugador_colocar_barcos.colocar_barcos
      end.to output(a_string_including(secuencia_colocacion)).to_stdout
    end
  end

  context 'Probando la colocación de barcos de ia' do
    it 'should place all ia Barcos' do
      jugador_ia_colocar_barcos = Jugador.new(dif, nombre)
      expect do
        jugador_ia_colocar_barcos.colocar_barcos_ia
      end.to output(a_string_including(secuencia_colocacion_ia)).to_stdout
    end
  end

  context 'Probando la rectificación de tablero' do
    it 'should rectify Tablero' do
      jugador_rectificar_tablero = Jugador.new(dif, nombre)
      jugador_rectificar_tablero2 = jugador_rectificar_tablero
      (1..7).each do |f|
        (1..(7 - 1)).each do |c|
          if jugador_rectificar_tablero.tablero_privado.casillas[f][c] != '#'
            jugador_rectificar_tablero.tablero.casillas[f][c] =
              jugador_rectificar_tablero.tablero_privado.casillas[f][c]
          end
        end
      end
      jugador_rectificar_tablero2.rectificar_tableros
      expect(jugador_rectificar_tablero.tablero_privado).to eq jugador_rectificar_tablero2.tablero_privado
    end
  end

  context 'Probando la obtención de tablero' do
    it 'should obtain Tablero' do
      jugador_obtener_tablero = Jugador.new(dif, nombre)
      jugador_obtener_tablero.obtener_tablero
      expect do
        jugador_obtener_tablero.obtener_tablero
      end.to output(a_string_including(secuencia_obtencion_tablero)).to_stdout
    end
  end

  context 'Probando los disparos de jugador' do
    it 'should test disparar' do
      jugador_disparar = Jugador.new(dif, nombre)
      jugador_disparado = Jugador.new(dif, nombre)
      allow_any_instance_of(Kernel).to receive(:gets).and_return('A0A2', 'B0B2', 'C0C4')
      jugador_disparado.colocar_barcos
      allow_any_instance_of(Kernel).to receive(:gets).and_return('A0')
      allow_any_instance_of(Tablero).to receive(:revisar_casilla).and_return([false, 0, 0, 0])
      expect do
        jugador_disparar.disparar(jugador_disparado)
      end.to output(a_string_including(secuencia_reintente)).to_stdout
      allow_any_instance_of(Tablero).to receive(:revisar_casilla).and_return([true, 0, 0, 1])
      expect do
        jugador_disparar.disparar(jugador_disparado)
      end.to output(a_string_including(secuencia_fuego)).to_stdout
      allow_any_instance_of(Kernel).to receive(:gets).and_return('A6')
      allow_any_instance_of(Tablero).to receive(:revisar_casilla).and_return([true, 0, 0, 0])
      expect do
        jugador_disparar.disparar(jugador_disparado)
      end.to output(a_string_including(secuencia_agua)).to_stdout
    end
  end

  context 'Probando los disparos de jugador ia' do
    it 'should test disparar_ia' do
      jugador_disparar_ia = Jugador.new(dif, nombre)
      jugador_disparado_ia = Jugador.new(dif, nombre)
      allow_any_instance_of(Kernel).to receive(:gets).and_return('A0A2', 'B0B2', 'C0C4')
      jugador_disparado_ia.colocar_barcos
      allow_any_instance_of(Tablero).to receive(:revisar_casilla).and_return([true, 0, 0, 0])
      expect do
        jugador_disparar_ia.disparar_ia(jugador_disparado_ia)
      end.to output(a_string_including(secuencia_agua)).to_stdout
      allow_any_instance_of(Tablero).to receive(:revisar_casilla).and_return([true, 0, 0, 1])
      expect do
        jugador_disparar_ia.disparar_ia(jugador_disparado_ia)
      end.to output(a_string_including(secuencia_fuego)).to_stdout
    end
  end
end
