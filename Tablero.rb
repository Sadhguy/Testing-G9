class Tablero
    attr_accessor :lado

    def initialize
        @lado = :lado
        @letras = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",\
                    "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    end

    def crear_tablero
        tablero = []
        cont = 0
        let = []
        for f in 0..(@lado-1)
            let.push(@letras[f])
        end
        tablero.push(let)
        for f in 1..@lado
            fil = []
            for c in 0..@lado
                if c == 0
                    fil.push(cont)
                end 
                fil.push(0)
            end
            cont += 1
            tablero.push(fil)
        end
        @tablero = tablero
    end

    def print_tablero
        for f in 0..@lado
            p @tablero[f]
        end
    end
end
