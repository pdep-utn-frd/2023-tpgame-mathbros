import wollok.game.*
import juego.*
import minijuego.*

/** Estados de un autómata */
class Estado {
	/** imageID es el nombre de la imagen: "imagen-imageID.png" */
	var property imageID = ""
	/** Audio: se reproduce cuando aparece la pantalla */
	var property audio = "silence"
	/** Las transiciones son listas con los ID de los estados siguientes */
	var property transiciones = ["to-be-continued" /** Left */, "to-be-continued" /** Right */]
	/** Variable auxiliar cuya utilidad se define en la función del estado siguiente */
	var property auxiliar = null
	/** musicaID es la key del diccionario de canciones del juego */
	var property musicaID = ["silence", "silence"]

	method iniciar(){}

	/** Método que reproduce o pausa la música */
	method poneMusica() {
		/** Variable que obtiene el objeto musical */
		const music = juego.musica().get(self.musicaID().get(juego.playerInput()))
		/** Si está pausada, la despausa */
		if (music.paused()){game.schedule(0, {music.resume()})}
		/** Si se está reproduciendo, la pausa */
		else if (music.played()) {game.schedule(0, {music.pause()})}
		/** Si no, la reproduce */
		else {game.schedule(0, {music.play()})}
	}
	
	/** Función del estado siguiente */
	method estadoSiguiente() {

		/** Interacciones especiales */
		/** Si el estado actual es la pregunta sobre Wollok */
		if (self.imageID() == "quiz3-wollok") {
			if (juego.playerInput() == self.auxiliar()) {
				/** Si el jugador eligió la respuesta correcta, suena "SIII!" */
				game.schedule(0, {(game.sound("assets/SIII!.mp3").play())})
				}
				/** Si el jugador eligió la respuesta incorrecta, suena "NOOO!" */
				else {
					game.schedule(0, {(game.sound("assets/NOOO!.mp3").play())})
			}
		}
		/** Si el estado actual está en algún quiz */
		else if (self.imageID().take(4) == "quiz") {
				/** Si el jugador eligió la respuesta correcta, suena "yay" */
				if (juego.playerInput() == self.auxiliar()) {
					game.schedule(0, {(game.sound("assets/correct-yay.mp3").play())})
					/** E incrementa el puntaje */
					juego.incrementarPuntaje()
				}
				/** Si el jugador eligió la respuesta incorrecta, suena "buzzer" */
				else {
					game.schedule(0, {(game.sound("assets/incorrect-buzzer.mp3").play())})
				}
			}
		/** Reproduce un sonido de transición */
		else {game.schedule(0, {(game.sound("assets/glitch-"+(0).randomUpTo(2).truncate(0).toString()+".mp3").play())})}
	
		/** Transiciones */
		/** Si está en la última pregunta del primer quiz, la transición depende del puntaje */
		if (self.imageID() == "quiz-6" or self.imageID() == "creditos") {juego.cambioEstado(automata.estados().find({estado => estado.imageID() == self.transiciones().get(juego.puntaje())}))}
		/** Si no, si está en el estado de cobranza, la transición es al azar */
		else if (self.imageID() == "cobrador-0") {juego.cambioEstado(automata.estados().find({estado => estado.imageID() == self.transiciones().get((0).randomUpTo(2).truncate(0))}))}
		/** Por defecto la transición es al elemento de la lista de transiciones que se corresponde con el playerInput */
		else {juego.cambioEstado(automata.estados().find({estado => estado.imageID() == self.transiciones().get(juego.playerInput())}))}
		
		juego.estadoActual().iniciar()
		/** Interacciones comunes */
		/** Llama al método de poner música del estado actual */
		self.poneMusica()
		/** Detiene el sonido de la pantalla previa */
		if (juego.sonidoPantalla().played()) {juego.sonidoPantalla().stop()}
	}
}


class EstadoMinijuego inherits Estado {
	const items = []
	var nuevoItem = 0
	var dificultad = 1
	
	override method estadoSiguiente(){}
	override method iniciar() {
		game.addVisual(jugador)
		game.addVisual(puntaje)
		keyboard.left().onPressDo({
			jugador.moverIzq()
		})
		keyboard.right().onPressDo({
			jugador.moverDer()
		})
		game.onTick(100, "actualizar", {
			self.actualizar()
		})

	}
	method actualizar() {
		items.forEach({item => 
			if(item.position().x() == jugador.position().x() && item.position().y() == jugador.position().y()) {
				var diferencia = item.cambioPuntaje()
				if (diferencia > 0) {
					game.sound("assets/coin.mp3").play()
				} else {
					game.sound("assets/error.mp3").play()
				}
				puntaje.valor(puntaje.valor() + diferencia)
				items.remove(item) 
				game.removeVisual(item)
			}
			
			if(item.position().y() == 0) {
				items.remove(item) 
				game.removeVisual(item)
			}
			item.mover()
		})
		
		if(puntaje.valor() >= 50) {
			dificultad = 2
		}
		

		if (nuevoItem == 8/dificultad){
			const random = 0.randomUpTo(100)
			var item
			if(random < 20){
				item = new Banana(position=game.at(0.randomUpTo(32).truncate(0), 27), delay=4/dificultad)
			} else if (random < 40) {
				item = new Mate(position=game.at(0.randomUpTo(32).truncate(0), 27), delay=4/dificultad)
			} else {
				item = new Cafe(position=game.at(0.randomUpTo(32).truncate(0), 27), delay=4/dificultad)
			}
			
		
			game.addVisual(item)
			items.add(item)
			nuevoItem = 0
		}
		nuevoItem++
	}
	method ganar(){
		game.removeTickEvent("actualizar")
		juego.cambioEstado(automata.estados().find({estado => estado.imageID() == "imagen-perder"}))
		
	}
	method perder(){
		game.removeTickEvent("actualizar")
		juego.cambioEstado(automata.estados().find({estado => estado.imageID() == "imagen-perder"}))
	}
}

/** Autómata del juego */
object automata {
	/** Estados del juego. Cada uno corresponde a una pantalla */
	const property estados = [
		/** Acá arranca el quiz */
		/** El valor de auxiliar representa la respuesta correcta */
		new Estado(imageID = "quiz-0", transiciones = ["quiz-1", "quiz-1"], auxiliar = 0),
		new Estado(imageID = "quiz-1", transiciones = ["quiz-2", "quiz-2"], auxiliar = 1),
		new Estado(imageID = "quiz-2", transiciones = ["quiz-3", "quiz-3"], auxiliar = 1),
		new Estado(imageID = "quiz-3", transiciones = ["quiz-4", "quiz-4"], auxiliar = 0),
		new Estado(imageID = "quiz-4", transiciones = ["quiz-5", "quiz-5"], auxiliar = 1),
		new Estado(imageID = "quiz-5", transiciones = ["quiz-6", "quiz-6"], auxiliar = 1),
		new Estado(imageID = "quiz-6", transiciones = ["resultado-0", "resultado-1", "resultado-2", "resultado-2", "resultado-2", "resultado-3", "resultado-3", "resultado-4"], auxiliar = 0, musicaID = ["quiz", "quiz"]),
		/** Acá termina el quiz */
		/** Resultados del primer quiz */
		new Estado(imageID = "resultado-0", audio = 'quiz-0', transiciones = ["cafe", "mate"]),
		new Estado(imageID = "resultado-1", audio = 'quiz-1', transiciones = ["cafe", "mate"]),
		new Estado(imageID = "resultado-2", audio = 'quiz-2', transiciones = ["cafe", "mate"]),
		new Estado(imageID = "resultado-3", audio = 'quiz-3', transiciones = ["cafe", "mate"]),
		new Estado(imageID = "resultado-4", audio = 'quiz-4', transiciones = ["cafe", "mate"]),
		/** Acá arranca la aventura */
		/** Café */
		new Estado(imageID = "cafe", audio = "olha-a-hora-do-cafe", transiciones = ["chad-cafe-solo", "leche"]),
			/** Tomar solo */
			new Estado(imageID = "chad-cafe-solo", audio = "chad-0", transiciones = ["ducha-0", "ducha-0"]),
			new Estado(imageID = "ducha-0", transiciones = ["telefono-0", "chad-ducha"]),
				/** Llamar al dueño del edificio */
				new Estado(imageID = "telefono-0", audio = "que", transiciones = ["telefono-01", "telefono-11"]),
					/** Soy yo, man */
					new Estado(imageID = "telefono-01", audio = "tell-me-what-you-want", transiciones = ["telefono-02", "telefono-12"]),
						/** No tengo agua caliente */
						new Estado(imageID = "telefono-02", audio = "me-suda-la-polla", transiciones = ["telefono-03", "telefono-13"]),
							/** Me tenés que ayudar */
							new Estado(imageID = "telefono-03", audio = "es-culpa-tuya", transiciones = ["telefono-04", "telefono-14"]),
								/** Es tu edificio, hacete cargo */
								new Estado(imageID = "telefono-04", audio = "que-quieres-que-haga", transiciones = ["telefono-05", "telefono-15"]),
									/** Solucioname el tema del agua */
									new Estado(imageID = "telefono-05", audio = "no-quiero", transiciones = ["telefono-06", "telefono-16"]),
										/** ¡Dale, gordo! */
										new Estado(imageID = "telefono-06", audio = "joder"),
											/** ... */
										/** Cortar */
										/** Final: ruptura */
										new Estado(imageID = "telefono-16", audio = "ruptura-ending", transiciones = ["creditos", "creditos"]),
									/** Tu servicio es desproporcional al precio */
									new Estado(imageID = "telefono-15", audio = "lo-que-no-tengo-proporcional", transiciones = ["intro-quiz2", "no-es-un-juego-0"]),
										/** Estudiar para el examen */
										new Estado(imageID = "intro-quiz2", transiciones = ["quiz2-0", "quiz2-0"], musicaID = ["quiz", "quiz"]),
										/** Empieza el segundo quiz */
										new Estado(imageID = "quiz2-0", transiciones = ["quiz2-1", "quiz2-1"], auxiliar = 1),
										new Estado(imageID = "quiz2-1", transiciones = ["quiz2-2", "quiz2-2"], auxiliar = 0),
										new Estado(imageID = "quiz2-2", transiciones = ["quiz2-3", "quiz2-3"], auxiliar = 1),
										new Estado(imageID = "quiz2-3", transiciones = ["quiz2-caca", "quiz2-caca"], auxiliar = 0),
										new Estado(imageID = "quiz2-caca", audio = "quieres-que-te-haga-caca-en-la-cara", transiciones = ["suena-telefono-0", "suena-telefono-0"], auxiliar = 1, musicaID = ["quiz", "quiz"]),
										/** Termina el segundo quiz */
										new Estado(imageID = "suena-telefono-0", audio = "telefono", transiciones = ["contesta-telefono-0", "suena-telefono-1"]),
											/** No, no la hay */
											new Estado(imageID = "contesta-telefono-0", audio = "me-he-dejado-las-llaves-dentro", transiciones = ["contesta-telefono-1", "contesta-telefono-1"]),
											new Estado(imageID = "contesta-telefono-1", audio = "no-es-gracioso", transiciones = ["contesta-telefono-apiadarse-0", "contesta-telefono-que-se-cague-0"]),
												/** Apiadarte del pobre infeliz */
												new Estado(imageID = "contesta-telefono-apiadarse-0", audio = "gracias-por-escuchar-mis-plegarias-tio", transiciones = ["contesta-telefono-apiadarse-1", "contesta-telefono-apiadarse-1"]),
												new Estado(imageID = "contesta-telefono-apiadarse-1"),
													/** Termina el día 1 */
												/** ¡Que se cague por gil! */
												new Estado(imageID = "contesta-telefono-que-se-cague-0", audio = "me-cago-en-tus-muertos", transiciones = ["contesta-telefono-que-se-cague-1", "contesta-telefono-que-se-cague-1"]),
												new Estado(imageID = "contesta-telefono-que-se-cague-1"),
													/** Termina el día 1 */
											/** Me da paja */
											new Estado(imageID = "suena-telefono-1", audio = "eres-un-vago-de-mierda", transiciones = ["contesta-telefono-0", "vagabundo-ending"]),
												/** Ser un *vago de mierda* */
												new Estado(imageID = "vagabundo-ending", audio = "vagabundo-ending", transiciones = ["creditos", "creditos"]),
										/** Trabajar en tu proyecto */
										new Estado(imageID = "videojuego-0", transiciones = ["no-es-un-juego-0", "no-es-un-juego-0"]),
										new Estado(imageID = "no-es-un-juego-0", audio = "como-que-un-juego", transiciones = ["no-es-un-juego-1", "no-es-un-juego-1"]),
										new Estado(imageID = "no-es-un-juego-1", audio = "esto-no-es-un-juego", transiciones = ["libertad-ending", "no-es-un-juego-2"]),
											/** Esto ES un juego */
											/** Final: libertad */
											new Estado(imageID = "libertad-ending", audio = "libertad-ending", transiciones = ["creditos", "creditos"]),
											/** NADA es un juego */
											new Estado(imageID = "no-es-un-juego-2", transiciones = ["final-juego-0", "final-juego-0"]),
											/** ... */
											new Estado(imageID = "final-juego-0", transiciones = ["final-juego-1", "final-juego-1"]),
											new Estado(imageID = "final-juego-1", audio = "1-muy-buenas-tardes-a-todos", transiciones = ["final-juego-2", "final-juego-2"], musicaID = ["kevin", "kevin"]),
											new Estado(imageID = "final-juego-2", audio = "2-get-ready", transiciones = ["final-juego-3", "final-juego-3"]),
											new Estado(imageID = "final-juego-3", audio = "3-me-cago-en-dios-gaste-un-poder", transiciones = ["final-juego-4", "final-juego-4"]),
											new Estado(imageID = "final-juego-4", audio = "4-dale", transiciones = ["final-juego-5", "final-juego-5"]),
											new Estado(imageID = "final-juego-5", audio = "5-el-boton-de-reset", transiciones = ["final-juego-6", "final-juego-6"]),
											new Estado(imageID = "final-juego-6", audio = "6-el-creador-de-esta-mierda", transiciones = ["final-juego-7", "final-juego-7"]),
											new Estado(imageID = "final-juego-7", audio = "7-quien-cono-es-fede", musicaID = ["kevin", "kevin"]),
								/** Me lo vas a descontar del alquiler */
								new Estado(imageID = "telefono-14", audio = "mentiroso-de-mierda", transiciones = ["intro-quiz2", "videojuego-0"]),
							/** Dejá de hacerte el boludo */
							new Estado(imageID = "telefono-13", audio = "quien-cojones-te-crees-que-eres", transiciones = ["intro-quiz2", "videojuego-0"]),
						/** I don't have hot water */
						new Estado(imageID = "telefono-12", audio = "que-dices", transiciones = ["intro-quiz2", "videojuego-0"]),
					/** So */
					new Estado(imageID = "telefono-11", audio = "eres-imbecil", transiciones = ["intro-quiz2", "videojuego-0"]),
				/** Tomar una ducha fría */
				new Estado(imageID = "chad-ducha", audio = "chad-1", transiciones = ["ducha-1", "ducha-1"]),
				new Estado(imageID = "ducha-1", transiciones = ["ejercicio-0", "videojuego-3"]),
					/** Estudiar para el examen */
					new Estado(imageID = "ejercicio-0", transiciones = ["ejercicio-1", "ejercicio-2"]),
						/** Aplicar la fórmula */
						new Estado(imageID = "ejercicio-1"),
							/** ... */
						/** Deducir el procedimiento */
						new Estado(imageID = "ejercicio-2", audio = "chad-2", transiciones = ["ejercicio-3", "ejercicio-4"]),
							/** Separar las variables */
							new Estado(imageID = "ejercicio-3", transiciones = ["ejercicio-4", "chad-ending"]),
								/** Demostrarlo */
								/** Final chad 1 */
								new Estado(imageID = "chad-ending", audio = "chad-3", transiciones = ["creditos", "creditos"]),
								/** Usar la regla del producto para derivadas */
									new Estado(imageID = "ejercicio-4", transiciones = ["ejercicio-5", "ejercicio-5"]),
									new Estado(imageID = "ejercicio-5", transiciones = ["ejercicio-6", "ejercicio-6"]),
									new Estado(imageID = "ejercicio-6"),
									/** ... */
					/** Trabajar en tu proyecto */
					new Estado(imageID = "videojuego-3", transiciones = ["minijuego", "to-be-continued"], musicaID = ["minijuego", "silence"]),
			/** Agregarle leche */
			new Estado(imageID = "leche", audio = "fridge", transiciones = ["edulcorante", "edulcorante"]),
			new Estado(imageID = "edulcorante", audio = "drop-bounce-plastic-bottle", transiciones = ["salvar-cafe", "aceptar-derrota"], musicaID = ["silence", "drama"]),
				/** Intentar salvar el café */
				new Estado(imageID = "salvar-cafe", transiciones = ["arrepentimiento", "spiderman-ending"]),
					/** Mezclar el dulce en el café */
					new Estado(imageID = "arrepentimiento", transiciones = ["cobrador-0", "cobrador-0"]),
					new Estado(imageID = "cobrador-0", audio = "disturbing-call", transiciones = ["cobrador-ending", "cobrador-salvado"]),
						new Estado(imageID = "cobrador-ending", audio = "coin-drop", transiciones = ["creditos", "creditos"]),
						new Estado(imageID = "cobrador-salvado", audio = "coin-drop", transiciones = ["cafe", "mate"]),
					/** Mezclar el café en el dulce */
					/** Final: muerte por dulce de leche */
					new Estado(imageID = "spiderman-ending", audio = "el-fin-del-hombre-arana", transiciones = ["creditos", "creditos"]),
				/** Aceptar tu derrota */
				new Estado(imageID = "aceptar-derrota", transiciones = ["derrame-escritorio", "derrame-compu"]),
					/** Estudiar para el examen */
					new Estado(imageID = "derrame-escritorio", audio = "mad-world-kid"),
						/** ... */
					/** Trabajar en tu proyecto */
					new Estado(imageID = "derrame-compu", audio = "mad-world-kid", transiciones = ["to be continued", "compu-caida"]),
						/** ... */
						/** Sucumbir a la desesperación */
						new Estado(imageID = "compu-caida", transiciones = ["suicido-ending", "zombie-ending"]),
							/** Saltar por la ventana */
							/** Final: muerte por desesperación */
							new Estado(imageID = "suicido-ending", transiciones = ["creditos", "creditos"]),
							/** No saltar */
							/** Final: muerte en vida */
							new Estado(imageID = "zombie-ending", transiciones = ["creditos", "creditos"]),
		/** Mate */
		new Estado(imageID = "mate", transiciones = ["mate-bueno", "mate-quemao"]),
			/** 348 Kelvin */
			new Estado(imageID = "mate-bueno", audio = 'que-rico-esta-este-mate', transiciones = ["intro-quiz3", "videojuego-1"]),
				/** Estudiar para el examen */
				new Estado(imageID = "intro-quiz3", transiciones = ["quiz3-0", "quiz3-0"], musicaID = ["quiz", "quiz"]),
				/** Acá arranca el segundo quiz */
				new Estado(imageID = "quiz3-0", transiciones = ["quiz3-1", "quiz3-1"], auxiliar = 1),
				new Estado(imageID = "quiz3-1", transiciones = ["quiz3-2", "quiz3-2"], auxiliar = 0),
				new Estado(imageID = "quiz3-2", transiciones = ["quiz3-3", "quiz3-3"], auxiliar = 1),
				new Estado(imageID = "quiz3-3", transiciones = ["quiz3-wollok", "quiz3-wollok"], auxiliar = 0),
				new Estado(imageID = "quiz3-wollok", transiciones = ["tocan-puerta-0", "tocan-puerta-0"], auxiliar = 1, musicaID = ["quiz", "quiz"]),
				/** Acá termina el segundo quiz */
				new Estado(imageID = "tocan-puerta-0", audio = "toctoc", transiciones = ["abrir-puerta-0", "no-abrir-puerta-0"], musicaID = ["terror", "terror"]),
					/** Abrir */
					new Estado(imageID = "abrir-puerta-0", transiciones = ["abrir-puerta-1", "abrir-puerta-1"]),
					new Estado(imageID = "abrir-puerta-1", audio = "puerta-abre", transiciones = ["filosofia-ending", "abrir-puerta-2"], musicaID = ["terror", "silence"]),
						/** Pascal */
						/** Final: muerte filosófica */
						new Estado(imageID = "filosofia-ending", audio = "filosofia-ending", transiciones = ["creditos", "creditos"]),
						/** Wollok */
						new Estado(imageID = "abrir-puerta-2", audio = "profe", transiciones = ["facu-aula", "facu-aula"], musicaID = ["terror", "terror"]),
						new Estado(imageID = "facu-aula", audio = "campana", transiciones = ["facu-recorrer", "facu-clase"]),
							/** Decides salir corriendo */
							new Estado(imageID = "facu-recorrer", transiciones = ["facu-vaso", "to-be-continued"]),
								/** Recorrer los pasillos de la facu */
								new Estado(imageID = "facu-vaso", transiciones = ["dilema-supremo", "anti-ecologimo-ending"]),
									/** Lo agarrás */
									new Estado(imageID = "dilema-supremo"),
										/** ... */
									/** Lo ignorás */
									/** Final: anti-ecologismo */
									new Estado(imageID = "anti-ecologimo-ending", audio = "anti-ecologismo-ending", transiciones = ["creditos", "creditos"]),
								/** Regresar a casa */
								/** ... */
							/** Te quedas */
							new Estado(imageID = "facu-clase", transiciones = ["facu-vaso", "to-be-continued"]),
					/** No abrir */
					new Estado(imageID = "no-abrir-puerta-0", audio = "toctoc-1", transiciones = ["abrir-puerta-0", "no-abrir-puerta-1"]),
						/** No abrir */
						new Estado(imageID = "no-abrir-puerta-1", audio = "toctoc-2", transiciones = ["abrir-puerta-0", "no-abrir-puerta-2"], musicaID = ["silence", "terror"]),
							/** No abrir */
							new Estado(imageID = "no-abrir-puerta-2", transiciones = ["no-abrir-puerta-3", "no-abrir-puerta-3"]),
							new Estado(imageID = "no-abrir-puerta-3", transiciones = ["no-abrir-puerta-4", "no-abrir-puerta-4"]),
							new Estado(imageID = "no-abrir-puerta-4", audio = "jump-scare", transiciones = ["facu-aula", "facu-aula"]),
				/** Trabajar en tu proyecto */
				new Estado(imageID = "videojuego-1", transiciones = ["minijuego", "videojuego-2"], musicaID = ["minijuego", "silence"]),
				new Estado(imageID = "videojuego-2", transiciones = ["videojuego-bombas", "videojuego-ranas"]),
				new Estado(imageID = "videojuego-bombas"),
					/** ... */
				new Estado(imageID = "videojuego-ranas"),
					/** ... */
			/** Hervir el agua */
			new Estado(imageID = "mate-quemao", audio = 'thunder'),
				/** ... */
		new EstadoMinijuego(imageID = "minijuego", audio="monomovimiento", transiciones=[]),
		/** To be continued... */
		new Estado(imageID = "to-be-continued", audio = "roundabout", transiciones = ["creditos", "creditos"]),
		/** Créditos */
		new Estado(imageID = "creditos", audio = "in-the-end", transiciones = ["resultado-0", "resultado-1", "resultado-2", "resultado-2", "resultado-2", "resultado-3", "resultado-3", "resultado-4"])
	]
}
		