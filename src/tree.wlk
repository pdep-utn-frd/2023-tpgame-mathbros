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
	const property creditos = new Estado(imageID = 61, audio = "in-the-end")
	/** Ruta estudiante */
	const property rutaEstudiante = [
		new Estado(imageID = 43, transiciones = [1]),
		/** Acá arranca el quiz */
		new Estado(imageID = 44, transiciones = [2], auxiliar = 1),
		new Estado(imageID = 45, transiciones = [3], auxiliar = 0),
		new Estado(imageID = 46, transiciones = [4], auxiliar = 1),
		new Estado(imageID = 47, transiciones = [5], auxiliar = 0),
		new Estado(imageID = 48, auxiliar = 1)
		/** Acá termina el quiz */
	]
	/** Ruta chad */
	const property rutaChad = [
		new Estado(imageID = 13, audio = "chad-0", transiciones = [1]),
		new Estado(imageID = 14, hijos = [
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
									/** ¡Dale gordo! */
									new Estado(imageID = 21, audio = "joder"),
									/** Cortar */
									new Estado(imageID = 22)
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
		])
	]
	/** La desición más dificil de toda la historia */
	const property dilemaSupremo = new Arbol(imageID = 42, hijos = [
		/** Lo agarrás */
		new Arbol(imageID = 54, hijos = [null, null]),
		/** Lo ignorás */
		new Arbol(imageID = 55, audio = "anti-ecologismo-ending", hijos = [creditos, creditos])
	])
	
	const property rapto = new Arbol(imageID = 39, hijos = [
		/** Decides salir corriendo */
		new Arbol(imageID = 52, hijos = [dilemaSupremo, null]),
		/** Te quedas */
		new Arbol(imageID = 53, hijos = [dilemaSupremo, null])
	])
	
	const property abrisLaPuerta = new Arbol(imageID = 36, audio = "puerta-abre", hijos = [
		/** Pascal */
		new Arbol(imageID = 50, audio = "filosofia-ending", hijos = [creditos, creditos]),
		/** Wollok */
		new Arbol(imageID = 51, audio = "profe", hijos = [rapto, rapto])
	])
	const property subtramaFacu = new Arbol(imageID = 34, audio = "toctoc", hijos = [
		/** Abrir */
		new Arbol(imageID = 49, hijos = [
			abrisLaPuerta,
			abrisLaPuerta
		]),
		/** No Abrir */
		null
	])
	/** Variable con los nodos de la aventura */
	const property aventura = [
			/** Café */
			new Arbol(imageID = 12, audio = "olha-a-hora-do-cafe", hijos = [
				/** Tomar solo */
				rutaChad.first(),
				/** Agregarle leche */
				new Arbol(imageID = 29, audio = "fridge", hijos = [
					/** Andá a saber... */
					/** Ruta drama */
					new Arbol(imageID = 30, audio = "drop-bounce-plastic-bottle", hijos = [
						/** Intentar salvar el café */
						new Arbol(imageID = 31, hijos = [
							/** Mezclar el dulce en el café */
							new Arbol(imageID = 32),
							/** Merclar el café en el dule */
							/** Final: muerte por dulce de leche */
							new Arbol(imageID = 33, audio = "el-fin-del-hombre-arana", hijos = [
								creditos,
								creditos
							])
						]),
						/** Aceptar tu derrota */
						new Arbol(imageID = 34, hijos = [
							/** Estudiar para el examen */
							new Arbol(imageID = 35, hijos= [
								/** ... */
								subtramaFacu,
								/** ... */
								subtramaFacu
								
							]),
							/** Trabajar en tu proyecto */
							new Arbol(imageID = 36, hijos = [
								/** ... */
								null,
								/** Sucumbir a la desesperación */
								new Arbol(imageID = 37, hijos = [
									/** Saltar por la ventana */
									/** Final: muerte por desesperación */
									new Arbol(imageID = 38, hijos = [
										creditos,
										creditos
									]),
									/** No saltar */
									new Arbol(imageID = 39, hijos = [
										creditos,
										creditos
									])
								])
							])
						])
					]),
					/** ¡Yo no fuí! */
					/** Ruta detective */
					new Arbol(imageID = 40, audio = "okay-sherlock")
				])
			]),
			/** Mate */
			new Arbol(imageID = 41, hijos = [
				/** 348 Kelvin */
				new Arbol(imageID = 42, audio = 'que-rico-esta-este-mate', hijos = [
					/** Estudiar para el examen */
					rutaEstudiante.first(),
					/** Trabajar en tu proyecto */
					null
				]),
				/** Hervir el agua */
				new Arbol(imageID = 60, audio = 'thunder', hijos = [
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
