# frozen_string_literal: true

# Clase que modela los barcos del juego
class Barco
  attr_accessor :largo, :casillas, :vivo

  def initialize(largo)
    @largo = largo
    @vida = largo
    @vivo = true
    @casillas = []
  end

  def recibir_disparo
    @vida -= 1
    return false unless @vida == 0 # rubocop:disable Style/NumericPredicate

    @vivo = false
    true
  end

  def revisar_disparo(fil, col)
    (0..(@largo - 1)).each do |c|
      return recibir_disparo if (fil == @casillas[c][0]) && (col == @casillas[c][1])
    end
  end
end
