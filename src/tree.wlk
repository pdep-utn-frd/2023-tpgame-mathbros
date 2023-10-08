import wollok.game.*

/** Clase nodo para la sección de aventuras */
class Node {
	/** Atributos de la calse: imagen, audio */
	var property imageID
	var property audioID = "silence"
	
	var property leftIsCorrect = false
	
	/** Nodos hijos */
	var property leftChild = null
	var property rightChild = null
}

object scene {
	var property position = game.at(0,0)
	var property image = "assets/imagen-0.png"
}

object text {
	var property position = game.at(0,9)
	var property text = "0"
}

object tree {
	var currentNode = currentNode = new Node(imageID=0)
	const currentScene = scene
	var score = 0
	var end_quiz = null
	var transition = end_quiz
	
	method selectLeftOption(){
		if (currentNode.leftIsCorrect()) {
			game.schedule(0, {(game.sound("assets/right-yay.mp3").play())})
			score++
		}
		else {game.schedule(0, {(game.sound("assets/wrong-buzzer.mp3").play())})}
		currentNode = currentNode.leftChild()
		self.act()
	}
	
	method selectRightOption() {
		if (currentNode.leftIsCorrect()) {game.schedule(0, {(game.sound("assets/wrong-buzzer.mp3").play())})}
		else {
			game.schedule(0, {(game.sound("assets/right-yay.mp3").play())})
			score++
		}
		currentNode = currentNode.rightChild()
		self.act()
	}
	
	method buildTree() {
		/** Nodos de la aventura */
		
		/** Nodos del quiz */
		const node7 = new Node(imageID=7, leftChild=transition, rightChild=transition)
		const node6 = new Node(imageID=6, leftChild=node7, rightChild=node7)
		const node5 = new Node(imageID=5, leftChild=node6, rightChild=node6)
		const node4 = new Node(imageID=4, leftChild=node5, rightChild=node5)
		const node3 = new Node(imageID=3, leftChild=node4, rightChild=node4, leftIsCorrect = true)
		const node2 = new Node(imageID=2, leftChild=node3, rightChild=node3)
		const node1 = new Node(imageID=1, leftChild=node2, rightChild=node2)
		currentNode = new Node(imageID=0, leftChild=node1, rightChild=node1, leftIsCorrect = true)
	}
	
	method act(){
		self.quiz_result()
		scene.image("assets/imagen-"+currentNode.imageID().toString()+".png")
		text.text(score.toString())
		game.schedule(1000, {(game.sound("assets/"+currentNode.audioID()+".mp3").play())})
	}
	
	method quiz_result(){
		/** Asigna un nodo a la transición (transition) en función del resultado (score) */
		if (score == 0) {
			end_quiz = new Node(imageID=7,  audioID="cuestionario_0_de_7")
		}
		if (score == 1) {
			end_quiz = new Node(imageID=8,  audioID="cuestionario_1_de_7")
		}
		if ((score == 2) or (score == 3) or (score == 4)) {
			end_quiz = new Node(imageID=9,  audioID="cuestionario_2_de_7")
		}
		if ((score == 5) or (score == 6)) {
			end_quiz = new Node(imageID=10, audioID="cuestionario_5_de_7")
		}
		if (score == 7) {
			end_quiz = new Node(imageID=11, audioID="cuestionario_7_de_7")
		}
	}
	
	method init(){
		game.width(1024)
  		game.height(768)
  		game.cellSize(1)
  		game.title("The Big Quiz")
  		self.buildTree()
  		self.act()
		game.addVisual(currentScene)
		game.addVisual(text)
		
		keyboard.left().onPressDo({
			self.selectLeftOption()
		})
		keyboard.right().onPressDo({
			self.selectRightOption()
		})
		
		game.start()
	}
}
