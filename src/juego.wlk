import wollok.game.*
import tree.*

/** La pantalla tiene un atributo posición y una imagen */
object pantalla {
	var property position = game.at(0,0)
	var property image = "assets/imagen-quiz-0.png"
}


/** Música */
const silence = game.sound("assets/silence.mp3")
const quiz = game.sound("assets/dreamscape.mp3")
const terror = game.sound("assets/horror-background-atmosphere.mp3")
const drama = game.sound("assets/gnossienne.mp3")
const flaco = game.sound("assets/amenabar.mp3")
const kevin = game.sound("assets/not-as-it-seems.mp3")
const minijuego = game.sound("assets/minijuego.mp3")


object juego {
	/** Variable auxilar que almacena 0 ("Left") o 1 ("Right") dependiendo de la última tecla que presionó el jugador */
	var property playerInput = 0
	/** Variable que contiene la cantidad de preguntadas acertadas por el jugador */
	var property puntaje = 0
	/** Sonido de cada nodo/pantalla */
	var property sonidoPantalla = game.sound("assets/silence.mp3")
	/** Variable que apunta al estado actual */
	var property estadoActual = quiz_0
	
	
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
		estadoActual.transicion()
		/** Reproduce el sonido del nuevo estado */
		self.cambioSonido(game.sound("assets/"+estadoActual.audio()+".mp3"))
		game.schedule(0, {sonidoPantalla.play()})
		/** Actualiza la pantalla */
		pantalla.image("assets/imagen-"+estadoActual.imageID()+".png")
	}
	
	/** Método para iniciar las transiciones de los estados */
	method iniciarTransiciones() {
		quiz_0.definirTransiciones([quiz_1, quiz_1])
		quiz_1.definirTransiciones([quiz_2, quiz_2])
		quiz_2.definirTransiciones([quiz_3, quiz_3])
		quiz_3.definirTransiciones([quiz_4, quiz_4])
		quiz_4.definirTransiciones([quiz_5, quiz_5])
		quiz_5.definirTransiciones([quiz_6, quiz_6])
		quiz_6.definirTransiciones([resultado_0, resultado_1, resultado_2, resultado_2, resultado_2, resultado_3, resultado_3, resultado_4])
		resultado_0.definirTransiciones([cafe, mate])
		resultado_1.definirTransiciones([cafe, mate])
		resultado_2.definirTransiciones([cafe, mate])
		resultado_3.definirTransiciones([cafe, mate])
		resultado_4.definirTransiciones([cafe, mate])
		cafe.definirTransiciones([chad_cafe_solo, leche])
		chad_cafe_solo.definirTransiciones([ducha_0, ducha_0])
		ducha_0.definirTransiciones([telefono_0, chad_ducha])
		telefono_0.definirTransiciones([telefono_01, telefono_11])
		telefono_01.definirTransiciones([telefono_02, telefono_12])
		telefono_02.definirTransiciones([telefono_03, telefono_13])
		telefono_03.definirTransiciones([telefono_04, telefono_14])
		telefono_04.definirTransiciones([telefono_05, telefono_15])
		telefono_05.definirTransiciones([telefono_06, telefono_16])
		telefono_06.definirTransiciones([telefono_06])
		telefono_16.definirTransiciones([creditos, creditos])
		telefono_15.definirTransiciones([intro_quiz2, no_es_un_juego_0])
		intro_quiz2.definirTransiciones([quiz2_0, quiz2_0])
		quiz2_0.definirTransiciones([quiz2_1, quiz2_1])
		quiz2_1.definirTransiciones([quiz2_2, quiz2_2])
		quiz2_2.definirTransiciones([quiz2_3, quiz2_3])
		quiz2_3.definirTransiciones([quiz2_caca, quiz2_caca])
		quiz2_caca.definirTransiciones([suena_telefono_0, suena_telefono_0])
		suena_telefono_0.definirTransiciones([contesta_telefono_0, suena_telefono_1])
		contesta_telefono_0.definirTransiciones([contesta_telefono_1, contesta_telefono_1])
		contesta_telefono_1.definirTransiciones([contesta_telefono_apiadarse_0, contesta_telefono_que_se_cague_0])
		contesta_telefono_apiadarse_0.definirTransiciones([contesta_telefono_apiadarse_1, contesta_telefono_apiadarse_1])
		contesta_telefono_que_se_cague_0.definirTransiciones([contesta_telefono_que_se_cague_1, contesta_telefono_que_se_cague_1])
		suena_telefono_1.definirTransiciones([contesta_telefono_0, vagabundo_ending])
		videojuego_0.definirTransiciones([no_es_un_juego_0, no_es_un_juego_0])
		no_es_un_juego_0.definirTransiciones([no_es_un_juego_1, no_es_un_juego_1])
		no_es_un_juego_1.definirTransiciones([libertad_ending, no_es_un_juego_2])
		no_es_un_juego_2.definirTransiciones([final_juego_0, final_juego_0])
		final_juego_0.definirTransiciones([final_juego_1, final_juego_1])
		final_juego_1.definirTransiciones([final_juego_2, final_juego_2])
		final_juego_2.definirTransiciones([final_juego_3, final_juego_3])
		final_juego_3.definirTransiciones([final_juego_4, final_juego_4])
		final_juego_4.definirTransiciones([final_juego_5, final_juego_5])
		final_juego_5.definirTransiciones([final_juego_6, final_juego_6])
		final_juego_6.definirTransiciones([final_juego_7, final_juego_7])
		telefono_14.definirTransiciones([intro_quiz2, videojuego_0])
		telefono_13.definirTransiciones([intro_quiz2, videojuego_0])
		telefono_12.definirTransiciones([intro_quiz2, videojuego_0])
		telefono_11.definirTransiciones([intro_quiz2, videojuego_0])
		chad_ducha.definirTransiciones([ducha_1, ducha_1])
		ducha_1.definirTransiciones([ejercicio_0, videojuego_3])
		ejercicio_0.definirTransiciones([ejercicio_1, ejercicio_2])
		ejercicio_2.definirTransiciones([ejercicio_3, ejercicio_4])
		ejercicio_3.definirTransiciones([ejercicio_4, chad_ending])
		ejercicio_4.definirTransiciones([ejercicio_5, ejercicio_5])
		ejercicio_5.definirTransiciones([ejercicio_6, ejercicio_6])
		videojuego_3.definirTransiciones([mono_instrucciones, to_be_continued])
		leche.definirTransiciones([edulcorante, edulcorante])
		edulcorante.definirTransiciones([salvar_cafe, aceptar_derrota])
		salvar_cafe.definirTransiciones([arrepentimiento, spiderman_ending])
		arrepentimiento.definirTransiciones([cobrador_0, cobrador_0])
		cobrador_0.definirTransiciones([cobrador_ending, cobrador_salvado])
		aceptar_derrota.definirTransiciones([derrame_escritorio, derrame_compu])
		derrame_compu.definirTransiciones([to_be_continued, compu_caida])
		compu_caida.definirTransiciones([suicidio_ending, zombie_ending])
		
		mate.definirTransiciones([mate_bueno, mate_quemao])
		mate_bueno.definirTransiciones([intro_quiz3, videojuego_1])
		intro_quiz3.definirTransiciones([quiz3_0, quiz3_0])
		quiz3_0.definirTransiciones([quiz3_1, quiz3_1])
		quiz3_1.definirTransiciones([quiz3_2, quiz3_2])
		quiz3_2.definirTransiciones([quiz3_3, quiz3_3])
		quiz3_3.definirTransiciones([quiz3_wollok, quiz3_wollok])
		quiz3_wollok.definirTransiciones([tocan_puerta_0, tocan_puerta_0])
		tocan_puerta_0.definirTransiciones([abrir_puerta_0, no_abrir_puerta_0])
		abrir_puerta_0.definirTransiciones([abrir_puerta_1, abrir_puerta_1])
		abrir_puerta_1.definirTransiciones([filosofia_ending, abrir_puerta_2])
		abrir_puerta_2.definirTransiciones([facu_aula, facu_aula])
		facu_aula.definirTransiciones([facu_recorrer, facu_aula])
		facu_recorrer.definirTransiciones([facu_vaso, to_be_continued])
		facu_vaso.definirTransiciones([dilema_supremo, anti_ecologimo_ending])
		no_abrir_puerta_0.definirTransiciones([abrir_puerta_0, no_abrir_puerta_1])
		no_abrir_puerta_1.definirTransiciones([abrir_puerta_0, no_abrir_puerta_2])
		no_abrir_puerta_2.definirTransiciones([no_abrir_puerta_3, no_abrir_puerta_3])
		no_abrir_puerta_3.definirTransiciones([no_abrir_puerta_4, no_abrir_puerta_4])
		no_abrir_puerta_4.definirTransiciones([facu_aula, facu_aula])
		videojuego_1.definirTransiciones([mono_instrucciones, videojuego_2])
		videojuego_2.definirTransiciones([videojuego_bombas, videojuego_ranas])
		
		mono_instrucciones.definirTransiciones([minijuego_0, minijuego_0])
		minijuego_0.definirTransiciones([])
		to_be_continued.definirTransiciones([creditos, creditos])
		creditos.definirTransiciones([resultado_0, resultado_1, resultado_2, resultado_2, resultado_2, resultado_3, resultado_3, resultado_4])
	}
	
	method init() {
		/** Ancho de la pantalla (en celdas) */
		game.width(32)
		/** Alto de la pantalla (en celdas) */
  		game.height(28)
  		/** Tamaño de la celda (en píxeles) */
  		game.cellSize(32)
  		/** Título de la ventana del juego */
  		game.title("The Big Quiz")
  		/** Fondo del juego */
  		game.boardGround("assets/black.jpg")
  		/** Agrega la imagen de la pantalla */
  		game.addVisual(pantalla)
  		
  		self.iniciarTransiciones()
  		
  		/** Configura la música para que suene en loop */
  		silence.shouldLoop(true)
		quiz.shouldLoop(true)
		/** Ajusta el volumen de los sonidos */
		quiz.volume(0.03)
		terror.volume(0.25)
		drama.volume(0.10)
		flaco.volume(0.07)
		kevin.volume(0.15)
		/** Reproduce la música del quiz */
		game.schedule(0, {quiz.play()})
		
		
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
