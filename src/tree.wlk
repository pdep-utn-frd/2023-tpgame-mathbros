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
		new Estado(imageID = 7,  audio = 'quiz-0', transiciones = [12, 80]),
		new Estado(imageID = 8,  audio = 'quiz-1', transiciones = [12, 80]),
		new Estado(imageID = 9,  audio = 'quiz-2', transiciones = [12, 80]),
		new Estado(imageID = 10, audio = 'quiz-3', transiciones = [12, 80]),
		new Estado(imageID = 11, audio = 'quiz-4', transiciones = [12, 80]),
		/** Acá arranca la aventura */
		/** Café */
		new Estado(imageID = 12, audio = "olha-a-hora-do-cafe", transiciones = [13, 64]),
			/** Tomar solo */
			new Estado(imageID = 13, audio = "chad-0", transiciones = [14, 14]),
			new Estado(imageID = 14, transiciones = [15, 51]),
				/** Llamar al dueño del edificio */
				new Estado(imageID = 15, audio = "que", transiciones = [16, 50]),
					/** Soy yo, man */
					new Estado(imageID = 16, audio = "tell-me-what-you-want", transiciones = [17, 49]),
						/** No tengo agua caliente */
						new Estado(imageID = 17, audio = "me-suda-la-polla", transiciones = [18, 48]),
							/** Me tenés que ayudar */
							new Estado(imageID = 18, audio = "es-culpa-tuya", transiciones = [19, 47]),
								/** Es tu edificio, hacete cargo */
								new Estado(imageID = 19, audio = "que-quieres-que-haga", transiciones = [20, 25]),
									/** Solucioname el tema del agua */
									new Estado(imageID = 20, audio = "no-quiero", transiciones = [21, 24]),
										/** ¡Dale, gordo! */
										new Estado(imageID = 21, audio = "joder", transiciones = [22, 23]),
											/** ... */
											new Estado(imageID = 22, audio = "roundabout", transiciones = [114, 114]),
											new Estado(imageID = 23, audio = "roundabout", transiciones = [114, 114]),
										/** Cortar */
										/** Final: ruptura */
										new Estado(imageID = 24, audio = "ruptura-ending", transiciones = [114, 114]),
									/** Tu servicio es desproporcional al precio */
									new Estado(imageID = 25, audio = "lo-que-no-tengo-proporcional", transiciones = [26, 41]),
										/** Estudiar para el examen */
										new Estado(imageID = 26, transiciones = [27, 27], musicaID = [1, 1]),
										/** Empieza el segundo quiz */
										new Estado(imageID = 27, transiciones = [28, 28], auxiliar = 1),
										new Estado(imageID = 28, transiciones = [29, 29], auxiliar = 0),
										new Estado(imageID = 29, transiciones = [30, 30], auxiliar = 1),
										new Estado(imageID = 30, transiciones = [31, 31], auxiliar = 0),
										new Estado(imageID = 31, audio = "quieres-que-te-haga-caca-en-la-cara", transiciones = [30, 30], auxiliar = 1, musicaID = [1, 1]),
										/** Termina el segundo quiz */
										new Estado(imageID = 32, audio = "telefono", transiciones = [33, 37]),
											/** No, no la hay */
											new Estado(imageID = 33, audio = "me-he-dejado-las-llaves-dentro", transiciones = [34, 34]),
											new Estado(imageID = 34, audio = "no-es-gracioso", transiciones = [35, 37]),
												/** Apiadarte del pobre infeliz */
												new Estado(imageID = 35, audio = "gracias-por-escuchar-mis-plegarias-tio", transiciones = [36, 36]),
												new Estado(imageID = 36, transiciones = [46, 46]),
													/** Termina el día 1 */
												/** ¡Que se cague por gil! */
												new Estado(imageID = 37, audio = "me-cago-en-tus-muertos", transiciones = [38, 38]),
												new Estado(imageID = 38, transiciones = [46, 46]),
													/** Termina el día 1 */
											/** Me da paja */
											new Estado(imageID = 39, audio = "eres-un-vago-de-mierda", transiciones = [33, 40]),
												/** Ser un *vago de mierda* */
												new Estado(imageID = 40, audio = "vago-ending", transiciones = [114, 114]),
										/** Trabajar en tu proyecto */
										new Estado(imageID = 41, transiciones = [42, 42]),
										new Estado(imageID = 42, audio = "como-que-un-juego", transiciones = [43, 43]),
										new Estado(imageID = 43, audio = "esto-no-es-un-juego", transiciones = [44, 45]),
											/** Esto ES un juego */
											/** Final: libertad */
											new Estado(imageID = 44, audio = "libertad-ending", transiciones = [114, 114]),
											/** NADA es un juego */
											new Estado(imageID = 45, transiciones = [46, 46]),
											/** ... */
											new Estado(imageID = 46, audio = "roundabout", transiciones = [114, 114]),
								/** Me lo vas a descontar del alquiler */
								new Estado(imageID = 47, audio = "mentiroso-de-mierda", transiciones = [26, 41]),
							/** Dejá de hacerte el boludo */
							new Estado(imageID = 48, audio = "quien-cojones-te-crees-que-eres", transiciones = [26, 41]),
						/** I don't have hot water */
						new Estado(imageID = 49, audio = "que-dices", transiciones = [26, 41]),
					/** So */
					new Estado(imageID = 50, audio = "eres-imbecil", transiciones = [26, 41]),
				/** Tomar una ducha fría */
				new Estado(imageID = 51, audio = "chad-1", transiciones = [52, 52]),
				new Estado(imageID = 52, transiciones = [53, 63]),
					/** Estudiar para el examen */
					new Estado(imageID = 53, transiciones = [54, 56]),
						/** Aplicar la fórmula */
						new Estado(imageID = 54, transiciones = [55, 55]),
							/** ... */
							new Estado(imageID = 55, audio = "roundabout", transiciones = [114, 114]),
						/** Deducir el procedimiento */
						new Estado(imageID = 56, audio = "chad-2", transiciones = [57, 59]),
							/** Separar las variables */
							new Estado(imageID = 57, transiciones = [58, 59]),
								/** Demostrarlo */
								/** Final chad 1 */
								new Estado(imageID = 58, audio = "chad-3", transiciones = [114, 114]),
								/** Usar la regla del producto para derivadas */
									new Estado(imageID = 59, transiciones = [60, 60]),
									new Estado(imageID = 60, transiciones = [61, 61]),
									new Estado(imageID = 61, transiciones = [62, 62]),
									/** ... */
									new Estado(imageID = 62, audio = "roundabout", transiciones = [114, 114]),
					/** Trabajar en tu proyecto */
					/** ... */
					new Estado(imageID = 63, audio = "roundabout", transiciones = [114, 114]),
			/** Agregarle leche */
			new Estado(imageID = 64, audio = "fridge", transiciones = [65, 65]),
			new Estado(imageID = 65, audio = "drop-bounce-plastic-bottle", transiciones = [66, 72], musicaID = [0, 3]),
				/** Intentar salvar el café */
				new Estado(imageID = 66, transiciones = [67, 71]),
					/** Mezclar el dulce en el café */
					new Estado(imageID = 67, transiciones = [68, 68]),
					new Estado(imageID = 68, audio = "disturbing-call", transiciones = [69, 70]),
						new Estado(imageID = 69, audio = "coin-drop", transiciones = [114, 114]),
						new Estado(imageID = 70, audio = "coin-drop", transiciones = [12, 80]),
					/** Mezclar el café en el dulce */
					/** Final: muerte por dulce de leche */
					new Estado(imageID = 71, audio = "el-fin-del-hombre-arana", transiciones = [114, 114]),
				/** Aceptar tu derrota */
				new Estado(imageID = 72, transiciones = [73, 75]),
					/** Estudiar para el examen */
					new Estado(imageID = 73, audio = "mad-world-kid", transiciones = [74, 74]),
						/** ... */
						new Estado(imageID = 74, audio = "roundabout", transiciones = [114, 114]),
					/** Trabajar en tu proyecto */
					new Estado(imageID = 75, audio = "mad-world-kid", transiciones = [76, 77]),
						/** ... */
						new Estado(imageID = 76, audio = "roundabout", transiciones = [114, 114]),
						/** Sucumbir a la desesperación */
						new Estado(imageID = 77, transiciones = [78, 79]),
							/** Saltar por la ventana */
							/** Final: muerte por desesperación */
							new Estado(imageID = 78, transiciones = [114, 114]),
							/** No saltar */
							/** Final: muerte en vida */
							new Estado(imageID = 79, transiciones = [114, 114]),
		/** Mate */
		new Estado(imageID = 80, transiciones = [81, 112]),
			/** 348 Kelvin */
			new Estado(imageID = 81, audio = 'que-rico-esta-este-mate', transiciones = [82, 106]),
				/** Estudiar para el examen */
				new Estado(imageID = 82, transiciones = [83, 83], musicaID = [1, 1]),
				/** Acá arranca el segundo quiz */
				new Estado(imageID = 83, transiciones = [84, 84], auxiliar = 1),
				new Estado(imageID = 84, transiciones = [85, 85], auxiliar = 0),
				new Estado(imageID = 85, transiciones = [86, 86], auxiliar = 1),
				new Estado(imageID = 86, transiciones = [87, 87], auxiliar = 0),
				new Estado(imageID = 87, transiciones = [88, 88], auxiliar = 1, musicaID = [1, 1]),
				/** Acá termina el segundo quiz */
				new Estado(imageID = 88, audio = "toctoc", transiciones = [89, 101], musicaID = [2, 2]),
					/** Abrir */
					new Estado(imageID = 89, transiciones = [90, 90]),
					new Estado(imageID = 90, audio = "puerta-abre", transiciones = [91, 92]),
						/** Pascal */
						/** Final: muerte filosófica */
						new Estado(imageID = 91, audio = "filosofia-ending", transiciones = [114, 114]),
						/** Wollok */
						new Estado(imageID = 92, audio = "profe", transiciones = [93, 93], musicaID = [1, 1]),
						new Estado(imageID = 93, audio = "campana", transiciones = [94, 100]),
							/** Decides salir corriendo */
							new Estado(imageID = 94, transiciones = [95, 99]),
								/** Recorrer los pasillos de la facu */
								new Estado(imageID = 95, transiciones = [96, 98]),
									/** Lo agarrás */
									new Estado(imageID = 96, transiciones = [97, 97]),
										/** ... */
										new Estado(imageID = 97, audio = "roundabout", transiciones = [114, 114]),
									/** Lo ignorás */
									/** Final: anti-ecologismo */
									new Estado(imageID = 98, audio = "anti-ecologismo-ending", transiciones = [114, 114]),
								/** Regresar a casa */
								/** ... */
								new Estado(imageID = 99, audio = "roundabout", transiciones = [114, 114]),
							/** Te quedas */
							new Estado(imageID = 100, transiciones = [95, 99]),
					/** No abrir */
					new Estado(imageID = 101, audio = "toctoc-1", transiciones = [89, 102]),
						/** No abrir */
						new Estado(imageID = 86, audio = "toctoc-2", transiciones = [89, 103], musicaID = [0, 2]),
							/** No abrir */
							new Estado(imageID = 103, transiciones = [104, 104]),
							new Estado(imageID = 104, transiciones = [105, 105]),
							new Estado(imageID = 105, audio = "jump-scare", transiciones = [93, 93]),
				/** Trabajar en tu proyecto */
				new Estado(imageID = 106, transiciones = [107, 107], musicaID = [3, 3]),
				new Estado(imageID = 107, transiciones = [108, 110]),
				new Estado(imageID = 108, transiciones = [109, 109]),
					/** ... */
					new Estado(imageID = 109, audio = "roundabout", transiciones = [114, 114]),
				new Estado(imageID = 110, transiciones = [111, 111]),
					/** ... */
					new Estado(imageID = 111, audio = "roundabout", transiciones = [114, 114]),
			/** Hervir el agua */
			new Estado(imageID = 112, audio = 'thunder', transiciones = [113, 113]),
				/** ... */
				new Estado(imageID = 113, audio = "roundabout", transiciones = [114, 114]),
		/** Créditos */
		new Estado(imageID = 114, audio = "in-the-end")
	]
}
		