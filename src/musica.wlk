import wollok.game.*

class Musica {
	var archivo
	var volumen
	var cancion = null

	method inicializar() {
		cancion = game.sound(archivo)
		cancion.volume(volumen)
	}
  
	method alternar() {
		if (cancion.paused()) {
			cancion.resume()
		}
		else if (cancion.played()) {
			cancion.pause()
		}
		else {
			cancion.play()
		}
	}
	
	method shouldLoop(bool) {
		cancion.shouldLoop(bool)
	}
	
}

const silence = new Musica(archivo = "assets/silence.mp3", volumen = 1)
const quiz = new Musica(archivo = "assets/dreamscape.mp3", volumen = 0.1)
const terror = new Musica(archivo = "assets/horror-background-atmosphere.mp3", volumen = 0.25)
const kevin = new Musica(archivo = "assets/not-as-it-seems.mp3", volumen = 0.15)
const minijuego = new Musica(archivo = "assets/minijuego.mp3", volumen = 0.4)
const hero = new Musica(archivo = "assets/hero.mp3", volumen = 0.1)
const chad = new Musica(archivo = "assets/can-you-feel-my-heart.mp3", volumen = 0.1)
const last_resort = new Musica(archivo = "assets/last-resort.mp3", volumen = 0.1)
const zombie = new Musica(archivo = "assets/zombie.mp3", volumen = 0.1)
const my_way = new Musica(archivo = "assets/my-way.mp3", volumen = 0.1)
const tension = new Musica(archivo = "assets/disturbing-call.mp3", volumen = 0.4)
const what_you_deserve = new Musica(archivo = "assets/what-you-deserve.mp3", volumen = 0.05)
const untitled = new Musica(archivo = "assets/untitled.mp3", volumen = 0.1)
const eminem = new Musica(archivo = "assets/till-i-collapse.mp3", volumen = 0.07)
const kevin2 = new Musica(archivo = "assets/volatile-reaction.mp3", volumen = 0.15)
const evanescence = new Musica(archivo = "assets/bring-me-to-life.mp3", volumen = 0.1)
const in_the_end = new Musica(archivo = "assets/in-the-end.mp3", volumen = 0.4)
