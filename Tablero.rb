class Tablero
    attr_accessor :casillas
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


    def pintar_casilla(f, c, i)
        if i == 1
            @casillas[f][c] = 'X'
        elsif i == 2
            @casillas[f][c] = 'o'
        elsif i == 3
            @casillas[f][c] = '#'
        end
    end


    def revisar_casilla(fil, col)
        f = fil.to_i()
        if (@letras.include? col.upcase) && ((0..(@lado-1)).include? f)
            c = @letras.find_index(col.upcase)
            if @casillas[f+1][c+1] == 0
                self.pintar_casilla(f+1, c+1, 2)
                puts "**********AGUA!**********"
                return [true, [f+1, c+1]]
            elsif @casillas[f+1][c+1] == '#'
                self.pintar_casilla(f+1, c+1, 1)
                puts "**********FUEGO!**********"
                return [true, [f+1, c+1]]
            else
                puts "Casilla no disponible"
                return [false]
            end

        end
    end

    def revisar_para_barcos(col1, fil1, col2, fil2, largo)
        fil1 = fil1.to_i()
        fil2 = fil2.to_i()
        col1 = @letras.find_index(col1.upcase)
        col2 = @letras.find_index(col2.upcase)
        tablero_provisional = self
        if !((0..(@lado-1)).include?  col1) || !((0..(@lado-1)).include? fil1) || \
           !((0..(@lado-1)).include?  col2) || !((0..(@lado-1)).include? fil2) 
            puts "Casilla invalida"
            return [false]
        end
        if col1 == col2
            fils = 0
            cas = []
            for i in (0..(largo-1))
                if @casillas[fil1+1+i][col1+1] == 0
                    fils += 1
                    tablero_provisional.pintar_casilla(fil1+1+i, col1+1, 3)
                    cas.push([fil1+1+i, col1+1])
                else
                    puts "No es posible colocar el barco en esa posición"
                    return [false]
                end
            end
            if fils == largo
                @casillas = tablero_provisional.casillas
                return [true, cas]
            else
                puts "No es posible colocar el barco en esa posición"
                return [false]
            end
        elsif fil1 == fil2
            cols = 0
            cas = []
            for i in (0..(largo-1))
                if @casillas[fil1+1][col1+1+i] == 0
                    cols += 1
                    tablero_provisional.pintar_casilla(fil1+1, col1+1+i, 3)
                    cas.push([fil1+1, col1+1+i])
                else
                    puts "No es posible colocar el barco en esa posición"
                    return [false]
                end
            end
            if cols == largo
                @casillas = tablero_provisional.casillas
                return [true, cas]
            else
                puts "No es posible colocar el barco en esa posición"
                return [false]
            end
        else
            puts "No puedes colocar los barcos de forma diagonal"
            return [false]
        end
    end
end
