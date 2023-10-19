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
	/** No música */
	const property silence = game.sound("assets/silence.mp3")
	/** Música del quiz */
	const property musicaQuiz = game.sound("assets/dreamscape.mp3")
	/** Música de terror */
	const property musicaTerror = game.sound("assets/horror-background-atmosphere.mp3")
	/** Música drama */
	const property musicaDrama = game.sound("assets/gnossienne.mp3")
	/** Música flaco */
	const property musicaFlaco = game.sound("assets/amenabar.mp3")
	/** Sonido de cada nodo/pantalla */
	var sonidoPantalla = game.sound("assets/silence.mp3")
	/** Variable que apunta al estado actual */
	var property estadoActual = automata.estados().first()
	
	/** Función del estado siguiente. Acá muere la programación orientada a objetos */
	method estadoSiguiente(){
		/** Llama al método de poner música del estado actual */
		estadoActual.poneMusica(playerInput)
		/** En la pantalla de créditos, si presiona cualquier tecla, se cierra el juego */
		if (estadoActual == automata.estados().last()) {game.stop()}
		/** Si el estado actual está en algún quiz */
		else if (automata.estados().take(7).contains(estadoActual) or automata.estados().drop(25).take(5).contains(estadoActual) or automata.estados().drop(69).take(5).contains(estadoActual)) {
				/** Si el jugador eligió la respuesta correcta, suena "yay" */
				if (playerInput == estadoActual.auxiliar()) {
					game.schedule(0, {(game.sound("assets/correct-yay.mp3").play())})
					/** E incrementa el puntaje */
					puntaje++
				}
				/** Si el jugador eligió la respuesta incorrecta, suena "buzzer" */
				else {
					game.schedule(0, {(game.sound("assets/incorrect-buzzer.mp3").play())})
				}
			}
		/** Si no, reproduce un sonido de transición */
		else {game.schedule(0, {(game.sound("assets/glitch-"+(0).randomUpTo(2).truncate(0).toString()+".mp3").play())})}
		/** Detiene el sonido de la pantalla previa */
		if (sonidoPantalla.played()) {sonidoPantalla.stop()}
		/** Si está en la última pregunta del primer quiz, la transición depende del puntaje */
		if (estadoActual == automata.estados().get(6)) {estadoActual = automata.estados().get(estadoActual.transiciones().get(puntaje))}
		/** Si no, si está en el estado de cobranza, la transición es al azar */
		else if (estadoActual == automata.estados().get(68)) {estadoActual = automata.estados().get(estadoActual.transiciones().get((0).randomUpTo(2).truncate(0)))}
		/** Por defecto la transición es al elemento de la lista de transiciones que se corresponde con el playerInput */
		else {estadoActual = automata.estados().get(estadoActual.transiciones().get(playerInput))}
	}
	
	/** Método del cambio de pantalla */
	method act(){
		/** Cambia el estado */
		self.estadoSiguiente()
		/** Reproduce el sonido del nuevo estado */
		sonidoPantalla = game.sound("assets/"+estadoActual.audio()+".mp3")
		game.schedule(0, {(sonidoPantalla.play())})
		/** Actualiza la pantalla */
		pantalla.image("assets/imagen-"+estadoActual.imageID().toString()+".png")
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
  		/** Configura la música para que suene en loop */
  		silence.shouldLoop(true)
		musicaQuiz.shouldLoop(true)
		/** Ajusta el volumen de los sonidos */
		musicaQuiz.volume(0.03)
		musicaTerror.volume(0.25)
		musicaDrama.volume(0.10)
		musicaFlaco.volume(0.07)
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
