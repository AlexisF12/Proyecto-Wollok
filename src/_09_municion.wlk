import wollok.game.*
import _07_personaje.*
import _04_elementosEnEscenario.*

class Municion inherits Objeto(esMunicion = true) {

	const property danio
	const property id = self.identity().toString()
	var property enTablero = true // verifico si la bala sigue en el tablero

	method salirDisparada()

	method desplazarse()

	override method desactivarFuncionalidades() {
		if (enTablero) { // Verifica si la bala está en el tablero antes de removerla
			game.removeVisual(self)
			game.removeTickEvent(id)
			enTablero = false // Actualiza el estado
		}
	}
}

class MunicionMano inherits Municion(esEnemigo = true) {

	var property yaCausoDanio = false

	override method salirDisparada() {
		game.addVisual(self)
	}

}

class MunicionRayoMortifero inherits MunicionMano (danio = 30, image = "Bola_de_fuego.png") {

	override method salirDisparada() {
		super()
		game.onTick(50, id + "_RayoMortifero", { self.desplazarse()})
	}

	override method desactivarFuncionalidades() {
		if (enTablero) { // Verifica si la bala está en el tablero antes de removerla
			game.removeVisual(self)
			game.removeTickEvent(id + "_RayoMortifero")
			enTablero = false // Actualiza el estado
		}
	}

	override method desplazarse() {
		position = self.position().left(1)
		if (self.position().x() < -1) {
			self.desactivarFuncionalidades()
		}
	}

}

class RayoNave inherits MunicionMano(danio = 30, image = "Bola_de_fuego_2.png") {

	override method salirDisparada() {
		super()
		game.onTick(50, id + "_RayoNave", { self.desplazarse()})
	}

	override method desactivarFuncionalidades() {
		if (enTablero) { // Verifica si la bala está en el tablero antes de removerla
			game.removeVisual(self)
			game.removeTickEvent(id + "_RayoNave")
			enTablero = false // Actualiza el estado
		}
	}

	override method desplazarse() {
		position = self.position().down(1)
		if (self.position().y() < 1) {
			self.desactivarFuncionalidades()
		}
	}

}

class MunicionHombreRobot inherits Municion(danio = 40, image = "arma/Bala_De_Arma_Hombre_Robot.png", esEnemigo = true) {

	var property yaCausoDanio = false

	override method salirDisparada() {
		game.addVisual(self)
		game.onTick(150, id + "_balaDeRobot", { self.desplazarse()})
	}

	override method desactivarFuncionalidades() {
		if (enTablero) { // Verifica si la bala está en el tablero antes de removerla
			game.removeVisual(self)
			game.removeTickEvent(id + "_balaDeRobot")
			enTablero = false // Actualiza el estado
		}
	}

	override method desplazarse() {
		position = self.position().left(1)
		if (self.position().x() < -1) {
			self.desactivarFuncionalidades()
		}
	}

}

class MunicionJuan inherits Municion(position = game.at(juan.position().x() + 2, juan.position().y())) {

	override method salirDisparada() {
		game.addVisual(self)
		game.onCollideDo(self, { objeto => if (objeto.esEnemigo() && !objeto.esMunicion()) { objeto.serImpactado(self) self.desactivarFuncionalidades()}			
		})
	}

	override method desplazarse() {
		position = self.position().right(1)
		if (self.position().x() > game.width()) {
			self.desactivarFuncionalidades()
		}
	}

}

class BalaDeRifle inherits MunicionJuan(danio = 100, image = "arma/Bala_De_Rifle-26x12.png") {

	override method salirDisparada() {
		super()
		game.onTick(70, id, { self.desplazarse()})
	}

}

class BalaDeRevolver inherits MunicionJuan(danio = 50, image = "arma/Bala_De_Revolver-13x10.png") {

	override method salirDisparada() {
		super()
		game.onTick(50, id, { self.desplazarse()})
	}

}

class BalaDeFusil inherits MunicionJuan(danio = 40, image = "arma/Bala_De_Fusil-24x9.png") {

	override method salirDisparada() {
		super()
		game.onTick(20, id, { self.desplazarse()})
	}

}

