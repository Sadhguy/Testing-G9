# frozen_string_literal: true

# Clase que modela los barcos del juego
class Barco
  attr_accessor :largo, :casillas, :vivo, :vida

  def initialize(largo)
    @largo = largo
    @vida = largo
    @vivo = true
    @casillas = []
  end

  def recibir_disparo
    @vida -= 1
    return unless @vida == 0

    @vivo = false
  end

  def revisar_disparo(fil, col)
    (0..(@largo - 1)).each do |c|
      recibir_disparo if (fil == @casillas[c][0]) && (col == @casillas[c][1])
    end
  end
end
