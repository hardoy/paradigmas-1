class Equipo {
	var jugadores
	method jugadores() {
		return jugadores
	}
	method promedioHabilidad() {
		return jugadores.sum({unJugador => unJugador.habilidad()}) / jugadores.size() 
	}
	method jugadoresGrosos() {
		return jugadores.filter({unJugador => unJugador.habilidad() > jugadores.promedioHabilidad() && unJugador.velocidad() >= mercadoDeEscobas.velocidadMinimaParaSerGroso()})
	}
	method tieneJugadorEstrellaParaJugarContra(otroEquipo) {
		return jugadores.any({unJugador => otroEquipo.jugadores().all({otroJugador => unJugador.lePasaElTrapoA(otroJugador)})})
	}
	constructor(_jugadores) {
		jugadores = _jugadores
	}
}

class Jugador {
	var posicion
	var peso
	var skills
	var fuerza
	var escoba
	var punteria
	var vision
	method posicion() {
		return posicion
	}
	method peso() {
		return peso
	}
	method skills() {
		return skills
	}
	method fuerza() {
		return fuerza
	}
	method punteria() {
		return punteria
	}
	method vision() {
		return vision
	}
	method manejoDeEscoba() {
		return skills / peso
	}
	method velocidad() {
		return escoba.velocidadEscoba() * self.manejoDeEscoba()
	}
	method habilidad() {
		return posicion.habilidadPosicion(self)
	}
	method lePasaElTrapoA(otroJugador) {
		return self.habilidad() > 2 * otroJugador.habilidad()
	}
	method bludgereado() {
		skills -= 2
		escoba.recibeGolpe()
	}
	constructor(_posicion,_peso,_skills,_fuerza,_escoba,_punteria,_vision) {
		posicion = _posicion
		peso = _peso
		skills = _skills
		fuerza = _fuerza
		escoba = _escoba
		punteria = _punteria
		vision = _vision
	}
}

class Nimbus {
	var modelo
	var salud
	method velocidadEscoba() {
		return (80 - (new Date().year() - modelo)) * salud / 100
	}
	method recibeGolpe() {
		salud -= 10
	}
	constructor(_modelo,_salud) {
		modelo = _modelo
		salud = _salud
	}
}

object saetaDeFuego {
	method velocidadEscoba() {
		return 100
	}
	method recibeGolpe() {

	}
}

object cazador {
	method habilidadPosicion(jugador) {
		return jugador.velocidad() + jugador.skills() + jugador.punteria() * jugador.fuerza()
	}
}

object golpeador {
	method habilidadPosicion(jugador) {
		return jugador.velocidad() + jugador.skills() + jugador.punteria() + jugador.fuerza()
	}
}

object guardian {
	method habilidadPosicion(jugador) {
		return jugador.velocidad() + jugador.skills() + self.reflejos(jugador) + jugador.fuerza()
	}
	method reflejos(jugador) {
		return 20 + jugador.velocidad() * jugador.skills() / 100
	}
}

object buscador {
	method habilidadPosicion(jugador) {
		return jugador.velocidad() + jugador.skills() + self.reflejos(jugador) * jugador.vision()
	}
	method reflejos(jugador) {
		return jugador.velocidad() * jugador.skills() / 100
	}
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