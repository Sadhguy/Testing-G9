# Testing-G9

##El juego requiere ruby 3.0.0

## Instalación
1) Clonar repositorio
2) Entrar a la carpeta del repositorio
3) Correr ruby main.rb:
      - Seguir instrucciones que aparecen en consola
4) Disfrutar


## Reglas del Juego
   El juego consiste en una clasica partida de batalla naval donde uno puede jugar contra otra persona o una IA. El jugador debe elegir la dificultad de juego (que inlfuye en el tamaño del tablero) y luego decidir donde poner sus distintas embarcaciones dentro del tablero. Puestos todos los barcos comienza el juego, donde por turnos cada jugador debe tratar de adivinar donde estan las embarcaciones del otro para hundirlas. Quien hunda la flota enemiga primero será el ganador.
   
## Restricciones de Rubocop Deshabilitadas

1) Method Length - se deshabilita ya que el número de líneas propuesto era demasiado bajo.
2) Class Lenght - se deshabilita ya que el número de líneas propuesto era demasiado bajo.
3) Cyclomatic Complexity- La complejidad propuesta por Rubocop era muy baja.
4) AbcSize - cantidad de metodos ABC era demasiado baja para el correcto funcionamiento del programa
5) NumericPredicate - se deshabilita porque no incluia comparación con string y no permitía el funcionamiento del programa
6) Perceived  Complexity - complejidad propuesta por Rubocop era muy baja.


## Tests
     *Para ejecutar los tests correr el comando rspec spec path_del_test
