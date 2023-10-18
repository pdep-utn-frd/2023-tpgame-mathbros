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
	const musicaQuiz = game.sound("assets/dreamscape.mp3")
	/** Música de terror */
	const musicaTerror = game.sound("assets/horror-background-atmosphere.mp3")
	/** Música drama */
	const musicaDrama = game.sound("assets/gnossienne.mp3")
	/** Música flaco */
	const musicaFlaco = game.sound("assets/amenabar.mp3")
	/** Sonido de cada nodo/pantalla */
	var sonidoPantalla = game.sound("assets/silence")
	/** Variable que apunta al estado actual */
	var property estadoActual = automata.estados().first()
	
	/** Función del estado siguiente. Acá muere la programación orientada a objetos */
	method estadoSiguiente(){
		/** En la pantalla de créditos, si presiona cualquier tecla, se cierra el juego */
		if (estadoActual == automata.estados().last()) {game.stop()}
		/** Vuelve la música del quiz para el segundo quiz */
		else if (estadoActual == automata.estados().get(51)) {
			if (musicaQuiz.paused()) {game.schedule(0, {musicaQuiz.resume()})}
		}
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
				/** Si está en la última pregunta del quiz, se detiene la música */
				if ((estadoActual == automata.estados().get(6)) or (estadoActual == automata.estados().get(29)) or (estadoActual == automata.estados().get(73))) {
					/** Detiene la música del quiz */
					game.schedule(0, {musicaQuiz.pause()})
				}
			}
		/** Si no, reproduce un sonido de transición */
		else {game.schedule(0, {(game.sound("assets/glitch-"+(0).randomUpTo(2).truncate(0).toString()+".mp3").play())})}
		/** Si el estado actual es el de la puerta, reproduce la música de terror */
		if (automata.estados().get(74) == estadoActual) {game.schedule(0, {musicaTerror.play()})}
		/** Si el estado actual es la muerte filosófica, el rapto o la puerta 3 */
		else if ((automata.estados().get(59) == estadoActual and playerInput == 0) or (automata.estados().get(61) == estadoActual) or (automata.estados().get(69) == estadoActual)) {
			/** Detiene la música de terror */
			game.schedule(0, {musicaTerror.pause()})
		}
		/** Si elige "Aceptar tu derrota" suena la música drama */
		else if (estadoActual == automata.estados().get(54) and playerInput == 1) {game.schedule(0, {musicaDrama.play()})}
		/** Si el estado actual es el del mate perfecto y elige "Trabajar en tu proyecto", reproduce la música del flaco Spinetta */
		else if (playerInput == 1 and estadoActual == automata.estados().get(67)) {game.schedule(0, {musicaFlaco.play()})}
		/** Detiene el sonido de la pantalla previa */
		if (sonidoPantalla.played()) {sonidoPantalla.stop()}
		/** Si está en la última pregunta del primer quiz, la transición depende del puntaje */
		if (estadoActual == automata.estados().get(6)) {estadoActual = automata.estados().get(estadoActual.transiciones().get(puntaje))}
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
  		/** Configura la música del quiz para que suene en loop */
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
