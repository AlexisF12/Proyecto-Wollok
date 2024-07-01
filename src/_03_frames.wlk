import wollok.game.*
import _07_personaje.*
import _08_armas.*
import _02_nivel.*
import _01_juego.*
import _05_sonidos.*

class Frame {
	const property image
	const property position = game.origin()
	const property sound = new MusicaMenu()
	method mostrar(){}
	method configurarTeclado(){}
}

class Historia inherits Frame {
	override method mostrar() {
		game.clear()
		game.addVisual(self.image())
		self.configurarTeclado()
	}
}

class HistoriaNivel inherits Historia {
	const property indice
	const property nivel
	
	override method configurarTeclado() {
		keyboard.space().onPressDo({ nivel.indiceFrame(indice)
			nivel.mostrarHistoria()
		})
	}
}
object historiaUno inherits HistoriaNivel(image = new Frame(image = "interfaces/HistoriaUno.png"), indice = 1, nivel = nivel1) {}
object historiaDos inherits HistoriaNivel(image = new Frame(image = "interfaces/HistoriaDos.png"), indice = 2, nivel = nivel1) {}
object historiaTres inherits HistoriaNivel(image = new Frame(image = "interfaces/HistoriaTres.png"), indice = 3, nivel = nivel1) {}
object historiaCuatro inherits HistoriaNivel(image = new Frame(image = "interfaces/HistoriaCuatro.png"), indice = 1, nivel = nivel2) {}
object historiaCinco inherits HistoriaNivel(image = new Frame(image = "interfaces/HistoriaCinco.png"), indice = 1, nivel = nivel3) {}

object historiaSeis inherits Historia(image = new Frame(image = "interfaces/HistoriaSeis.png")) {
	override method configurarTeclado() {
		keyboard.space().onPressDo({ game.clear()
			gameOver.mostrar()
		})
	}
}

object tutorial inherits Historia(image = new Frame(image = "interfaces/Tutorial.png")) {

	override method configurarTeclado() {
		keyboard.x().onPressDo({ game.clear()
			mainMenu.mostrar()
		})
	}
}

object creditosUno inherits Historia(image = new Frame(image = "interfaces/creditosUno.png")) {

	override method configurarTeclado() {
		keyboard.space().onPressDo({ game.clear()
			creditosDos.mostrar()
		})
	}
}

object creditosDos inherits Historia(image = new Frame(image = "interfaces/creditosDos.png")) {

	override method configurarTeclado() {
		keyboard.x().onPressDo({ game.clear()
			mainMenu.mostrar()
		})
	}
}


class Menu inherits Frame {
	override method mostrar() {
		game.addVisual(self.image())
		self.configurarTeclado()
	}
}

object menu inherits Menu (image = new Frame(image = "interfaces/Inicio.png")) {
	override method mostrar() {
		super()
		sound.reproducirMusica()
	}

	override method configurarTeclado() {
		keyboard.enter().onPressDo({ game.clear()
			nivel1.mostrarHistoria()
		})
	}
}

object mainMenu inherits Menu (image = new Frame(image = "interfaces/MainMenu.png")) {

	override method configurarTeclado() {
		keyboard.num1().onPressDo({ menu.sound().pararMusica()
			game.clear()
			nivel1.sound().reproducirMusica()
			nivel1.jugarNivel()
		})
		keyboard.num2().onPressDo({ game.clear()
			tutorial.mostrar()
		})
		keyboard.num3().onPressDo({ game.clear()
			creditosUno.mostrar()
		})
	}

}



class MenuObjetivoLogrado inherits Menu {
	const property nivel
	
	override method mostrar() {
		super()
		sound.reproducirMusica()
	}
	
	override method configurarTeclado() {
		keyboard.enter().onPressDo({ game.clear()
			nivel.mostrarHistoria()
		})
	}
}

object objetivoLogradoNivel1 inherits MenuObjetivoLogrado (image = new Frame(image = "interfaces/ObjetivoLogrado.png"), nivel = nivel2) {}
object objetivoLogradoNivel2 inherits MenuObjetivoLogrado (image = new Frame(image = "interfaces/ObjetivoLogrado.png"), nivel = nivel3) {}

class MenuArmas inherits Menu{
	const property objetivoLogrado
	const property nivel
	override method configurarTeclado() {
		keyboard.num1().onPressDo({ objetivoLogrado.sound().pararMusica()
			game.clear()
			juan.arma(revolver)
			nivel.sound().reproducirMusica()
			nivel.jugarNivel()
		})
		keyboard.num2().onPressDo({ objetivoLogrado.sound().pararMusica()
			game.clear()
			juan.arma(fusil)
			nivel.sound().reproducirMusica()
			nivel.jugarNivel()
		})
		keyboard.num3().onPressDo({ objetivoLogrado.sound().pararMusica()
			game.clear()
			juan.arma(rifle)
			nivel.sound().reproducirMusica()
			nivel.jugarNivel()
		})
	}
}
object selectArma1 inherits MenuArmas (image = new Frame(image = "interfaces/SelectArma.png"), objetivoLogrado = objetivoLogradoNivel1, nivel = nivel2) {}
object selectArma2 inherits MenuArmas (image = new Frame(image = "interfaces/SelectArma.png"), objetivoLogrado = objetivoLogradoNivel2, nivel = nivel3) {}

object gameOver inherits Historia(image = new Frame(image = "interfaces/GameOver.png")) {

	override method mostrar() {
		super()
		game.schedule(6000, { game.stop()})
	}
	override method configurarTeclado() {}
}

class Reinicio inherits Menu(image = new Frame(image = "interfaces/ReiniciarPartida.png")) {

	override method mostrar() {
		juego.nivelActual().sound().pausarMusica()
		game.clear()
		game.addVisual(self.image())
		self.configurarTeclado()
		sound.reproducirMusica()
	}

	override method configurarTeclado() {
		keyboard.num1().onPressDo({ sound.pausarMusica()
			juego.nivelActual().reiniciarNivel()
		})
		keyboard.num2().onPressDo({ game.schedule(200, { game.stop()})})
	}
}