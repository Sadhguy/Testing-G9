require './Tablero'
require './Barco'

class Jugador
    attr_accessor :nombre
    attr_accessor :tablero
    attr_accessor :tablero_privado
    attr_accessor :barcos
    attr_accessor :cant_barcos

    def initialize(dif, nombre)
        difs = [7, 14, 21]
        barcs = [2, 3, 5, 6, 4, 7, 1, 9, 3]
        @nombre = nombre
        @lado = difs[dif.to_i()-1]
        @tablero = Tablero.new(@lado)
        @tablero_privado = Tablero.new(@lado)
        @cant_barcos = 3*difs[dif.to_i()-1]/7
        @largo_barcos = barcs.take(@cant_barcos)
        self.inicializar_barcos
    end

    def inicializar_barcos
        barcos = []
        @largo_barcos.each {|l| barcos.push(Barco.new(l))}
        @barcos = barcos
    end

    def colocar_barcos
        puts "**********\nTurno de "+self.nombre+"**********"
        colocados = 0
        @tablero_privado.print_tablero
        while colocados < @cant_barcos
            puts "Barco #{colocados} => largo #{@largo_barcos[colocados]}"
            puts "Desde y hasta qué casilla quieres poner este barco (Ej: A2A5):"
            cas = gets
            respuesta = @tablero_privado.revisar_para_barcos(cas[0], cas[1], cas[2], cas[3], \
            @barcos[colocados].largo)
            if respuesta[0] == true
                @tablero_privado.print_tablero
                @barcos[colocados].casillas = respuesta[1]
                colocados += 1
            else
                puts "Prueba nuevamente"
            end
        end
    end


    def colocar_barcos_IA
        puts "**********\nTurno de IA\n**********"
        puts "**********\nMe llamo inteligencia artificial pero soy bastante tontx\n**********"
        colocados = 0

        @tablero_privado.print_tablero
        while colocados < @cant_barcos
            puts "Barco #{colocados} => largo #{@largo_barcos[colocados]}"
            puts "Desde y hasta qué casilla quieres poner este barco (Ej: A2A5):"
            randcol = ('A'..'Z').to_a
            randc = rand(@lado - (@barcos[colocados].largo)-1)
            randfil = rand(0 .. @lado-1)
            randy = rand(2)
            if randy == 0
                cas = randcol[randc] + randfil.to_s + randcol[randc] + \
                      (randfil + (@barcos[colocados].largo)-1).to_s
                puts cas
            else
                cas = randcol[randc] + randfil.to_s + \
                      randcol[randc + @barcos[colocados].largo - 1] + randfil.to_s
                puts cas
            end
            respuesta = @tablero_privado.revisar_para_barcos(cas[0], cas[1], cas[2], cas[3], \
            @barcos[colocados].largo)
            if respuesta[0] == true
                @tablero_privado.print_tablero
                @barcos[colocados].casillas = respuesta[1]
                colocados += 1
            else
                puts "Prueba nuevamente"
            end
        end
    end


    def rectificar_tableros
        for f in 1..@lado
            for c in 1..(@lado-1)
                if @tablero_privado.casillas[f][c] != "#"
                    @tablero.casillas[f][c] = @tablero_privado.casillas[f][c]
                end
            end
        end
    end

    def get_tablero
        puts "**********\nTablero de "+@nombre+"**********"
        @tablero.print_tablero
    end

    def disparar(jugador)
        puts "Inserte casilla a disparar (Ej: A0):"
        cas = gets
        respuesta = jugador.tablero_privado.revisar_casilla(cas[1], cas[0])
        if respuesta[0]
            jugador.rectificar_tableros
            jugador.actualizar_barcos(respuesta[1][0], respuesta[1][0])
            return true
        else
            return false
        end
    end

    def disparar_IA(jugador)
        puts "Inserte casilla a disparar (Ej: A0):"
        randcol = ('A'..'Z').to_a
        randc = rand(@lado)
        randfil = rand(@lado)
        cas = randcol[randc] + randfil.to_s
        respuesta = jugador.tablero_privado.revisar_casilla(cas[1], cas[0])
        if respuesta[0]
            jugador.rectificar_tableros
            jugador.actualizar_barcos(respuesta[1][0], respuesta[1][0])
            return true
        else
            return false
        end
    end

    def actualizar_barcos(fil, col)
        @barcos.each {|b| b.revisar_disparo(fil, col)}
    end

end