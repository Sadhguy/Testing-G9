# frozen_string_literal: true

require './barco'

largo = 5
fila = 2
columna = 1
casilla = [[2, 1]]

describe Barco do # rubocop:disable Metrics/BlockLength
  context 'Probando la creación de barcos' do
    it 'should match Barco attributes' do
      barco = Barco.new(largo)
      expect(barco.largo).to eq largo
    end
  end

  context 'Probando el disparo a un barco' do
    it 'should print a message if Barco is sunk' do
      barco_disparado = Barco.new(largo)
      barco_disparado.recibir_disparo
      expect(barco_disparado.vivo).to eq TRUE
      barco_disparado.recibir_disparo
      barco_disparado.recibir_disparo
      barco_disparado.recibir_disparo
      expect do
        barco_disparado.recibir_disparo
      end.to output('**********BARCO HUNDIDO!**********
').to_stdout
      expect(barco_disparado.vivo).to eq FALSE
    end
  end

  context 'Revisando el disparo a un barco' do
    it 'should call recibir_disparo sink if Barco is hit' do
      barco_revisado = Barco.new(1)
      barco_revisado.casillas = casilla
      barco_revisado.revisar_disparo(fila, columna)
      expect(barco_revisado.vivo).to eq FALSE
    end
  end
end
