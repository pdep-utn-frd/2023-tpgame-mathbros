import wollok.game.*

class Node {
	var imageId
	var leftChild = null
	var rightChild = null

	method getImageId()= imageId
	method getLeftChild()= leftChild
	method getRightChild()= rightChild
}

object scene {
	var property position = game.at(0,0)
	var property image = "assets/image-0.jpg"
}

object text {
	var property position = game.at(0,9)
	method text()= "Hola!"
}

object tree {
	var currentNode
	var currentScene = scene
	
	method selectLeftOption(){
		currentNode = currentNode.getLeftChild()
		self.act()
	}
	
	method selectRightOption() {
		currentNode = currentNode.getRightChild()
		self.act()
	}
	
	method buildTree() {
		const node2 = new Node(imageId=1)
		currentNode = new Node(imageId=0, leftChild=node2, rightChild=node2)
	}
	
	method act(){
		 scene.image("assets/image-"+currentNode.getImageId().toString()+".jpg") 
	}
	
	
	method init(){
		game.width(10)
  		game.height(10)
  		game.cellSize(50)
  		game.title("Quiz comun y corriente")
		game.addVisual(currentScene)
		game.addVisual(text)
		self.buildTree()
		self.act()
		
		keyboard.left().onPressDo({
			self.selectLeftOption()
		})
		keyboard.right().onPressDo({
			self.selectRightOption()
		})
		
		game.start()
	}
}
