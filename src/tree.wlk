import wollok.game.*

/** Cada nodo es un árbol */
class Arbol {
	/** Imagen: pantalla
		imagenID es un entero i asociada al nombre de la imagen: "imagen-i.mp3" */
	var property imageID = 0
	/** Audio: se reproduce cuando aparece la pantalla */
	var property audio = "silence"
	
	/** El árbol es binario, es decir, puede tener dos hijos o ninguno (si es hoja) */
	var property hijos = [/** Left, Right */]
}

/** La pantalla tiene un atributo posición y una imagen */
object pantalla {
	var property position = game.at(0,0)
	var property image = "assets/imagen-0.png"
}

/** Cada estado del autómata es un árbol */
class Estado inherits Arbol {
	/** Las transiciones son listas con los índices de los estados siguientes */
	var property transiciones = []
	/** El audioInput se reproduce cuando el jugador presiona una tecla
		El primero está asociado al playerInput = 0 (Left)
		El segundo está asociado al playerInput = 1 (Right) */
	var property audioInput = ["silence", "silence"]
}

/** Acá ocurre la magia */
object juego {
	/** Variable auxilar que almacena 0 ("Left") o 1 ("Right") dependiendo de la última tecla que presionó el jugador */
	var property playerInput = 0
	/** Variable que contiene la cantidad de preguntadas acertadas por el jugador */
	var property puntaje = 0
	/** Música del quiz */
	const musicaQuiz = game.sound("assets/amenabar.mp3")
	/** Créditos */
	const creditos = new Estado(imageID = 46, audio = "in-the-end")
	/** Ruta estudiante */
	const nodoEstudiante = new Arbol(imageID = 28)
	const estadosQuiz2 = [
		/** Acá arranca el quiz */
		new Estado(imageID = 29, transiciones = [1], audioInput = ["incorrect-buzzer", "correct-yay"]),
		new Estado(imageID = 30, transiciones = [2], audioInput = ["correct-yay", "incorrect-buzzer"]),
		new Estado(imageID = 31, transiciones = [3], audioInput = ["incorrect-buzzer", "correct-yay"]),
		new Estado(imageID = 32, transiciones = [4], audioInput = ["correct-yay", "incorrect-buzzer"]),
		new Estado(imageID = 33, audioInput = ["incorrect-buzzer", "correct-yay"])
	]
	const dilemaSupremo = new Arbol(imageID=42, hijos=[
		/** Lo agarras */
		new Arbol(imageID=43, hijos=[null, null]),
		/** Lo ignoras */
		new Arbol(imageID=44, hijos=[creditos, creditos])
	])
	
	const rapto = new Arbol(imageID=39, hijos=[
		/** Decides salir corriendo */
		new Arbol(imageID=40, hijos=[dilemaSupremo, null]),
		/** Te quedas */
		new Arbol(imageID=41, hijos=[dilemaSupremo, null])
	])
	
	const abrisLaPuerta = new Arbol(imageID=36, audio="puerta-abre", hijos=[
		/** Pascal */
		new Arbol(imageID=37, hijos=[creditos, creditos]),
		/** Wollok */
		new Arbol(imageID=38, hijos=[rapto, rapto])
	])
	const subtramaFacu = new Arbol(imageID = 34, audio="toctoc", hijos=[
		/** Abrir */
		new Arbol(imageID = 35, hijos=[
			abrisLaPuerta,
			abrisLaPuerta
		]),
		/** No Abrir */
		null
	])
	/** Variable con los nodos de la aventura */
	const arbolAventura = [
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
					nodoEstudiante,
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
	/** Lista con todos los estados del autómata y los nodos (pantallas)
		Si un árbol es hijo de otro, debe definirse dentro de los parámetros de su papi o mami */
	const estados = [
		/** Acá arranca el quiz */
		new Estado(imageID = 0, transiciones = [1], audioInput = ["correct-yay", "incorrect-buzzer"]),
		new Estado(imageID = 1, transiciones = [2], audioInput = ["incorrect-buzzer", "correct-yay"]),
		new Estado(imageID = 2, transiciones = [3], audioInput = ["incorrect-buzzer", "correct-yay"]),
		new Estado(imageID = 3, transiciones = [4], audioInput = ["correct-yay", "incorrect-buzzer"]),
		new Estado(imageID = 4, transiciones = [5], audioInput = ["incorrect-buzzer", "correct-yay"]),
		new Estado(imageID = 5, transiciones = [6], audioInput = ["incorrect-buzzer", "correct-yay"]),
		new Estado(imageID = 6, transiciones = [7, 8, 9, 9, 9, 10, 10, 11], audioInput = ["correct-yay", "incorrect-buzzer"]),
		/** Acá termina el quiz */
		new Estado(imageID = 7,  audio = 'quiz-0', hijos = arbolAventura),
		new Estado(imageID = 8,  audio = 'quiz-1', hijos = arbolAventura),
		new Estado(imageID = 9,  audio = 'quiz-2', hijos = arbolAventura),
		new Estado(imageID = 10, audio = 'quiz-3', hijos = arbolAventura),
		new Estado(imageID = 11, audio = 'quiz-4', hijos = arbolAventura)
	]
	/** Variable que apunta al estado actual */
	var property estadoActual = estados.first()
	/** Variable que apunta al nodo actual. Si el estado cambia, el nodo debe cambiar también */
	var property nodoActual = estadoActual
	
	/** Transiciona al hijo con índice playerInput ("Left" = 0, "Right" = 1) */
	method transicionArbol(){
		nodoActual = self.nodoActual().hijos().get(playerInput)
		/** Reproduce un sonido de transición */
		game.schedule(0, {(game.sound("assets/glitch-"+0.randomUpTo(1).roundUp(0).toString()+".mp3").play())})
	}
	
	/** Función del estado siguiente. Acá muere la programación orientada a objetos
		Este método lo modificamos para agregar cualquier funcionalidad que no nos permite el árbol */
	method estadoSiguiente(){
		/** Si el estado actual es del quiz */
		if (estados.take(7).contains(estadoActual)) {
			/** Si el jugador eligió la respuesta correcta, incrementa el puntaje y suena "yay" */
			if (estadoActual.audioInput().get(playerInput) == "correct-yay") {
				game.schedule(0, {(game.sound("assets/correct-yay.mp3").play())})
				puntaje++
			}
			/** Si el jugador eligió la respuesta incorrecta, suena "buzzer" */
			else {
				game.schedule(0, {(game.sound("assets/incorrect-buzzer.mp3").play())})
			}
			/** Si está en la última pregunta del quiz, la transición depende del puntaje */
			if (estadoActual == estados.get(6)) {
				/** Detiene la música del quiz */
				game.schedule(0, {musicaQuiz.pause()})
				estadoActual = estados.get(estadoActual.transiciones().get(puntaje))
			}
			/** Por defecto la transición es al primer elemento de la lista de transiciones */
			else {
				estadoActual = estados.get(estadoActual.transiciones().first())
			}
		}
		/** Si el nodo actual es el nodo del estudiante */
		if (nodoActual == nodoEstudiante)
			/** Va al estado inicial del quiz 2 */
			estadoActual = estadosQuiz2.first()
			/** Continúa la música del quiz */
			if (musicaQuiz.paused()) {game.schedule(0, {musicaQuiz.resume()})}
		/** Si el estado actual está en el quiz 2 */
		if (estadosQuiz2.contains(estadoActual)) {
			/** Si el jugador eligió la respuesta correcta, suena "yay" */
			if (estadoActual.audioInput().get(playerInput) == "correct-yay") {
				game.schedule(0, {(game.sound("assets/correct-yay.mp3").play())})
			}
			/** Si el jugador eligió la respuesta incorrecta, suena "buzzer" */
			else {
				game.schedule(0, {(game.sound("assets/incorrect-buzzer.mp3").play())})
			}
			/** Si está en la última pregunta del quiz, la transición es a la subtrama facu */
			if (estadoActual == estadosQuiz2.get(4)) {
				/** Detiene la música del quiz */
				game.schedule(0, {musicaQuiz.pause()})
				estadoActual = subtramaFacu
			}
			/** Por defecto la transición es al primer elemento de la lista de transiciones */
			else {
				estadoActual = estadosQuiz2.get(estadoActual.transiciones().first())
			}
		}
		/** El nodo sigue al estado */
		nodoActual = estadoActual
	}
	
	/** Método del cambio de pantalla */
	method act(){
		/** Si el nodo actual no tiene hijos, entonces la transición es al estado siguiente */
		if (nodoActual.hijos().isEmpty()) {
			self.estadoSiguiente()
		}
		/** Si el nodo actual tiene hijos, entonces la transición es a alguno de ellos */
		else {
			self.transicionArbol()
		}
		/** Actualiza la pantalla */
		pantalla.image("assets/imagen-"+nodoActual.imageID().toString()+".png")
		/** Reproduce el sonido del nuevo nodo */
		game.schedule(0, {(game.sound("assets/"+nodoActual.audio()+".mp3").play())})
	}
	
	method init() {
		/** Ancho de la pantalla (en celdas) */
		game.width(1024)
		/** Alto de la pantalla (en celdas) */
  		game.height(896)
  		/** Tamaño de la celda (en píxeles) */
  		game.cellSize(1)
  		/** Título de la ventana del juego */
  		game.title("The Big Quiz")
  		/** Fondo del juego */
  		game.boardGround("assets/black.jpg")
  		/** Agrega la imagen de la pantalla */
  		game.addVisual(pantalla)
  		/** Configura la música del quiz para que suene en loop */
		musicaQuiz.shouldLoop(true)
		/** Ajusta el volumen de los sonidos */
		musicaQuiz.volume(0.05)
		/** Reproduce la música del quiz */
		game.schedule(0, {musicaQuiz.play()})
		
		
		/** Cuando el jugador presiona "Left" */
		keyboard.left().onPressDo({
			playerInput = 0
			self.act()
		})
		/** Cuando el jugador presiona ""Right */
		keyboard.right().onPressDo({
			playerInput = 1
			self.act()
		})
		
		/** Inicia el juego */
		game.start()
	}
}
