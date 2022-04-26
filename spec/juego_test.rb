# frozen_string_literal: true

require 'simplecov'

SimpleCov.profiles.define 'only_juego_coverage' do
  add_filter 'barco' # Don't include barco stuff
  add_filter 'jugador' # Don't include jugador stuff
  add_filter 'tablero' # Don't include tablero stuff
end

SimpleCov.start 'only_juego_coverage'

require './juego'

dif = 1
jug_1 = 'Juan'
jug_2 = 'Jose'
mod_1 = 1
mod_2 = 2
 

describe Juego do # rubocop:disable Metrics/BlockLength
  context 'Probando la creación de juego' do
    it 'should match Juego attributes' do
      #barco = Barco.new(largo)
      allow(Jugador).to receive(:new).with(any_args) {|*args| args }
      juego = Juego.new(dif, jug_1, jug_2, mod_1)
      #expect(barco.largo).to eq largo
      #expect
      expect(juego.jugador1).to eq ([1, 'Juan'])
      expect(juego.jugador2).to eq ([1, 'Jose'])
      expect(juego.vivo).to eq true
    end
  end

  context 'Probando el turno de un juego contra la ia' do
    it 'should work as juego.turno' do
      allow_any_instance_of(Jugador).to receive(:disparar).and_return('disparando')
      juego_ia = Juego.new(dif, jug_1, jug_2, mod_1)
      juego_ia.turno
      expect(juego_ia.noturno).to eq juego_ia.jugador1
    end
  end

  context 'Probando el turno de un juego contra otro oponente' do
    it 'should work as juego.turno' do
      allow_any_instance_of(Jugador).to receive(:disparar).and_return('disparando')
      allow_any_instance_of(Jugador).to receive(:disparar_ia).and_return('disparando')
      juego_op = Juego.new(dif, jug_1, jug_2, mod_2)
      juego_op.terminar_turno
      juego_op.turno
      expect(juego_op.noturno).to eq juego_op.jugador2
    end
  end

  context 'Probando la funcion terminar_turno' do
    it 'should end turno' do
      allow(Jugador).to receive(:new).with(any_args) {|*args| args }
      juego_terminar_turno = Juego.new(dif, jug_1, jug_2, mod_1)
      juego_terminar_turno.terminar_turno
      expect(juego_terminar_turno.noturno).to eq juego_terminar_turno.jugador1
      juego_terminar_turno.terminar_turno
      expect(juego_terminar_turno.noturno).to eq juego_terminar_turno.jugador2
    end
  end

  context 'Probando la funcion revisar_jugador' do
    it 'should check jugador' do
      juego_revisar_jugador = Juego.new(dif, jug_1, jug_2, mod_1)
      juego_revisar_jugador.noturno.barcos.each do |b|
        b.vivo = true
      end
      juego_revisar_jugador.revisar_jugador
      expect(juego_revisar_jugador.vivo).to eq true
      juego_revisar_jugador.noturno.barcos.each do |b|
        b.vivo = false
      end
      juego_revisar_jugador.revisar_jugador
      expect(juego_revisar_jugador.vivo).to eq false
    end
  end

  context 'Probando la funcion terminar_juego' do
    it 'should end Juego' do
      juego_terminar_juego = Juego.new(dif, jug_1, jug_2, mod_1)
      juego_terminar_juego.terminar_juego
      expect(juego_terminar_juego.vivo).to eq false
    end
  end
end
