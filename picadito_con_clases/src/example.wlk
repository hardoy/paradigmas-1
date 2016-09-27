class Equipo {
	var jugadores
	constructor(_jugadores) {
		jugadores = _jugadores
	}
	method jugadores() {
		return jugadores
	}
	method promedioHabilidad() {
		return jugadores.sum({unJugador => unJugador.habilidad()}) / jugadores.size() 
	}
	method jugadoresGrosos() {
		return jugadores.filter({unJugador => unJugador.esGroso(self)})
	}
	method tieneJugadorEstrellaParaJugarContra(otroEquipo) {
		return jugadores.any({unJugador => otroEquipo.jugadores().all({otroJugador => unJugador.lePasaElTrapoA(otroJugador)})})
	}
}

class Jugador {
	var peso
	var skills
	var fuerza
	var escoba
	method peso() {
		return peso
	}
	method skills() {
		return skills
	}
	method fuerza() {
		return fuerza
	}
	method escoba() {
		return escoba
	}
	method manejoDeEscoba() {
		return skills / peso
	}
	method velocidad() {
		return escoba.velocidadEscoba() * self.manejoDeEscoba()
	}
	method lePasaElTrapoA(otroJugador) {
		return self.habilidad() > 2 * otroJugador.habilidad()
	}
	method bludgereado() {
		skills -= 2
		escoba.recibeGolpe()
	}
	method habilidad() {
		return self.velocidad() + skills + self.calculoHabilidadPosicion()
	}
	method calculoHabilidadPosicion()
	method esGroso(equipo) {
		return self.habilidad() > equipo.promedioHabilidad() && self.velocidad() >= mercadoDeEscobas.velocidadMinimaParaSerGroso()
	}
}

class Cazador inherits Jugador {
	var punteria
	constructor(_peso,_skills,_fuerza,_escoba,_punteria) {
		peso = _peso
		skills = _skills
		fuerza = _fuerza
		escoba = _escoba
		punteria = _punteria
	}
	method punteria() {
		return punteria
	}
	override method calculoHabilidadPosicion() {
		return punteria * fuerza
	}
}

class Golpeador inherits Jugador {
	var punteria
	constructor(_peso,_skills,_fuerza,_escoba,_punteria) {
		peso = _peso
		skills = _skills
		fuerza = _fuerza
		escoba = _escoba
		punteria = _punteria
	}
	method punteria() {
		return punteria
	}
	override method calculoHabilidadPosicion() {
		return punteria + fuerza
	}
}

class Guardian inherits Jugador {
	constructor(_peso,_skills,_fuerza,_escoba) {
		peso = _peso
		skills = _skills
		fuerza = _fuerza
		escoba = _escoba
	}
	override method calculoHabilidadPosicion() {
		return self.reflejos() + fuerza
	}
	method reflejos() {
		return 20 + self.velocidad() * skills / 100
	}
}

class Buscador inherits Jugador {
	var vision
	constructor(_peso,_skills,_fuerza,_escoba,_vision) {
		peso = _peso
		skills = _skills
		fuerza = _fuerza
		escoba = _escoba
		vision = _vision
	}
	override method calculoHabilidadPosicion() {
		return self.reflejos() * vision
	}
	method reflejos() {
		return self.velocidad() * skills / 100
	}
}

class Nimbus {
	var modelo
	var salud
	constructor(_modelo,_salud) {
		modelo = _modelo
		salud = _salud
	}
	method velocidadEscoba() {
		return (80 - (new Date().year() - modelo)) * salud / 100
	}
	method recibeGolpe() {
		salud -= 10
	}
}

object saetaDeFuego {
	method velocidadEscoba() {
		return 100
	}
	method recibeGolpe() {}
}

object mercadoDeEscobas {
	var velocidadMinimaParaSerGroso
	method velocidadMinimaParaSerGroso() {
		return velocidadMinimaParaSerGroso
	}
	method velocidadMinimaParaSerGroso(nuevaVelocidad) {
		velocidadMinimaParaSerGroso = nuevaVelocidad
	}
}