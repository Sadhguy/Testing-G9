class Tablero

    def initialize(lado)
        @lado = lado
        @letras = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",\
                    "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        @casillas = crear_tablero
    end

    def crear_tablero
        tablero = []
        cont = 0
        let = @letras.take(@lado)
        tablero.push(let)
        for f in 1..@lado
            fil = []
            for c in 0..(@lado-1)
                if c == 0
                    fil.push(cont)
                end 
                fil.push(0)
            end
            cont += 1
            tablero.push(fil)
        end
        return tablero
    end

    def print_tablero
        for f in 0..@lado
            p @casillas[f]
        end
    end


    def pintar_casilla(f, c)
        @casillas[f][c] = "X"
    end


    def revisar_casilla(col, fil)
        f = fil.to_i()
        if (@letras.include? col.upcase) && ((0..(@lado-1)).include? f)
            c = @letras.find_index(col.upcase)
            if @casillas[f+1][c+1] == 0
                self.pintar_casilla(f+1, c+1)
                return 1
            else
                puts "Casilla no disponible"
            end

        end
    end
end
