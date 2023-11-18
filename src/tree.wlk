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
	var property transiciones = [/** Left, Right */]
	/** Variable auxiliar cuya utilidad se define en la función del estado siguiente */
	var property auxiliar = null
	/** musicaID es la key del diccionario de canciones del juego */
	var property musica = [silence, silence]

	method iniciar(){}

	method definirTransiciones(lista) {
		transiciones = lista
	}

	/** Método que reproduce o pausa la música */
	method poneMusica() {
		/** Variable que obtiene el objeto musical */
		const music = self.musica().get(juego.playerInput())
		/** Si está pausada, la despausa */
		if (music.paused()){game.schedule(0, {music.resume()})}
		/** Si se está reproduciendo, la pausa */
		else if (music.played()) {game.schedule(0, {music.pause()})}
		/** Si no, la reproduce */
		else {game.schedule(0, {music.play()})}
	}
	
	/** Reproduce un sonido de transición */
	method sonidoDeTransicion() {
		game.schedule(0, {(game.sound("assets/glitch-"+(0).randomUpTo(2).truncate(0).toString()+".mp3").play())})
	}
	
	/** Función del estado siguiente */
	method estadoSiguiente() {
		/** Por defecto la transición es al elemento de la lista de transiciones que se corresponde con el playerInput */
		juego.cambioEstado(self.transiciones().get(juego.playerInput()))
	}
	
	method transicion() {
		/** Llama al método de cambiar el estado del estado actual */
		self.estadoSiguiente()
		/** Llama al método de reproducir el sonido de transición del estado actual */
		self.sonidoDeTransicion()
		/** Llama al método de poner música del estado actual */
		self.poneMusica()
		/** Detiene el sonido de la pantalla previa */
		if (juego.sonidoPantalla().played()) {juego.sonidoPantalla().stop()}
	}
}

class EstadoQuiz inherits Estado {
	
	override method sonidoDeTransicion() {
		/** Si el jugador eligió la respuesta correcta, suena "yay" */
		if (juego.playerInput() == self.auxiliar()) {
			game.schedule(0, {(game.sound("assets/correct-yay.mp3").play())})
		}
		/** Si el jugador eligió la respuesta incorrecta, suena "buzzer" */
		else {
			game.schedule(0, {(game.sound("assets/incorrect-buzzer.mp3").play())})
		}
	}
		
	override method transicion() {
		/** Incrementa el puntaje */
		if (juego.playerInput() == self.auxiliar()) {
			juego.incrementarPuntaje()
		}
		super()
	}
}

class EstadoQuizWollok inherits Estado {
	
	override method sonidoDeTransicion() {
		/** Si el jugador eligió la respuesta correcta, suena "SIII!" */
		if (juego.playerInput() == self.auxiliar()) {
			game.schedule(0, {(game.sound("assets/SIII!.mp3").play())})
			}
		/** Si el jugador eligió la respuesta incorrecta, suena "NOOO!" */
		else {
			game.schedule(0, {(game.sound("assets/NOOO!.mp3").play())})
		}
	}
}

class EstadoQuiz6 inherits EstadoQuiz {
		
	/** La transición depende del puntaje */
	override method estadoSiguiente() {
		juego.cambioEstado(self.transiciones().get(juego.puntaje()))
	}
}

class EstadoCreditos inherits Estado {
		
	/** La transición depende del puntaje */
	override method estadoSiguiente() {
		juego.cambioEstado(self.transiciones().get(juego.puntaje()))
	}
}

class EstadoCobranza inherits Estado {
	/** Si está en el estado de cobranza, la transición es al azar */
		override method estadoSiguiente() {
			juego.cambioEstado(self.transiciones().anyOne())
		}
}

class EstadoMinijuego inherits Estado {
	const items = []
	var nuevoItem = 0
	var dificultad = 1
	
	override method estadoSiguiente(){
		if(puntaje.valor() < 0){
			juego.cambioEstado(mono_muerto_0)
		}else if (puntaje.valor() >= 30){
			juego.cambioEstado(mono_muerto_1)
		}
	}
	override method iniciar() {
		game.addVisual(jugador)
		game.addVisual(puntaje)
		keyboard.a().onPressDo({
			jugador.moverIzq()
		})
		keyboard.d().onPressDo({
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
		
		if(puntaje.valor() >= 15) {
			dificultad = 2
		} 
		if(puntaje.valor() < 0 or puntaje.valor() >= 30) {
			self.fin()
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
	method fin(){
		game.removeTickEvent("actualizar")
		items.forEach({item => 
			game.removeVisual(item)
		})
		game.removeVisual(jugador)
		game.removeVisual(puntaje)
		juego.actualizar()
	}
}


/** Estados del juego. Cada uno corresponde a una pantalla */

/** Acá arranca el quiz */
/** El valor de auxiliar representa la respuesta correcta */
const quiz_0 = new EstadoQuiz(imageID = "quiz-0", auxiliar = 0)
const quiz_1 = new EstadoQuiz(imageID = "quiz-1", auxiliar = 1)
const quiz_2 = new EstadoQuiz(imageID = "quiz-2", auxiliar = 1)
const quiz_3 = new EstadoQuiz(imageID = "quiz-3", auxiliar = 0)
const quiz_4 = new EstadoQuiz(imageID = "quiz-4", auxiliar = 1)
const quiz_5 = new EstadoQuiz(imageID = "quiz-5", auxiliar = 1)
const quiz_6 = new EstadoQuiz6(imageID = "quiz-6", auxiliar = 0, musica = [quiz, quiz])

/** Acá termina el quiz */
/** Resultados del primer quiz */
const resultado_0 = new Estado(imageID = "resultado-0", audio = 'quiz-0')
const resultado_1 = new Estado(imageID = "resultado-1", audio = 'quiz-1')
const resultado_2 = new Estado(imageID = "resultado-2", audio = 'quiz-2')
const resultado_3 = new Estado(imageID = "resultado-3", audio = 'quiz-3')
const resultado_4 = new Estado(imageID = "resultado-4", audio = 'quiz-4')

/** Acá arranca la aventura */
/** Café */
const cafe = new Estado(imageID = "cafe")
const chad_cafe_solo = new Estado(imageID = "chad-cafe-solo", audio = "chad-0")
const ducha_0 = new Estado(imageID = "ducha-0")
const telefono_0 = new Estado(imageID = "telefono-0", audio = "que")
const telefono_01 = new Estado(imageID = "telefono-01", audio = "tell-me-what-you-want")
const telefono_02 = new Estado(imageID = "telefono-02", audio = "me-suda-la-polla")
const telefono_03 = new Estado(imageID = "telefono-03", audio = "es-culpa-tuya")
const telefono_04 = new Estado(imageID = "telefono-04", audio = "que-quieres-que-haga")
const telefono_05 = new Estado(imageID = "telefono-05", audio = "no-quiero")
const telefono_06 = new Estado(imageID = "telefono-06", audio = "joder")
const telefono_16 = new Estado(imageID = "telefono-16", audio = "ruptura-ending")
/** Tu servicio es desproporcional al precio */
const telefono_15 = new Estado(imageID = "telefono-15", audio = "lo-que-no-tengo-proporcional")
const intro_quiz2 = new Estado(imageID = "intro-quiz2", musica = [quiz, quiz])
const quiz2_0 = new Estado(imageID = "quiz2-0", auxiliar = 1)
const quiz2_1 = new Estado(imageID = "quiz2-1", auxiliar = 0)
const quiz2_2 = new Estado(imageID = "quiz2-2", auxiliar = 1)
const quiz2_3 = new Estado(imageID = "quiz2-3", auxiliar = 0)
/** censurado xd */
const quiz2_caca = new Estado(imageID = "quiz2-caca", audio = "audio-censurado", auxiliar = 1, musica = [quiz, quiz])
const suena_telefono_0 = new Estado(imageID = "suena-telefono-0", audio = "telefono")
const contesta_telefono_0 = new Estado(imageID = "contesta-telefono-0", audio = "me-he-dejado-las-llaves-dentro")
const contesta_telefono_1 = new Estado(imageID = "contesta-telefono-1", audio = "no-es-gracioso")
const contesta_telefono_apiadarse_0 = new Estado(imageID = "contesta-telefono-apiadarse-0", audio = "gracias-por-escuchar-mis-plegarias-tio")
const contesta_telefono_apiadarse_1 = new Estado(imageID = "contesta-telefono-apiadarse-1")
/** censurado xd */
const contesta_telefono_que_se_cague_0 = new Estado(imageID = "contesta-telefono-que-se-cague-0", audio = "audio-censurado")
const contesta_telefono_que_se_cague_1 = new Estado(imageID = "contesta-telefono-que-se-cague-1")
const suena_telefono_1 = new Estado(imageID = "suena-telefono-1", audio = "eres-un-vago-de-mierda", musica = [silence, my_way])
const vagabundo_ending = new Estado(imageID = "vagabundo-ending", audio = "vago-ending", musica = [my_way, my_way])
const videojuego_0 = new Estado(imageID = "videojuego-0")
const no_es_un_juego_0 = new Estado(imageID = "no-es-un-juego-0", audio = "como-que-un-juego")
const no_es_un_juego_1 = new Estado(imageID = "no-es-un-juego-1", audio = "esto-no-es-un-juego")
const libertad_ending = new Estado(imageID = "libertad-ending", audio = "libertad-ending")
/** NADA es un juego */
const no_es_un_juego_2 = new Estado(imageID = "no-es-un-juego-2")
const final_juego_0 = new Estado(imageID = "final-juego-0")
const final_juego_1 = new Estado(imageID = "final-juego-1", audio = "1-muy-buenas-tardes-a-todos", musica = [kevin, kevin])
const final_juego_2 = new Estado(imageID = "final-juego-2", audio = "2-get-ready")
const final_juego_3 = new Estado(imageID = "final-juego-3", audio = "audio-censurado")
const final_juego_4 = new Estado(imageID = "final-juego-4", audio = "4-dale")
const final_juego_5 = new Estado(imageID = "final-juego-5", audio = "5-el-boton-de-reset")
const final_juego_6 = new Estado(imageID = "final-juego-6", audio = "6-el-creador-de-esta-mierda")
const final_juego_7 = new Estado(imageID = "final-juego-7", audio = "7-quien-cono-es-fede", musica = [kevin, kevin])
const telefono_14 = new Estado(imageID = "telefono-14", audio = "mentiroso-de-mierda")
const telefono_13 = new Estado(imageID = "telefono-13", audio = "quien-cojones-te-crees-que-eres")
const telefono_12 = new Estado(imageID = "telefono-12", audio = "que-dices")
const telefono_11 = new Estado(imageID = "telefono-11", audio = "eres-imbecil")
const chad_ducha = new Estado(imageID = "chad-ducha", audio = "chad-1")
const ducha_1 = new Estado(imageID = "ducha-1")
const ejercicio_0 = new Estado(imageID = "ejercicio-0")
const ejercicio_1 = new Estado(imageID = "ejercicio-1")
const ejercicio_2 = new Estado(imageID = "ejercicio-2", audio = "chad-2")
const ejercicio_3 = new Estado(imageID = "ejercicio-3", musica = [silence, chad])
const chad_ending = new Estado(imageID = "chad-ending", audio = "chad-ending")
const ejercicio_4 = new Estado(imageID = "ejercicio-4")
const ejercicio_5 = new Estado(imageID = "ejercicio-5")
const ejercicio_6 = new Estado(imageID = "ejercicio-6")
/** Trabajar en tu proyecto */
const videojuego_3 = new Estado(imageID = "videojuego-3", musica = [minijuego, silence])
const leche = new Estado(imageID = "leche", audio = "fridge")
const edulcorante = new Estado(imageID = "edulcorante", audio = "drop-bounce-plastic-bottle")
const salvar_cafe = new Estado(imageID = "salvar-cafe", musica = [silence, hero])
const arrepentimiento = new Estado(imageID = "arrepentimiento", musica = [tension, tension])
const cobrador_0 = new EstadoCobranza(imageID = "cobrador-0", musica = [tension, tension])
const cobrador_ending = new Estado(imageID = "cobrador-ending", audio = "coin-drop")
const cobrador_salvado = new Estado(imageID = "cobrador-salvado", audio = "coin-drop")
const spiderman_ending = new Estado(imageID = "spiderman-ending", audio = "spiderman-ending", musica = [hero, hero])
const aceptar_derrota = new Estado(imageID = "aceptar-derrota")
const derrame_escritorio = new Estado(imageID = "derrame-escritorio", audio = "mad-world-kid")
const derrame_compu = new Estado(imageID = "derrame-compu", audio = "mad-world-kid")
const compu_caida = new Estado(imageID = "compu-caida", musica = [last_resort, zombie])
const suicidio_ending = new Estado(imageID = "suicidio-ending", audio = "suicidio-ending", musica = [last_resort, last_resort])
const zombie_ending = new Estado(imageID = "zombie-ending", audio = "zombie-ending", musica = [zombie, zombie])
/** Mate */
const mate = new Estado(imageID = "mate")
const mate_bueno = new Estado(imageID = "mate-bueno", audio = 'que-rico-esta-este-mate')
const intro_quiz3 = new Estado(imageID = "intro-quiz3", musica = [quiz, quiz])
const quiz3_0 = new Estado(imageID = "quiz3-0", auxiliar = 1)
const quiz3_1 = new Estado(imageID = "quiz3-1", auxiliar = 0)
const quiz3_2 = new Estado(imageID = "quiz3-2", auxiliar = 1)
const quiz3_3 = new Estado(imageID = "quiz3-3", auxiliar = 0)
const quiz3_wollok = new EstadoQuizWollok(imageID = "quiz3-wollok", auxiliar = 1, musica = [quiz, quiz])
const tocan_puerta_0 = new Estado(imageID = "tocan-puerta-0", audio = "toctoc", musica = [terror, terror])
const abrir_puerta_0 = new Estado(imageID = "abrir-puerta-0")
const abrir_puerta_1 = new Estado(imageID = "abrir-puerta-1", audio = "puerta-abre", musica = [terror, silence])
const filosofia_ending = new Estado(imageID = "filosofia-ending", audio = "filosofia-ending")
const abrir_puerta_2 = new Estado(imageID = "abrir-puerta-2", audio = "muy-bien", musica = [terror, terror])
const facu_aula = new Estado(imageID = "facu-aula", audio = "campana")
const facu_recorrer = new Estado(imageID = "facu-recorrer")
const facu_vaso = new Estado(imageID = "facu-vaso")
const dilema_supremo = new Estado(imageID = "dilema-supremo")
const anti_ecologimo_ending = new Estado(imageID = "anti-ecologimo-ending", audio = "anti-ecologismo-ending")
const no_abrir_puerta_0 = new Estado(imageID = "no-abrir-puerta-0", audio = "toctoc-1")
const no_abrir_puerta_1 = new Estado(imageID = "no-abrir-puerta-1", audio = "toctoc-2", musica = [silence, terror])
const no_abrir_puerta_2 = new Estado(imageID = "no-abrir-puerta-2")
const no_abrir_puerta_3 = new Estado(imageID = "no-abrir-puerta-3")
const no_abrir_puerta_4 = new Estado(imageID = "no-abrir-puerta-4", audio = "jump-scare")
const videojuego_1 = new Estado(imageID = "videojuego-1", musica = [minijuego, silence])
const videojuego_2 = new Estado(imageID = "videojuego-2")
const videojuego_bombas = new Estado(imageID = "videojuego-bombas")
const videojuego_ranas = new Estado(imageID = "videojuego-ranas")
/** Hervir el agua */
const mate_quemao = new Estado(imageID = "mate-quemao", audio = 'thunder')
/** ... */
const mono_instrucciones = new Estado(imageID="mono-instrucciones")
const minijuego_0 = new EstadoMinijuego(imageID = "minijuego", audio="monomovimiento")
const mono_muerto_0 = new Estado(imageID = "mono-muerto-0", musica=[minijuego, minijuego])
const mono_muerto_1 = new Estado(imageID = "mono-muerto-1", musica=[minijuego, minijuego])
/** To be continued... */
const to_be_continued = new Estado(imageID = "to-be-continued", audio = "roundabout")
/** Créditos */
const creditos = new EstadoCreditos(imageID = "creditos", audio = "in-the-end")



