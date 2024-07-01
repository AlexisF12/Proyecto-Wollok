import wollok.game.*
import _01_juego.*
import _03_frames.*
import _04_elementosEnEscenario.*
import _05_sonidos.*
import _06_animacion.*
import _07_personaje.*
import _08_armas.*

class Escenario {
	method dimensionarEscenario() {
		game.cellSize(100)
		game.height(10)
		game.width(19)
		game.boardGround("interfaces/Inicio.png")
		game.title("El Eternauta")
	}
}

class Nivel inherits Escenario {

	const property frames
	var property indiceFrame = 0
	var property indiceNivel
	var property sound = new MusicaJuego()

	method reiniciarNivel() {
		game.clear()
		sound.reanudarMusica()
		juan.resetearFuncionalidades()
		self.jugarNivel()
	}

	method pasarDeNivel() {
		sound.pararMusica()
		game.clear()
		juan.resetearFuncionalidades()
		juego.numeroNivel(indiceNivel)
		juego.iniciar()
	}

	method mostrarHistoria()

	method jugarNivel() {
		self.agregarVisuales()
		juan.activarTeclas()
	}

	method agregarVisuales() {
		game.addVisual(juan)
		game.addVisual(puntuacion)
		game.addVisual(vidaJuan)
		const botiquin = new Botiquin()
		botiquin.generarBotiquines()
	}

}

object nivel1 inherits Nivel(frames = [ historiaUno, historiaDos, historiaTres ], indiceNivel = 1) {

	override method dimensionarEscenario() {
		super()
		menu.mostrar()
	}

	override method mostrarHistoria() {
		if (indiceFrame < frames.size()) {
			frames.get(indiceFrame).mostrar()
		} else {
			game.clear()
			mainMenu.mostrar()
		}
	}

	override method jugarNivel() {
		super()
		const cascarudo = new Cascarudo()
		cascarudo.generarEnemigos()
	}

	override method agregarVisuales() {
		game.addVisual(escenario1)
		super()
	}
}

object nivel2 inherits Nivel(frames = [ historiaCuatro ], indiceNivel = 2) {

	override method dimensionarEscenario() {
		super()
		game.clear()
		objetivoLogradoNivel1.mostrar()
	}

	override method mostrarHistoria() {
		if (indiceFrame < frames.size()) {
			frames.get(indiceFrame).mostrar()
		} else {
			selectArma1.mostrar()
		}
	}

	override method jugarNivel() {
		super()
		const hombreRobots = new HombreRobot()
		hombreRobots.generarEnemigos()
	}

	override method agregarVisuales() {
		game.addVisual(cielo)
		game.addVisual(cerca)
		game.addVisual(calle2)
		game.addVisual(calle)
		super()
	}
}

object nivel3 inherits Nivel(frames = [ historiaCinco ], indiceNivel = 3) {

	override method dimensionarEscenario() {
		super()
		game.clear()
		objetivoLogradoNivel2.mostrar()
	}

	override method mostrarHistoria() {
		if (indiceFrame < frames.size()) {
			frames.get(indiceFrame).mostrar()
		} else {
			selectArma2.mostrar()
		}
	}
	
	override method reiniciarNivel() {
		game.clear()
		sound.reanudarMusica()
		vidaEscudoRayo.resetearVida()
		juan.resetearFuncionalidades()
		self.jugarNivel()
	}

	override method jugarNivel() {
		super()
		mano.accionarArma()
	}

	override method agregarVisuales() {
		game.addVisual(casaRosada)
		game.addVisual(calle)
		game.addVisual(calle2)
		super()
		game.addVisual(vidaEscudoRayo)
		game.addVisual(mano)
		game.addVisual(rayo1)
		game.addVisual(rayo2)
	}
}