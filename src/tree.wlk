import wollok.game.*
import juego.*

/** Estados de un autómata */
class Estado {
	/** imagenID es un entero i asociada al nombre de la imagen: "imagen-i.png" */
	var property imageID = 0
	/** Audio: se reproduce cuando aparece la pantalla */
	var property audio = "silence"
	/** Las transiciones son listas con los índices de los estados siguientes */
	var property transiciones = [/** Left, Right */]
	/** Variable auxiliar cuya utilidad se define en la función del estado siguiente */
	var property auxiliar = null
	
	var property musicaID = [0, 0]

	/** Método que reproduce o pausa la música */
	method poneMusica(input) {
		const id = [juego.silence(), juego.musicaQuiz(), juego.musicaTerror(), juego.musicaDrama(), juego.musicaFlaco()]
		const music = id.get(musicaID.get(input))
		/** Si está pausada, la despausa */
		if (music.paused()){game.schedule(0, {music.resume()})}
		/** Si se está reproduciendo, la pausa */
		else if (music.played()) {game.schedule(0, {music.pause()})}
		/** Si no, la reproduce */
		else {game.schedule(0, {music.play()})}}
	}
	


/** Autómata del juego */
object automata {
	/** Estados del juego. Cada uno corresponde a una pantalla */
	const property estados = [
		/** Acá arranca el quiz */
		/** El valor de auxiliar representa la respuesta correcta */
		new Estado(imageID = 0, transiciones = [1, 1], auxiliar = 0),
		new Estado(imageID = 1, transiciones = [2, 2], auxiliar = 1),
		new Estado(imageID = 2, transiciones = [3, 3], auxiliar = 1),
		new Estado(imageID = 3, transiciones = [4, 4], auxiliar = 0),
		new Estado(imageID = 4, transiciones = [5, 5], auxiliar = 1),
		new Estado(imageID = 5, transiciones = [6, 6], auxiliar = 1),
		new Estado(imageID = 6, transiciones = [7, 8, 9, 9, 9, 10, 10, 11], auxiliar = 0, musicaID = [1, 1]),
		/** Acá termina el quiz */
		/** Resultados del primer quiz */
		new Estado(imageID = 7,  audio = 'quiz-0', transiciones = [12, 66]),
		new Estado(imageID = 8,  audio = 'quiz-1', transiciones = [12, 66]),
		new Estado(imageID = 9,  audio = 'quiz-2', transiciones = [12, 66]),
		new Estado(imageID = 10, audio = 'quiz-3', transiciones = [12, 66]),
		new Estado(imageID = 11, audio = 'quiz-4', transiciones = [12, 66]),
		/** Acá arranca la aventura */
		/** Café */
		new Estado(imageID = 12, audio = "olha-a-hora-do-cafe", transiciones = [13, 53]),
			/** Tomar solo */
			new Estado(imageID = 13, audio = "chad-0", transiciones = [14, 14]),
			new Estado(imageID = 14, transiciones = [15, 43]),
				/** Llamar al dueño del edificio */
				new Estado(imageID = 15, audio = "que", transiciones = [16, 42]),
					/** Soy yo, man */
					new Estado(imageID = 16, audio = "tell-me-what-you-want", transiciones = [17, 41]),
						/** No tengo agua caliente */
						new Estado(imageID = 17, audio = "me-suda-la-polla", transiciones = [18, 40]),
							/** Me tenés que ayudar */
							new Estado(imageID = 18, audio = "es-culpa-tuya", transiciones = [19, 39]),
								/** Es tu edificio, hacete cargo */
								new Estado(imageID = 19, audio = "que-quieres-que-haga", transiciones = [20, 23]),
									/** Solucioname el tema del agua */
									new Estado(imageID = 20, audio = "no-quiero", transiciones = [21, 22]),
										/** ¡Dale, gordo! */
										new Estado(imageID = 21, audio = "joder"),
											/** ... */
										/** Cortar */
										/** Final: ruptura */
										new Estado(imageID = 22, audio = "ruptura-ending", transiciones = [95, 95]),
									/** Tu servicio es desproporcional al precio */
									new Estado(imageID = 23, audio = "lo-que-no-tengo-proporcional", transiciones = [24]),
										/** Estudiar para el examen */
										new Estado(imageID = 24, transiciones = [25, 25], musicaID = [1, 1]),
										/** Empieza el segundo quiz */
										new Estado(imageID = 25, transiciones = [26, 26], auxiliar = 1),
										new Estado(imageID = 26, transiciones = [27, 27], auxiliar = 0),
										new Estado(imageID = 27, transiciones = [28, 28], auxiliar = 1),
										new Estado(imageID = 28, transiciones = [29, 29], auxiliar = 0),
										new Estado(imageID = 29, audio = "quieres-que-te-haga-caca-en-la-cara", transiciones = [30, 30], auxiliar = 1, musicaID = [1, 1]),
										/** Termina el segundo quiz */
										new Estado(imageID = 30, audio = "telefono", transiciones = [31, 37]),
											/** No, no la hay */
											new Estado(imageID = 31, audio = "me-he-dejado-las-llaves-dentro", transiciones = [32, 32]),
											new Estado(imageID = 32, audio = "no-es-gracioso", transiciones = [33, 35]),
												/** Apiadarte del pobre infeliz */
												new Estado(imageID = 33, audio = "gracias-por-escuchar-mis-plegarias-tio", transiciones = [34, 34]),
												new Estado(imageID = 34, transiciones = []),
													/** Termina el día 1 */
												/** ¡Que se cague por gil! */
												new Estado(imageID = 35, audio = "me-cago-en-tus-muertos", transiciones = [36, 36]),
												new Estado(imageID = 36, transiciones = []),
													/** Termina el día 1 */
											/** Me da paja */
											new Estado(imageID = 37, audio = "eres-un-vago-de-mierda", transiciones = [31, 38]),
												/** Ser un *vago de mierda* */
												new Estado(imageID = 38, transiciones = [95, 95]),
										/** Trabajar en tu proyecto */
										/** ... */
								/** Me lo vas a descontar del alquiler */
								new Estado(imageID = 39, audio = "mentiroso-de-mierda", transiciones = [24]),
							/** Dejá de hacerte el boludo */
							new Estado(imageID = 40, audio = "quien-cojones-te-crees-que-eres", transiciones = [24]),
						/** I don't have hot water */
						new Estado(imageID = 41, audio = "que-dices", transiciones = [24]),
					/** So */
					new Estado(imageID = 42, audio = "eres-imbecil", transiciones = [24]),
				/** Tomar una ducha fría */
				new Estado(imageID = 43, audio = "chad-1", transiciones = [44, 44]),
				new Estado(imageID = 44, transiciones = [45]),
					/** Estudiar para el examen */
					new Estado(imageID = 45, transiciones = [46, 47]),
						/** Aplicar la fórmula */
						new Estado(imageID = 46, transiciones = []),
							/** ... */
						/** Deducir el procedimiento */
						new Estado(imageID = 47, audio = "chad-2", transiciones = [48, 50]),
							/** Separar las variables */
							new Estado(imageID = 48, transiciones = [49, 50]),
								/** Demostrarlo */
								/** Final chad 1 */
								new Estado(imageID = 49, audio = "chad-3", transiciones = [95, 95]),
								/** Usar la regla del producto para derivadas */
									new Estado(imageID = 50, transiciones = [51, 51]),
									new Estado(imageID = 51, transiciones = [52, 52]),
									new Estado(imageID = 52, transiciones = []),
									/** ... */
					/** Trabajar en tu proyecto */
					/** ... */
			/** Agregarle leche */
			new Estado(imageID = 53, audio = "fridge", transiciones = [54, 54]),
			new Estado(imageID = 54, audio = "drop-bounce-plastic-bottle", transiciones = [55, 60], musicaID = [0, 3]),
				/** Intentar salvar el café */
				new Estado(imageID = 55, transiciones = [56, 59]),
					/** Mezclar el dulce en el café */
					new Estado(imageID = 56, transiciones = [57, 57]),
					new Estado(imageID = 57, audio = "disturbing-call", transiciones = []),
						/** ... */
						new Estado(imageID = 58),
					/** Mezclar el café en el dulce */
					/** Final: muerte por dulce de leche */
					new Estado(imageID = 59, audio = "el-fin-del-hombre-arana", transiciones = [95, 95]),
				/** Aceptar tu derrota */
				new Estado(imageID = 60, transiciones = [61, 62]),
					/** Estudiar para el examen */
					new Estado(imageID = 61, transiciones = []),
						/** ... */
					/** Trabajar en tu proyecto */
					new Estado(imageID = 62, transiciones = [63, 63]),
						/** ... */
						/** Sucumbir a la desesperación */
						new Estado(imageID = 63, transiciones = [64, 65]),
							/** Saltar por la ventana */
							/** Final: muerte por desesperación */
							new Estado(imageID = 64, transiciones = [95, 95]),
							/** No saltar */
							/** Final: muerte en vida */
							new Estado(imageID = 65, transiciones = [95, 95]),
		/** Mate */
		new Estado(imageID = 66, transiciones = [67, 94]),
			/** 348 Kelvin */
			new Estado(imageID = 67, audio = 'que-rico-esta-este-mate', transiciones = [68, 90]),
				/** Estudiar para el examen */
				new Estado(imageID = 68, transiciones = [69, 69], musicaID = [1, 1]),
				/** Acá arranca el segundo quiz */
				new Estado(imageID = 69, transiciones = [70, 70], auxiliar = 1),
				new Estado(imageID = 70, transiciones = [71, 71], auxiliar = 0),
				new Estado(imageID = 71, transiciones = [72, 72], auxiliar = 1),
				new Estado(imageID = 72, transiciones = [73, 73], auxiliar = 0),
				new Estado(imageID = 73, transiciones = [74, 74], auxiliar = 1, musicaID = [1, 1]),
				/** Acá termina el segundo quiz */
				new Estado(imageID = 74, audio = "toctoc", transiciones = [75, 85], musicaID = [2, 2]),
					/** Abrir */
					new Estado(imageID = 75, transiciones = [76, 76]),
					new Estado(imageID = 76, audio = "puerta-abre", transiciones = [77, 78]),
						/** Pascal */
						/** Final: muerte filosófica */
						new Estado(imageID = 77, audio = "filosofia-ending", transiciones = [95, 95]),
						/** Wollok */
						new Estado(imageID = 78, audio = "profe", transiciones = [79, 79]),
						new Estado(imageID = 79, audio = "campana", transiciones = [80, 84]),
							/** Decides salir corriendo */
							new Estado(imageID = 80, transiciones = [81]),
								/** Recorrer los pasillos de la facu */
								new Estado(imageID = 81, transiciones = [82, 83]),
									/** Lo agarrás */
									new Estado(imageID = 82, transiciones = []),
										/** ... */
									/** Lo ignorás */
									/** Final: anti-ecologismo */
									new Estado(imageID = 83, audio = "anti-ecologismo-ending", transiciones = [95, 95]),
								/** Regresar a casa */
								/** ... */
							/** Te quedas */
							new Estado(imageID = 84, transiciones = [81]),
					/** No abrir */
					new Estado(imageID = 85, audio = "toctoc-1", transiciones = [75, 86]),
						/** No abrir */
						new Estado(imageID = 86, audio = "toctoc-2", transiciones = [75, 87], musicaID = [0, 2]),
							/** No abrir */
							new Estado(imageID = 87, transiciones = [88, 88]),
							new Estado(imageID = 88, transiciones = [89, 89]),
							new Estado(imageID = 89, audio = "jump-scare", transiciones = [79, 79]),
				/** Trabajar en tu proyecto */
				new Estado(imageID = 90, transiciones = [91, 91]),
				new Estado(imageID = 91, transiciones = [92, 93]),
				new Estado(imageID = 92, transiciones = []),
					/** ... */
				new Estado(imageID = 93, transiciones = []),
			/** Hervir el agua */
			new Estado(imageID = 94, audio = 'thunder', transiciones = []),
				/** ... */
		/** Créditos */
		new Estado(imageID = 95, audio = "in-the-end")
	]
}
		