# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

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
["A", "B", "C", "D", "E", "F", "G"]
[0, 0, 0, 0, 0, 0, 0, 0]
[1, 0, 0, 0, 0, 0, 0, 0]
[2, 0, 0, 0, 0, 0, 0, 0]
[3, 0, 0, 0, 0, 0, 0, 0]
[4, 0, 0, 0, 0, 0, 0, 0]
[5, 0, 0, 0, 0, 0, 0, 0]
[6, 0, 0, 0, 0, 0, 0, 0]
Barco 0 => largo 2
Desde y hasta qué casilla quieres poner este barco (Ej: A2A5):
["A", "B", "C", "D", "E", "F", "G"]
[0, "#", 0, 0, 0, 0, 0, 0]
[1, "#", 0, 0, 0, 0, 0, 0]
[2, 0, 0, 0, 0, 0, 0, 0]
[3, 0, 0, 0, 0, 0, 0, 0]
[4, 0, 0, 0, 0, 0, 0, 0]
[5, 0, 0, 0, 0, 0, 0, 0]
[6, 0, 0, 0, 0, 0, 0, 0]
Barco 1 => largo 3
Desde y hasta qué casilla quieres poner este barco (Ej: A2A5):
No es posible colocar el barco en esa posición
Prueba nuevamente
Barco 1 => largo 3
Desde y hasta qué casilla quieres poner este barco (Ej: A2A5):
["A", "B", "C", "D", "E", "F", "G"]
[0, "#", "#", 0, 0, 0, 0, 0]
[1, "#", "#", 0, 0, 0, 0, 0]
[2, 0, "#", 0, 0, 0, 0, 0]
[3, 0, 0, 0, 0, 0, 0, 0]
[4, 0, 0, 0, 0, 0, 0, 0]
[5, 0, 0, 0, 0, 0, 0, 0]
[6, 0, 0, 0, 0, 0, 0, 0]
Barco 2 => largo 5
Desde y hasta qué casilla quieres poner este barco (Ej: A2A5):
["A", "B", "C", "D", "E", "F", "G"]
[0, "#", "#", "#", 0, 0, 0, 0]
[1, "#", "#", "#", 0, 0, 0, 0]
[2, 0, "#", "#", 0, 0, 0, 0]
[3, 0, 0, "#", 0, 0, 0, 0]
[4, 0, 0, "#", 0, 0, 0, 0]
[5, 0, 0, 0, 0, 0, 0, 0]
[6, 0, 0, 0, 0, 0, 0, 0]
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

secuencia_disparo_acertado = '**********FUEGO!**********
'

secuencia_disparo_erroneo = '**********AGUA!**********
'

secuencia_no_disponible = 'Casilla no disponible
'

secuencia_disparo = '**********
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
      allow_any_instance_of(Kernel).to receive(:gets).and_return('A0A2', 'A0A2', 'B0B2', 'C0C4')
      jugador_colocar_barcos = Jugador.new(dif, nombre)
      expect do
        jugador_colocar_barcos.colocar_barcos
      end.to output(secuencia_colocacion).to_stdout
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
      expect do
        jugador_disparar.disparar(jugador_disparado)
      end.to output(a_string_including(secuencia_disparo_acertado)).to_stdout
      allow_any_instance_of(Kernel).to receive(:gets).and_return('A6')
      expect do
        jugador_disparar.disparar(jugador_disparado)
      end.to output(a_string_including(secuencia_disparo_erroneo)).to_stdout
      expect do
        jugador_disparar.disparar(jugador_disparado)
      end.to output(a_string_including(secuencia_no_disponible)).to_stdout
    end
  end

  context 'Probando los disparos de jugador ia' do
    it 'should test disparar_ia' do
      jugador_disparar_ia = Jugador.new(dif, nombre)
      jugador_disparado_ia = Jugador.new(dif, nombre)
      allow_any_instance_of(Kernel).to receive(:gets).and_return('A0A2', 'B0B2', 'C0C4')
      jugador_disparado_ia.colocar_barcos
      expect do
        jugador_disparar_ia.disparar_ia(jugador_disparado_ia)
      end.to output(a_string_including(secuencia_disparo)).to_stdout
    end
  end
end
