import wollok.game.*
import tree.*

/** La pantalla tiene un atributo posición y una imagen */
object pantalla {
	var property position = game.at(0,0)
	var property image = "assets/imagen-0.png"
}

object juego {
	/** Variable auxilar que almacena 0 ("Left") o 1 ("Right") dependiendo de la última tecla que presionó el jugador */
	var property playerInput = 0
	/** Variable que contiene la cantidad de preguntadas acertadas por el jugador */
	var property puntaje = 0
	/** Música del quiz */
	const musicaQuiz = game.sound("assets/amenabar.mp3")
	/** Sonido de cada nodo/pantalla */
	var sonidoPantalla = null
	/** Variable que apunta al estado actual */
	var property estadoActual = tree.inicio().first()
	/** Variable que apunta al nodo actual. Si el estado cambia, el nodo debe cambiar también */
	var property nodoActual = estadoActual
	
	/** Transiciona al hijo con índice playerInput ("Left" = 0, "Right" = 1) */
	method transicionArbol(){
		nodoActual = self.nodoActual().hijos().get(playerInput)
		/** Detiene el sonido de la pantalla previa */
		sonidoPantalla.stop()
		/** Reproduce un sonido de transición */
		game.schedule(0, {(game.sound("assets/glitch-"+0.randomUpTo(1).roundUp(0).toString()+".mp3").play())})
	}
	
	/** Función del estado siguiente. Acá muere la programación orientada a objetos
		Este método lo modificamos para agregar cualquier funcionalidad que no nos permite el árbol */
	method estadoSiguiente(){
		/** Créditos */
		/** Si presiona cualquier tecla, se cierra el juego */
		if (nodoActual == tree.creditos()) {
			game.stop()
		}
		/** Ruta estudiante */
		/** Si el nodo actual es el primero de la ruta del estudiante */
		if (nodoActual == tree.rutaEstudiante().first()) {
			/** Va al estado siguiente */
			estadoActual = tree.rutaEstudiante().get(nodoActual.transiciones().first())
			/** Continúa la música del quiz */
			if (musicaQuiz.paused()) {game.schedule(0, {musicaQuiz.resume()})}
		}
		else{
			/** Si el estado actual está en el quiz 2 */
			if (tree.rutaEstudiante().drop(1).contains(estadoActual)) {
				/** Si el jugador eligió la respuesta correcta, suena "yay" */
				if (playerInput == estadoActual.auxiliar()) {
					game.schedule(0, {(game.sound("assets/correct-yay.mp3").play())})
				}
				/** Si el jugador eligió la respuesta incorrecta, suena "buzzer" */
				else {
					game.schedule(0, {(game.sound("assets/incorrect-buzzer.mp3").play())})
				}
				/** Si está en la última pregunta del quiz, la transición es a la subtrama facu */
				if (estadoActual == tree.rutaEstudiante().get(5)) {
					/** Detiene la música del quiz */
					game.schedule(0, {musicaQuiz.pause()})
					estadoActual = tree.subtramaFacu()
				}
				/** Por defecto la transición es al primer elemento de la lista de transiciones */
				else {
					estadoActual = tree.rutaEstudiante().get(estadoActual.transiciones().first())
				}
			}
		}
		/** Inicio */
		/** Si el estado actual es del quiz */
		if (tree.inicio().take(7).contains(estadoActual)) {
			/** Si el jugador eligió la respuesta correcta, incrementa el puntaje y suena "yay" */
			if (playerInput == estadoActual.auxiliar()) {
				game.schedule(0, {(game.sound("assets/correct-yay.mp3").play())})
				puntaje++
			}
			/** Si el jugador eligió la respuesta incorrecta, suena "buzzer" */
			else {
				game.schedule(0, {(game.sound("assets/incorrect-buzzer.mp3").play())})
			}
			/** Si está en la última pregunta del quiz, la transición depende del puntaje */
			if (estadoActual == tree.inicio().get(6)) {
				/** Detiene la música del quiz */
				game.schedule(0, {musicaQuiz.pause()})
				estadoActual = tree.inicio().get(estadoActual.transiciones().get(puntaje))
			}
			/** Por defecto la transición es al primer elemento de la lista de transiciones */
			else {
				estadoActual = tree.inicio().get(estadoActual.transiciones().first())
			}
		}
		/** El nodo sigue al estado */
		nodoActual = estadoActual
	}
	
	/** Método del cambio de pantalla */
	method act(){
		/** Si el nodo actual no tiene hijos, entonces la transición es al estado siguiente */
		if (nodoActual.hijos().isEmpty()) {
			self.estadoSiguiente()
		}
		/** Si el nodo actual tiene hijos, entonces la transición es a alguno de ellos */
		else {
			self.transicionArbol()
		}
		/** Reproduce el sonido del nuevo nodo */
		sonidoPantalla = game.sound("assets/"+nodoActual.audio()+".mp3")
		game.schedule(0, {(sonidoPantalla.play())})
		/** Actualiza la pantalla */
		pantalla.image("assets/imagen-"+nodoActual.imageID().toString()+".png")
	}
	
	method init() {
		/** Ancho de la pantalla (en celdas) */
		game.width(1024)
		/** Alto de la pantalla (en celdas) */
  		game.height(896)
  		/** Tamaño de la celda (en píxeles) */
  		game.cellSize(1)
  		/** Título de la ventana del juego */
  		game.title("The Big Quiz")
  		/** Fondo del juego */
  		game.boardGround("assets/black.jpg")
  		/** Agrega la imagen de la pantalla */
  		game.addVisual(pantalla)
  		/** Configura la música del quiz para que suene en loop */
		musicaQuiz.shouldLoop(true)
		/** Ajusta el volumen de los sonidos */
		musicaQuiz.volume(0.05)
		/** Reproduce la música del quiz */
		game.schedule(0, {musicaQuiz.play()})
		
		
		/** Cuando el jugador presiona "Left" */
		keyboard.left().onPressDo({
			playerInput = 0
			self.act()
		})
		/** Cuando el jugador presiona ""Right */
		keyboard.right().onPressDo({
			playerInput = 1
			self.act()
		})
		
		/** Inicia el juego */
		game.start()
	}
}
