import wollok.game.*

class Node {
	var imageId
	var leftChild = null
	var rightChild = null

	method getImageId()= imageId
	method getLeftChild()= leftChild
	method getRightChild()= rightChild
	method leftIsCorrect()= false
}

class NodeQuiz {
	var imageId
	var nextNode = null
	var left = false
	method getImageId()= imageId
	method getLeftChild()= nextNode
	method getRightChild()= nextNode
	method leftIsCorrect()= left
	
}

object scene {
	var property position = game.at(0,0)
	var property image = "assets/image-0.png"
}

object text {
	var property position = game.at(0,9)
	var property text = "0"
}

object tree {
	var currentNode
	var currentScene = scene
	var score = 0
	
	method selectLeftOption(){
		if (currentNode.leftIsCorrect()) {
			score++
		}
		currentNode = currentNode.getLeftChild()
		self.act()
	}
	
	method selectRightOption() {
		if (!currentNode.leftIsCorrect()) {
			score++
		}
		currentNode = currentNode.getRightChild()
		self.act()
	}
	
	method buildTree() {
		const node4 = new NodeQuiz(imageId=4)
		const node3 = new NodeQuiz(imageId=3, nextNode=node4, left=true)
		const node2 = new NodeQuiz(imageId=1, nextNode=node3, left=true)
		currentNode = new NodeQuiz(imageId=0, nextNode=node2, left=false)
	}
	
	method act(){
		 scene.image("assets/image_"+currentNode.getImageId().toString()+".png")
		 text.text(score.toString())
	}
	
	
	method init(){
		game.width(1024)
  		game.height(720)
  		game.cellSize(1)
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
