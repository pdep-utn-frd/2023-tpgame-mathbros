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
	const property creditos = new Estado(imageID = 46, audio = "in-the-end")
	/** Ruta estudiante */
	const property rutaEstudiante = [
		new Estado(imageID = 28, transiciones = [1]),
		/** Acá arranca el quiz */
		new Estado(imageID = 29, transiciones = [2], auxiliar = 1),
		new Estado(imageID = 30, transiciones = [3], auxiliar = 0),
		new Estado(imageID = 31, transiciones = [4], auxiliar = 1),
		new Estado(imageID = 32, transiciones = [5], auxiliar = 0),
		new Estado(imageID = 33, auxiliar = 1)
		/** Acá termina el quiz */
	]
	/** La desición más dificil de toda la historia */
	const property dilemaSupremo = new Arbol(imageID = 42, hijos = [
		/** Lo agarrás */
		new Arbol(imageID = 43, hijos = [null, null]),
		/** Lo ignorás */
		new Arbol(imageID = 44, audio = "anti-ecologismo-ending", hijos = [creditos, creditos])
	])
	
	const property rapto = new Arbol(imageID = 39, hijos = [
		/** Decides salir corriendo */
		new Arbol(imageID = 40, hijos = [dilemaSupremo, null]),
		/** Te quedas */
		new Arbol(imageID = 41, hijos = [dilemaSupremo, null])
	])
	
	const property abrisLaPuerta = new Arbol(imageID = 36, audio = "puerta-abre", hijos = [
		/** Pascal */
		new Arbol(imageID = 37, audio = "filosofia-ending", hijos = [creditos, creditos]),
		/** Wollok */
		new Arbol(imageID = 38, audio = "profe", hijos = [rapto, rapto])
	])
	const property subtramaFacu = new Arbol(imageID = 34, audio = "toctoc", hijos = [
		/** Abrir */
		new Arbol(imageID = 35, hijos = [
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
				new Arbol(imageID = 13, audio = "drink-sip-and-swallow"),
				/** Agregarle leche */
				new Arbol(imageID = 14, audio = "fridge", hijos = [
					/** Andá a saber... */
					/** Ruta drama */
					new Arbol(imageID = 15, audio = "drop-bounce-plastic-bottle", hijos = [
						/** Intentar salvar el café */
						new Arbol(imageID = 16, hijos = [
							/** Mezclar el dulce en el café */
							new Arbol(imageID = 17),
							/** Merclar el café en el dule */
							/** Final: muerte por dulce de leche */
							new Arbol(imageID = 18, audio = "el-fin-del-hombre-arana", hijos = [
								creditos,
								creditos
							])
						]),
						/** Aceptar tu derrota */
						new Arbol(imageID = 19, hijos = [
							/** Estudiar para el examen */
							new Arbol(imageID = 20, hijos= [
								/** ... */
								subtramaFacu,
								/** ... */
								subtramaFacu
								
							]),
							/** Trabajar en tu proyecto */
							new Arbol(imageID = 21, hijos = [
								/** ... */
								null,
								/** Sucumbir a la desesperación */
								new Arbol(imageID = 22, hijos = [
									/** Saltar por la ventana */
									/** Final: muerte por desesperación */
									new Arbol(imageID = 23, hijos = [
										creditos,
										creditos
									]),
									/** No saltar */
									new Arbol(imageID = 24, hijos = [
										creditos,
										creditos
									])
								])
							])
						])
					]),
					/** ¡Yo no fuí! */
					/** Ruta detective */
					new Arbol(imageID = 25, audio = "okay-sherlock")
				])
			]),
			/** Mate */
			new Arbol(imageID = 26, hijos = [
				/** 348 Kelvin */
				new Arbol(imageID = 27, audio = 'que-rico-esta-este-mate', hijos = [
					/** Estudiar para el examen */
					rutaEstudiante.first(),
					/** Trabajar en tu proyecto */
					null
				]),
				/** Hervir el agua */
				new Arbol(imageID = 45, audio = '8-bit-sizzle', hijos = [
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
