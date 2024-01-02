import wollok.game.*

class  Item {
	var property position
	var delay
	var delayCount = 0
	
	method image() = null
	

	
	method mover() {
		delayCount++
		
		if(delayCount == delay){
			position = game.at(position.x(), position.y() - 1)
			delayCount = 0
		}
	}
	
	method cambioPuntaje()= 0
}

class Banana inherits Item {
	override method image()= "assets/banana.png"
	override method cambioPuntaje() = 2
}

class Mate inherits Item {
	override method image()= "assets/mate.png"
	override method cambioPuntaje() = 4
}

class Cafe inherits Item {
	override method image()= "assets/cafe.png"
	override method cambioPuntaje() = -15
}



object puntaje {
	var property valor = 0
	method position() = game.at(1, 26)
	
	method text() = "Puntaje: "+valor
	
	method textColor() = "#FFFFFF"

}

object jugador {
	var property position = game.at(1, 1)
	var property image = "assets/mono1.png"
	
	method moverIzq() {
		image = "assets/mono1.png"
		if (position.x() != 0 ){	
			position = game.at(position.x() - 1, position.y())
		}
	}
	method moverDer() {
		image = "assets/mono2.png"
		if (position.x() != 31 ){	
			position = game.at(position.x() + 1, position.y())
		}
	}
}