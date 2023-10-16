import wollok.game.*

/** Cada nodo es un árbol
	Si un árbol es hijo de otro, debe definirse dentro de los parámetros de su papi o mami */
class Arbol {
	/** Imagen: pantalla
		imagenID es un entero i asociada al nombre de la imagen: "imagen-i.mp3" */
	var property imageID = 0
	/** Audio: se reproduce cuando aparece la pantalla */
	var property audio = "silence"
	
	/** El árbol es binario, es decir, puede tener dos hijos o ninguno (si es hoja) */
	var property hijos = [/** Left, Right */]
}

/** Cada estado del autómata es un árbol */
class Estado inherits Arbol {
	/** Las transiciones son listas con los índices de los estados siguientes */
	var property transiciones = []
	/** Variable auxiliar cuya utilidad se define en la función del estado siguiente */
	var property auxiliar = 0
}

/** Objeto con los subárboles y nodos de la trama */
object tree {
	/** Créditos */
	const property creditos = new Estado(imageID = 73, audio = "in-the-end")
	/** La desición más dificil de toda la historia */
	const property dilemaSupremo = new Arbol(imageID = 65, hijos = [
		/** Lo agarrás */
		new Arbol(imageID = 66, hijos = [null, null]),
		/** Lo ignorás */
		new Arbol(imageID = 67, audio = "anti-ecologismo-ending", hijos = [creditos, creditos])
	])
	/** Ejercicio 21 */
	const property ejercicio21 = [
		new Estado(imageID = 35, transiciones = [1, 1]),
		new Estado(imageID = 36, transiciones = [2, 2]),
		new Estado(imageID = 37, transiciones = [3, 3])
	]
	/** Ruta estudiante */
	const property rutaEstudiante = [
		new Estado(imageID = 51, transiciones = [1, 1]),
		/** Acá arranca el quiz */
		new Estado(imageID = 52, transiciones = [2, 2], auxiliar = 1),
		new Estado(imageID = 53, transiciones = [3, 3], auxiliar = 0),
		new Estado(imageID = 54, transiciones = [4, 4], auxiliar = 1),
		new Estado(imageID = 55, transiciones = [5, 5], auxiliar = 0),
		new Estado(imageID = 56, transiciones = [6, 6], auxiliar = 1),
		/** Acá termina el quiz */
		/** Nodo de la puerta */
		new Estado(imageID = 57, audio = "toctoc", transiciones = [7, 8]),
		/** Abrir */
		new Estado(imageID = 58, transiciones = [9, 9]),
		/** No abrir */
		null,
		/** Te armás de valor */
		new Estado(imageID = 59, audio = "puerta-abre", transiciones = [10, 11]),
		/** Pascal */
		/** Final: muerte filosófica */
		new Arbol(imageID = 60, audio = "filosofia-ending", hijos = [
			creditos,
			creditos
			]),
		/** Wollok */
		new Estado(imageID = 61, audio = "profe", transiciones = [12, 12]),
		/** Escuela */
		new Arbol(imageID = 62, hijos = [
			/** Decides salir corriendo */
			new Arbol(imageID = 63, hijos = [
				/** Recorrer los pasillos de la facu */
				dilemaSupremo,
				/** Regresar a casa */
				null
			]),
			/** Te quedas */
			new Estado(imageID = 64, hijos = [
				/** Recorrer los pasillos de la facu */
				dilemaSupremo,
				/** Regresar a casa */
				null
			])
		])
	]
	/** Ruta Bandersnatch */
	const property rutaBandersnatch = [
		new Estado(imageID = 68, transiciones = [1, 1]),
		new Estado(imageID = 69, transiciones = [2, 3]),
		new Estado(imageID = 70, transiciones = [4, 5]),
		new Estado(imageID = 71, transiciones = [4, 5])
		/** ... */
	]
	/** Ruta chad */
	const property rutaChad = [
		new Estado(imageID = 13, audio = "chad-0", transiciones = [1, 1]),
		new Estado(imageID = 14, transiciones = [2, 2], hijos = [
			/** Llamar al dueño del edificio */
			new Estado(imageID = 15, audio = "que", hijos = [
				/** Soy yo, man */
				new Estado(imageID = 16, audio = "tell-me-what-you-want", hijos = [
					/** No tengo agua caliente */
					new Estado(imageID = 17, audio = "me-suda-la-polla", hijos = [
						/** Me tenés que ayudar */
						new Estado(imageID = 18, audio = "es-culpa-tuya", hijos = [
							/** Es tu edificio, hacete cargo */
							new Estado(imageID = 19, audio = "que-quieres-que-haga", hijos = [
								/** Solucioname el tema del agua */
								new Estado(imageID = 20, audio = "no-quiero", hijos = [
									/** ¡Dale, gordo! */
									new Estado(imageID = 21, audio = "joder"),
									/** Cortar */
									/** Final: ruptura */
									new Estado(imageID = 22, audio = "ruptura-ending", hijos = [
										creditos,
										creditos
									])
								]),
								/** Tu servicio es desproporcional al precio */
								new Estado(imageID = 23, audio = "lo-que-no-tengo-proporcional")
							]),
							/** Me lo vas a descontar del alquiler */
							new Estado(imageID = 24, audio = "mentiroso-de-mierda")
						]),
						/** Dejá de hacerte el boludo */
						new Estado(imageID = 25, audio = "quien-cojones-te-crees-que-eres")
					]),
					/** I don't have hot water */
					new Estado(imageID = 26, audio = "que-dices")
				]),
				/** So */
				new Estado(imageID = 27, audio = "eres-imbecil")
			]),
			/** Tomar una ducha fría */
			new Estado(imageID = 28, audio = "chad-1")
		]),
		/** Después de la ducha */
		new Estado(imageID = 29, hijos = [
			/** Estudiar para el examen */
			new Arbol(imageID = 30, hijos = [
				/** Aplicar la fórmula */
				new Arbol(imageID = 31),
				/** Deducir el procedimiento */
				new Arbol(imageID = 32, audio = "chad-2", hijos = [
					/** Separar las variables */
					new Arbol(imageID = 33, hijos = [
						/** Usar la regla del producto para derivadas */
						ejercicio21.first(),
						/** Reinventar la matemática */
						/** Final: muerte matemática */
						new Arbol(imageID = 34, hijos = [
							creditos,
							creditos
						])
					]),
					/** Usar la regla del producto para derivadas */
					ejercicio21.first()
				])
			]),
			/** Trabajar en tu proyecto */
			null
		])
	]
	/** Ruta drama */
	const property rutaDrama = [
		/** Empieza el drama */
		new Estado(imageID = 39, audio = "drop-bounce-plastic-bottle", transiciones = [1, 2]),
			/** Intentar salvar el café */
			new Estado(imageID = 40, hijos = [
				/** Mezclar el dulce en el café */
				new Arbol(imageID = 41),
				/** Mezclar el café en el dule */
				/** Final: muerte por dulce de leche */
				new Arbol(imageID = 42, audio = "el-fin-del-hombre-arana", hijos = [
					creditos,
					creditos
				])
			]),
			/** Aceptar tu derrota */
			new Estado(imageID = 43, transiciones = [3, 4]),
				/** Estudiar para el examen */
				new Estado(imageID = 44, hijos = [
					/** ... */
					null,
					/** ... */
					null
				]),
				/** Trabajar en tu proyecto */
				new Estado(imageID = 45, hijos = [
					/** ... */
					null,
					/** Sucumbir a la desesperación */
					new Arbol(imageID = 46, hijos = [
						/** Saltar por la ventana */
						/** Final: muerte por desesperación */
						new Arbol(imageID = 47, hijos = [
							creditos,
							creditos
						]),
						/** No saltar */
						/** Final: muerte en vida */
						new Arbol(imageID = 48, hijos = [
							creditos,
							creditos
						])
					])
				])
	]
	/** Aventura principal */
	const property aventura = [
			/** Café */
			new Arbol(imageID = 12, audio = "olha-a-hora-do-cafe", hijos = [
				/** Tomar solo */
				rutaChad.first(),
				/** Agregarle leche */
				new Arbol(imageID = 38, audio = "fridge", hijos = [
					/** Andá a saber... */
					rutaDrama.first(),
					/** ¡Yo no fuí! */
					rutaDrama.first()
				])
			]),
			/** Mate */
			new Arbol(imageID = 49, hijos = [
				/** 348 Kelvin */
				new Arbol(imageID = 50, audio = 'que-rico-esta-este-mate', hijos = [
					/** Estudiar para el examen */
					rutaEstudiante.first(),
					/** Trabajar en tu proyecto */
					rutaBandersnatch.first()
				]),
				/** Hervir el agua */
				new Arbol(imageID = 72, audio = 'thunder', hijos = [
					creditos,
					creditos
				])
			])
	]
		
	/** Lista con todos los estados del quiz inicial) */
	const property inicio = [
		/** Acá arranca el quiz */
		new Estado(imageID = 0, transiciones = [1], auxiliar = 0),
		new Estado(imageID = 1, transiciones = [2], auxiliar = 1),
		new Estado(imageID = 2, transiciones = [3], auxiliar = 1),
		new Estado(imageID = 3, transiciones = [4], auxiliar = 0),
		new Estado(imageID = 4, transiciones = [5], auxiliar = 1),
		new Estado(imageID = 5, transiciones = [6], auxiliar = 1),
		new Estado(imageID = 6, transiciones = [7, 8, 9, 9, 9, 10, 10, 11], auxiliar = 0),
		/** Acá termina el quiz */
		new Estado(imageID = 7,  audio = 'quiz-0', hijos = aventura),
		new Estado(imageID = 8,  audio = 'quiz-1', hijos = aventura),
		new Estado(imageID = 9,  audio = 'quiz-2', hijos = aventura),
		new Estado(imageID = 10, audio = 'quiz-3', hijos = aventura),
		new Estado(imageID = 11, audio = 'quiz-4', hijos = aventura)
		/** Después arranca la aventura */
	]
}
