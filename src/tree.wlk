import wollok.game.*

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
		new Estado(imageID = 6, transiciones = [7, 8, 9, 9, 9, 10, 10, 11], auxiliar = 0),
		/** Acá termina el quiz */
		new Estado(imageID = 7,  audio = 'quiz-0', transiciones = [12, 49]),
		new Estado(imageID = 8,  audio = 'quiz-1', transiciones = [12, 49]),
		new Estado(imageID = 9,  audio = 'quiz-2', transiciones = [12, 49]),
		new Estado(imageID = 10, audio = 'quiz-3', transiciones = [12, 49]),
		new Estado(imageID = 11, audio = 'quiz-4', transiciones = [12, 49]),
		/** Acá arranca la aventura */
		/** Café */
		new Estado(imageID = 12, audio = "olha-a-hora-do-cafe", transiciones = [13, 38]),
			/** Tomar solo */
			new Estado(imageID = 13, audio = "chad-0", transiciones = [14, 14]),
			new Estado(imageID = 14, transiciones = [15, 28]),
				/** Llamar al dueño del edificio */
				new Estado(imageID = 15, audio = "que", transiciones = [16, 27]),
					/** Soy yo, man */
					new Estado(imageID = 16, audio = "tell-me-what-you-want", transiciones = [17, 26]),
						/** No tengo agua caliente */
						new Estado(imageID = 17, audio = "me-suda-la-polla", transiciones = [18, 25]),
							/** Me tenés que ayudar */
							new Estado(imageID = 18, audio = "es-culpa-tuya", transiciones = [19, 24]),
								/** Es tu edificio, hacete cargo */
								new Estado(imageID = 19, audio = "que-quieres-que-haga", transiciones = [20, 23]),
									/** Solucioname el tema del agua */
									new Estado(imageID = 20, audio = "no-quiero", transiciones = [21, 22]),
										/** ¡Dale, gordo! */
										new Estado(imageID = 21, audio = "joder"),
										/** Cortar */
										/** Final: ruptura */
										new Estado(imageID = 22, audio = "ruptura-ending", transiciones = [73, 73]),
									/** Tu servicio es desproporcional al precio */
									new Estado(imageID = 23, audio = "lo-que-no-tengo-proporcional"),
								/** Me lo vas a descontar del alquiler */
								new Estado(imageID = 24, audio = "mentiroso-de-mierda"),
							/** Dejá de hacerte el boludo */
							new Estado(imageID = 25, audio = "quien-cojones-te-crees-que-eres"),
						/** I don't have hot water */
						new Estado(imageID = 26, audio = "que-dices"),
					/** So */
					new Estado(imageID = 27, audio = "eres-imbecil"),
				/** Tomar una ducha fría */
				new Estado(imageID = 28, audio = "chad-1", transiciones = [29, 29]),
				new Estado(imageID = 29, transiciones = [30]),
					/** Estudiar para el examen */
					new Estado(imageID = 30, transiciones = [31, 32]),
						/** Aplicar la fórmula */
						new Estado(imageID = 31, transiciones = []),
							/** ... */
						/** Deducir el procedimiento */
						new Estado(imageID = 32, audio = "chad-2", transiciones = [33, 35]),
							/** Separar las variables */
							new Estado(imageID = 33, transiciones = [35, 34]),
								/** Usar la regla del producto para derivadas */
									new Estado(imageID = 35, transiciones = [36, 36]),
									new Estado(imageID = 36, transiciones = [37, 37]),
									new Estado(imageID = 37, transiciones = []),
									/** ... */
								/** Reinventar la matemática */
								/** Final: muerte matemática */
								new Estado(imageID = 34, transiciones = [73, 73]),
					/** Trabajar en tu proyecto */
					/** ... */
			/** Agregarle leche */
			new Estado(imageID = 38, audio = "fridge", transiciones = [39, 39]),
			new Estado(imageID = 39, audio = "drop-bounce-plastic-bottle", transiciones = [40, 43]),
				/** Intentar salvar el café */
				new Estado(imageID = 40, transiciones = [41, 42]),
					/** Mezclar el dulce en el café */
					new Estado(imageID = 41, transiciones = []),
						/** ... */
					/** Mezclar el café en el dule */
					/** Final: muerte por dulce de leche */
					new Estado(imageID = 42, audio = "el-fin-del-hombre-arana", transiciones = [73, 73]),
				/** Aceptar tu derrota */
				new Estado(imageID = 43, transiciones = [44, 45]),
					/** Estudiar para el examen */
					new Estado(imageID = 44, transiciones = []),
						/** ... */
					/** Trabajar en tu proyecto */
					new Estado(imageID = 45, transiciones = [46, 46]),
						/** ... */
						/** Sucumbir a la desesperación */
						new Estado(imageID = 46, transiciones = [47, 48]),
							/** Saltar por la ventana */
							/** Final: muerte por desesperación */
							new Estado(imageID = 47, transiciones = [73, 73]),
							/** No saltar */
							/** Final: muerte en vida */
							new Estado(imageID = 48, transiciones = [73, 73]),
		/** Mate */
		new Estado(imageID = 49, transiciones = [50, 72]),
			/** 348 Kelvin */
			new Estado(imageID = 50, audio = 'que-rico-esta-este-mate', transiciones = [51, 68]),
				/** Estudiar para el examen */
				new Estado(imageID = 51, transiciones = [52, 52]),
				/** Acá arranca el segundo quiz */
				new Estado(imageID = 52, transiciones = [53, 53], auxiliar = 1),
				new Estado(imageID = 53, transiciones = [54, 54], auxiliar = 0),
				new Estado(imageID = 54, transiciones = [55, 55], auxiliar = 1),
				new Estado(imageID = 55, transiciones = [56, 56], auxiliar = 0),
				new Estado(imageID = 56, transiciones = [57, 57], auxiliar = 1),
				/** Acá termina el segundo quiz */
				new Estado(imageID = 57, audio = "toctoc", transiciones = [58]),
					/** Abrir */
					new Estado(imageID = 58, transiciones = [59, 59]),
					new Estado(imageID = 59, audio = "puerta-abre", transiciones = [60, 61]),
						/** Pascal */
						/** Final: muerte filosófica */
						new Estado(imageID = 60, audio = "filosofia-ending", transiciones = [73, 73]),
						/** Wollok */
						new Estado(imageID = 61, audio = "profe", transiciones = [62, 62]),
						new Estado(imageID = 62, transiciones = [63, 67]),
							/** Decides salir corriendo */
							new Estado(imageID = 63, transiciones = [64]),
								/** Recorrer los pasillos de la facu */
								new Estado(imageID = 65, transiciones = [65, 66]),
									/** Lo agarrás */
									new Estado(imageID = 66, transiciones = []),
										/** ... */
									/** Lo ignorás */
									/** Final: anti-ecologismo */
									new Estado(imageID = 67, audio = "anti-ecologismo-ending", transiciones = [73, 73]),
								/** Regresar a casa */
								/** ... */
							/** Te quedas */
							new Estado(imageID = 64, transiciones = [64]),
					/** No abrir */
					/** ... */
				/** Trabajar en tu proyecto */
				new Estado(imageID = 68, transiciones = [69, 69]),
				new Estado(imageID = 69, transiciones = [70, 71]),
				new Estado(imageID = 70, transiciones = []),
					/** ... */
				new Estado(imageID = 71, transiciones = []),
			/** Hervir el agua */
			new Estado(imageID = 72, audio = 'thunder', transiciones = []),
				/** ... */
		/** Créditos */
		new Estado(imageID = 73, audio = "in-the-end")
	]
}
		