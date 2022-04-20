class Barco
    
    attr_accessor :largo
    attr_accessor :casillas
    attr_accessor :vivo

    def initialize(largo)
        @largo = largo
        @vida = largo
        @vivo = true
        @casillas = []
    end

    def recibir_disparo
        puts "me dieron"
        @vida -= 1
        puts "vida #{@vida}"
        if @vida == 0
            @vivo = false
            puts "**********BARCO HUNDIDO!**********"
        end
    end

    def revisar_disparo(fil, col)
        for c in 0..(@largo-1)
            puts "Disparo #{fil} Casillas #{@casillas[c][0]}"
            puts "Disparo #{col} Casillas #{@casillas[c][1]}"
            if (fil == @casillas[c][0]) && (col == @casillas[c][1])
                recibir_disparo
            end
        end
    end
end