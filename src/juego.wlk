import wollok.game.*
import tree.*

/** La pantalla tiene un atributo posición y una imagen */
object pantalla {
	var property position = game.at(0,0)
	var property image = "assets/imagen-quiz-0.png"
}

object juego {
	/** Variable auxilar que almacena 0 ("Left") o 1 ("Right") dependiendo de la última tecla que presionó el jugador */
	var property playerInput = 0
	/** Variable que contiene la cantidad de preguntadas acertadas por el jugador */
	var property puntaje = 0
	/** Sonido de cada nodo/pantalla */
	var property sonidoPantalla = game.sound("assets/silence.mp3")
	/** Variable que apunta al estado actual */
	var property estadoActual = automata.estados().first()
	/** Diccionario de música */
	var property musica = new Dictionary()
	
	/** Método que crea el diccionario con las canciones */
	method crearDiccionario() {
		musica.put("silence", game.sound("assets/silence.mp3"))
		musica.put("quiz", game.sound("assets/dreamscape.mp3"))
		musica.put("terror", game.sound("assets/horror-background-atmosphere.mp3"))
		musica.put("drama", game.sound("assets/gnossienne.mp3"))
		musica.put("flaco", game.sound("assets/amenabar.mp3"))
		musica.put("kevin", game.sound("assets/not-as-it-seems.mp3"))
	}
	
	/** Método para incrementar el puntaje */
	method incrementarPuntaje() {
		puntaje++
	}
	
	/** Método para cambiar el estado */
	method cambioEstado(estado) {
		estadoActual = estado
	}
	
	/** Método para cambiar el sonido */
	method cambioSonido(sonido) {
		sonidoPantalla = sonido
	}
	
	method actualizar() {
		/** Cambio de estado */
		estadoActual.estadoSiguiente()
		/** Reproduce el sonido del nuevo estado */
		self.cambioSonido(game.sound("assets/"+estadoActual.audio()+".mp3"))
		game.schedule(0, {sonidoPantalla.play()})
		/** Actualiza la pantalla */
		pantalla.image("assets/imagen-"+estadoActual.imageID()+".png")
	}
	
	method init() {
		/** Ancho de la pantalla (en celdas) */
		game.width(16)
		/** Alto de la pantalla (en celdas) */
  		game.height(14)
  
  		/** Tamaño de la celda (en píxeles) */
  		game.cellSize(64)
  		/** Título de la ventana del juego */
  		game.title("The Big Quiz")
  		/** Fondo del juego */
  		game.boardGround("assets/black.jpg")
  		/** Agrega la imagen de la pantalla */
  		game.addVisual(pantalla)
  		
  		/** Crea el diccionario con la música */
  		self.crearDiccionario()
  		/** Configura la música para que suene en loop */
  		musica.get("silence").shouldLoop(true)
		musica.get("quiz").shouldLoop(true)
		/** Ajusta el volumen de los sonidos */
		musica.get("quiz").volume(0.03)
		musica.get("terror").volume(0.25)
		musica.get("drama").volume(0.10)
		musica.get("flaco").volume(0.07)
		musica.get("kevin").volume(0.15)
		/** Reproduce la música del quiz */
		game.schedule(0, {musica.get("quiz").play()})
		
		
		/** Cuando el jugador presiona "Left" */
		keyboard.left().onPressDo({
			playerInput = 0
			self.actualizar()
		})
		/** Cuando el jugador presiona ""Right */
		keyboard.right().onPressDo({
			playerInput = 1
			self.actualizar()
		})
		
		/** Inicia el juego */
		game.start()
	}
}
