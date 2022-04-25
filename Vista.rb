require './Juego'

class Vista

    def initialize()
        @juego = ''
    end

    def comienzo()
        puts 'Nombre jugador 1:'
        jug1 = gets
        puts 'Jugar contra IA (S ó N):'
        ia = gets
        if ia.upcase == "S\n"
            jug2 = "IA\n"
            mod = 2
        else
            puts 'Nombre jugador 2:'
            jug2 = gets
            mod = 1
        end
        puts 'Elige una dificultad (1, 2 ó 3):'
        dif = gets
        @juego = Juego.new(dif, jug1, jug2, mod)
        colocar_barcos(@juego.jugador1)
        if mod == 2
            colocar_barcos_ia(@juego.jugador2)
        else
            colocar_barcos(@juego.jugador2)
        end
        
        turno while @juego.vivo
    end

    def colocar_barcos(jugador)
        puts "**********\nTurno de #{jugador.nombre}**********"
        colocados = 0
        print_tablero(jugador.tablero_privado)
        while colocados < jugador.cant_barcos
            puts "Barco #{colocados} => largo #{jugador.largo_barcos[colocados]}"
            puts 'Desde y hasta qué casilla quieres poner este barco (Ej: A2A5):'
            cas = gets
            respuesta = jugador.tablero_privado.revisar_para_barcos(cas[0], cas[1], cas[2], cas[3], \
                                                            jugador.barcos[colocados].largo)
            if respuesta[0] == 0
                print_tablero(jugador.tablero_privado)
                jugador.barcos[colocados].casillas = respuesta[1]
                colocados += 1
            else
                if respuesta[0] == 1
                    puts 'Casilla invalida'
                elsif respuesta[0] == 2
                    puts 'No es posible colocar el barco en esa posición'
                elsif respuesta[0] == 3
                    puts 'No puedes colocar los barcos de forma diagonal'
                end
                puts 'Prueba nuevamente'
            end
        end
    end

    def colocar_barcos_ia(jugador) # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
        puts "**********\nTurno de IA\n**********"
        puts "**********\nMe llamo inteligencia artificial pero soy bastante tontx\n**********"
        colocados = 0
        print_tablero(jugador.tablero_privado)
        while colocados < jugador.cant_barcos
          puts "Barco #{colocados} => largo #{jugador.largo_barcos[colocados]}"
          puts 'Desde y hasta qué casilla quieres poner este barco (Ej: A2A5):'
          cas = jugador.colocar_barcos_ia(colocados)
          puts cas
          respuesta = jugador.tablero_privado.revisar_para_barcos(cas[0], cas[1], cas[2], cas[3], \
                                                           jugador.barcos[colocados].largo)
          if respuesta[0] == true
            print_tablero(jugador.tablero_privado)
            jugador.barcos[colocados].casillas = respuesta[1]
            colocados += 1
          else
            puts 'Prueba nuevamente'
          end
        end
      end

    def print_tablero(tablero)
        (0..(tablero.lado)).each do |f|
            p tablero.casillas[f]
          end
    end

    def obtener_tablero(jugador)
        puts "**********\nTablero de #{jugador.nombre}**********"
        print_tablero(jugador.tablero)
    end

    def turno
        puts "**********\nTurno de #{@juego.turno.nombre}**********"
        breaker = true
        while breaker
            if @juego.mod == 2 && @juego.turno == @juego.jugador2
                breaker = false if disparar_ia(@juego.noturno)
            elsif disparar(@juego.noturno)
                breaker = false
            end
        end
        @juego.revisar_jugador
        return unless @juego.vivo

        obtener_tablero(@juego.noturno)
        @juego.terminar_turno
    end

    def disparar(jugador)
        puts 'Inserte casilla a disparar (Ej: A0):'
        cas = gets
        respuesta = revisar_casilla(jugador.tablero_privado, cas[1], cas[0])
        if respuesta[0]
          jugador.rectificar_tableros
          actualizar_barcos(jugador, respuesta[1][0], respuesta[1][1])
          true
        else
          false
        end
      end
    
      def disparar_ia(jugador) # rubocop:disable Metrics/AbcSize
        puts 'Inserte casilla a disparar (Ej: A0):'
        cas = jugador.disparar_ia
        respuesta = revisar_casilla(jugador.tablero_privado, cas[1], cas[0])
        return unless respuesta[0]
    
        jugador.rectificar_tableros
        actualizar_barcos(jugador, respuesta[1][0], respuesta[1][1])
        true
      end

      def revisar_casilla(tablero, fil, col)
        evento = tablero.revisar_casilla(fil, col)
        case evento[0][0]
        when true
            case evento[0][1]
            when 1
                puts '**********AGUA!**********'
            else
                puts '**********FUEGO!**********'
            end
        else
            puts 'Casilla no disponible'
        end
        return evento[0]
      end

      def actualizar_barcos(jugador, fil, col)
        jugador.barcos.each { |b| revisar_disparo(b, fil, col) }
      end

      def revisar_disparo(barco, fil, col)
        (0..(barco.largo - 1)).each do |c|
          recibir_disparo(barco) if (fil == barco.casillas[c][0]) && (col == barco.casillas[c][1])
        end
      end

      def recibir_disparo(barco)
        barco.recibir_disparo
        if barco.vivo == false
            puts '**********BARCO HUNDIDO!**********'
        end
      end

    def terminar_juego
        puts '**********El juego a terminado**********'
        puts "********El ganador es #{@juego.turno.nombre}!********"
        @juego.terminar_juego()
      end
end