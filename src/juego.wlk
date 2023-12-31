import wollok.game.*
import tree.*
import musica.*

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
	var property estadoActual = quiz_0

	method inicializarMusica() {
		
		silence.inicializar()
		quiz.inicializar()
		terror.inicializar()
		kevin.inicializar()
		minijuego.inicializar()
		hero.inicializar()
		chad.inicializar()
		last_resort.inicializar()
		zombie.inicializar()
		my_way.inicializar()
		tension.inicializar()
		what_you_deserve.inicializar()
		untitled.inicializar()
		eminem.inicializar()
		kevin2.inicializar()
		evanescence.inicializar()
		in_the_end.inicializar()
		
		/** Configura la música para que suene en loop */
  		silence.shouldLoop(true)
		quiz.shouldLoop(true)
	}
	
	/** Método para incrementar el puntaje */
	method incrementarPuntaje() {
		puntaje++
	}
	
	/** Método para reiniciar el puntaje */
	method reiniciarPuntaje() {
		puntaje = 0
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
		estadoActual.iniciar()
		/** Reproduce el sonido del nuevo estado */
		self.cambioSonido(game.sound("assets/"+estadoActual.audio()+".mp3"))
		game.schedule(0, {sonidoPantalla.play()})
		/** Actualiza la pantalla */
		pantalla.image("assets/imagen-"+estadoActual.imageID()+".png")
	}
	
	/** Método para iniciar las transiciones de los estados */
	method inicializarTransiciones() {
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

		telefono_06.definirTransiciones([intro_quiz4, videojuego2_1])

		intro_quiz4.definirTransiciones([quiz4_0, quiz4_0])
		quiz4_0.definirTransiciones([quiz4_1, quiz4_1])
		quiz4_1.definirTransiciones([quiz4_2, quiz4_2])
		quiz4_2.definirTransiciones([quiz4_3, quiz4_3])
		quiz4_3.definirTransiciones([quiz4_wollok, quiz4_wollok])
		quiz4_wollok.definirTransiciones([llaman_puerta_0, llaman_puerta_0])
		
		llaman_puerta_0.definirTransiciones([llaman_puerta_1, llaman_puerta_1])
		llaman_puerta_1.definirTransiciones([llaman_puerta_2, llaman_puerta_2])
		llaman_puerta_2.definirTransiciones([filosofia_ending, abrir_puerta_2])

		videojuego2_1.definirTransiciones([mono_instrucciones2, videojuego2_2])
		
		mono_instrucciones2.definirTransiciones([minijuego2_0, minijuego2_0])
		minijuego2_0.definirTransiciones([])
		
		mono_muerto2_0.definirTransiciones([llaman_puerta_0_j, llaman_puerta_0_j])
		
		mono_muerto2_1.definirTransiciones([llaman_puerta_0_j, llaman_puerta_0_j])
		
		videojuego2_2.definirTransiciones([videojuego2_bombas, videojuego2_ranas])
		
		videojuego2_bombas.definirTransiciones([llaman_puerta_0_j, llaman_puerta_0_j])
		videojuego2_ranas.definirTransiciones([llaman_puerta_0_j, llaman_puerta_0_j])
		
		llaman_puerta_0_j.definirTransiciones([llaman_puerta_1_j, llaman_puerta_1_j])
		llaman_puerta_1_j.definirTransiciones([llaman_puerta_2_j, llaman_puerta_2_j])
		llaman_puerta_2_j.definirTransiciones([filosofia_ending, abrir_puerta_2_j])
		
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
		contesta_telefono_apiadarse_1.definirTransiciones([examen_0, examen_0])

		contesta_telefono_que_se_cague_0.definirTransiciones([contesta_telefono_que_se_cague_1, contesta_telefono_que_se_cague_1])
		contesta_telefono_que_se_cague_1.definirTransiciones([examen_0, examen_0])

		suena_telefono_1.definirTransiciones([contesta_telefono_0, vagabundo_ending])

		videojuego_0.definirTransiciones([no_es_un_juego_0, no_es_un_juego_0])

		no_es_un_juego_0.definirTransiciones([no_es_un_juego_1, no_es_un_juego_1])
		no_es_un_juego_1.definirTransiciones([libertad_ending, no_es_un_juego_2])

		no_es_un_juego_2.definirTransiciones([ir_a_dormir_juego, ir_a_dormir_juego])
		ir_a_dormir_juego.definirTransiciones([juego_0, juego_0])

		telefono_14.definirTransiciones([intro_quiz2, videojuego_0])
		telefono_13.definirTransiciones([intro_quiz2, videojuego_0])
		telefono_12.definirTransiciones([intro_quiz2, videojuego_0])
		telefono_11.definirTransiciones([intro_quiz2, videojuego_0])
		
		chad_ducha.definirTransiciones([ducha_1, ducha_1])
		ducha_1.definirTransiciones([ejercicio_0, videojuego_3])
		
		ejercicio_0.definirTransiciones([ejercicio_1, ejercicio_2])
		
		ejercicio_1.definirTransiciones([ejercicio_8, ejercicio_8])
		ejercicio_8.definirTransiciones([ir_a_dormir_examen, ir_a_dormir_examen])
		ir_a_dormir_examen.definirTransiciones([examen_0, examen_0])
		
		ejercicio_2.definirTransiciones([ejercicio_3, ejercicio_4])
		
		ejercicio_2.definirTransiciones([ejercicio_3, ejercicio_4])
		
		ejercicio_3.definirTransiciones([ejercicio_4, chad_ending])
		
		ejercicio_4.definirTransiciones([ejercicio_5, ejercicio_5])
		ejercicio_5.definirTransiciones([ejercicio_6, ejercicio_6])
		ejercicio_6.definirTransiciones([ejercicio_7, ejercicio_7])
		ejercicio_7.definirTransiciones([ir_a_dormir_examen, ir_a_dormir_examen])
		
		videojuego_3.definirTransiciones([mono_instrucciones3, videojuego_raycasting_0])
		
		videojuego_raycasting_0.definirTransiciones([videojuego_raycasting_1, videojuego_raycasting_1])
		videojuego_raycasting_1.definirTransiciones([videojuego_raycasting_2, chad_ending2])
				
		videojuego_raycasting_2.definirTransiciones([juego_0, juego_0])

		mono_instrucciones3.definirTransiciones([minijuego3_0, minijuego3_0])
		minijuego3_0.definirTransiciones([])
		
		mono_muerto3_0.definirTransiciones([ir_a_dormir_juego, ir_a_dormir_juego])
		
		mono_muerto3_1.definirTransiciones([ir_a_dormir_juego, ir_a_dormir_juego])
		
		leche.definirTransiciones([edulcorante, edulcorante])
		edulcorante.definirTransiciones([salvar_cafe, aceptar_derrota])
		salvar_cafe.definirTransiciones([arrepentimiento, spiderman_ending])
		arrepentimiento.definirTransiciones([cobrador_0, cobrador_0])
		cobrador_0.definirTransiciones([cobrador_ending, cobrador_salvado])
		cobrador_ending.definirTransiciones([creditos, creditos])
		cobrador_salvado.definirTransiciones([cafe, mate])
		
		aceptar_derrota.definirTransiciones([derrame_escritorio, derrame_compu])
		
		derrame_escritorio.definirTransiciones([derrame_escritorio_1, desesperanza_ending])
		
		derrame_escritorio_1.definirTransiciones([examen_0, examen_0])
		
		derrame_compu.definirTransiciones([derrame_compu_1, compu_caida])
		
		derrame_compu_1.definirTransiciones([juego_0, juego_0])
		
		compu_caida.definirTransiciones([suicidio_ending, zombie_ending])
		
		libertad_ending.definirTransiciones([creditos, creditos])
		vagabundo_ending.definirTransiciones([creditos, creditos])
		spiderman_ending.definirTransiciones([creditos, creditos])
		suicidio_ending.definirTransiciones([creditos, creditos])
		zombie_ending.definirTransiciones([creditos, creditos])
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
		facu_aula.definirTransiciones([facu_vaso, facu_vaso])
		facu_vaso.definirTransiciones([dilema_supremo, anti_ecologimo_ending])
		dilema_supremo.definirTransiciones([fin_del_mundo_ending, messi_ending])
		messi_ending.definirTransiciones([examen_0_sueno, examen_0_sueno])
		
		abrir_puerta_2_j.definirTransiciones([facu_aula_j, facu_aula_j])
		facu_aula_j.definirTransiciones([facu_vaso_j, facu_vaso_j])
		facu_vaso_j.definirTransiciones([dilema_supremo_j, anti_ecologimo_ending])
		dilema_supremo_j.definirTransiciones([fin_del_mundo_ending, messi_ending_j])
		messi_ending_j.definirTransiciones([juego_0_sueno, juego_0_sueno])		
		
		no_abrir_puerta_0.definirTransiciones([abrir_puerta_0, no_abrir_puerta_1])
		no_abrir_puerta_1.definirTransiciones([abrir_puerta_0, no_abrir_puerta_2])
		no_abrir_puerta_2.definirTransiciones([no_abrir_puerta_3, no_abrir_puerta_3])
		no_abrir_puerta_3.definirTransiciones([no_abrir_puerta_4, no_abrir_puerta_4])
		no_abrir_puerta_4.definirTransiciones([facu_aula, facu_aula])
		
		videojuego_1.definirTransiciones([mono_instrucciones, videojuego_2])
		mono_instrucciones.definirTransiciones([minijuego_0, minijuego_0])
		minijuego_0.definirTransiciones([])
		
		mono_muerto_0.definirTransiciones([ir_a_dormir_juego, ir_a_dormir_juego])
		
		mono_muerto_1.definirTransiciones([ir_a_dormir_juego, ir_a_dormir_juego])
		
		videojuego_2.definirTransiciones([videojuego_bombas, videojuego_ranas])

		videojuego_bombas.definirTransiciones([ir_a_dormir_juego, ir_a_dormir_juego])
		videojuego_ranas.definirTransiciones([ir_a_dormir_juego, ir_a_dormir_juego])
		
		chad_ending.definirTransiciones([creditos, creditos])
		
		mate_quemao.definirTransiciones([corte_luz, corte_luz])
		corte_luz.definirTransiciones([mate_ending, mate_ending])
		
		examen_0_sueno.definirTransiciones([examen_1, examen_1])
		examen_0.definirTransiciones([examen_1, examen_1])
		examen_1.definirTransiciones([examen_2, exament_ending])
		examen_2.definirTransiciones([examen_3, examen_3])
		examen_3.definirTransiciones([quiz_examen_0, quiz_examen_0])
		quiz_examen_0.definirTransiciones([quiz_examen_1, quiz_examen_1])
		quiz_examen_1.definirTransiciones([quiz_examen_2, quiz_examen_2])
		quiz_examen_2.definirTransiciones([quiz_examen_3, quiz_examen_3])
		quiz_examen_3.definirTransiciones([quiz_examen_4, quiz_examen_4])
		quiz_examen_4.definirTransiciones([quiz_examen_5, quiz_examen_5])
		quiz_examen_5.definirTransiciones([quiz_examen_6, quiz_examen_6])
		quiz_examen_6.definirTransiciones([quiz_examen_7, quiz_examen_7])
		quiz_examen_7.definirTransiciones([quiz_examen_8, quiz_examen_8])
		quiz_examen_8.definirTransiciones([quiz_examen_9, quiz_examen_9])
		quiz_examen_9.definirTransiciones([quiz_examen_10, quiz_examen_10])
		quiz_examen_10.definirTransiciones([examen_4, examen_4])
		examen_4.definirTransiciones([examen_5, examen_5])
		examen_5.definirTransiciones([examen_6, examen_6])
		examen_6.definirTransiciones([examen_7, examen_7])
		examen_7.definirTransiciones([examen_8, examen_8])
		examen_8.definirTransiciones([examen_9, examen_9])
		examen_9.definirTransiciones([recursa_ending, recursa_ending, recursa_ending, recursa_ending, recursa_ending, recursa_ending, recursa_ending, recursa_ending, recursa_ending, recursa_ending, recursa_ending, recursa_ending, recursa_ending, regulariza_ending, regulariza_ending, regulariza_ending, regulariza_ending, regulariza_ending, promocion_ending, promocion_ending, promocion_ending, promocion_ending, promocion_ending, promocion_ending])
		
		juego_0_sueno.definirTransiciones([final_juego_0, final_juego_0])
		juego_0.definirTransiciones([final_juego_0, final_juego_0])
		final_juego_0.definirTransiciones([final_juego_1, final_juego_1])
		final_juego_1.definirTransiciones([final_juego_2, final_juego_2])
		final_juego_2.definirTransiciones([final_juego_3, final_juego_3])
		final_juego_3.definirTransiciones([final_juego_4, final_juego_4])
		final_juego_4.definirTransiciones([final_juego_5, final_juego_5])
		final_juego_5.definirTransiciones([final_juego_6, final_juego_6])
		final_juego_6.definirTransiciones([final_juego_7, final_juego_7])
		final_juego_7.definirTransiciones([final_juego_8, final_juego_8])
		final_juego_8.definirTransiciones([final_juego_9, final_juego_9])
		final_juego_9.definirTransiciones([final_juego_10, final_juego_10])
		final_juego_10.definirTransiciones([recursa_juego_raycasting, recursa_juego_mono, regulariza_juego, promocion_juego])

		promocion_juego.definirTransiciones([promocion_juego_ending, promocion_juego_ending])
		
		recursa_juego_raycasting.definirTransiciones([recursa_juego_ending, recursa_juego_ending])
		
		recursa_juego_mono.definirTransiciones([recursa_juego_ending, recursa_juego_ending])
		
		regulariza_juego.definirTransiciones([regulariza_juego_ending, regulariza_juego_ending])
				
		to_be_continued.definirTransiciones([creditos, creditos])
		
		creditos.definirTransiciones([quiz_0, quiz_0])
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
  		
  		self.inicializarTransiciones()

		self.inicializarMusica()
		
		/** Reproduce la música del quiz */
		game.schedule(0, {quiz.alternar()})
		
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
