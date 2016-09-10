class Jugador {
	var posicion
	var skills
	var peso
	var fuerza
	var escoba
	var punteria
	var vision
	constructor(_posicion,_skills,_peso,_fuerza,_escoba,_punteria,_vision) {
		posicion = _posicion
		skills = _skills
		peso = _peso
		fuerza = _fuerza
		escoba = _escoba
		punteria = _punteria
		vision = _vision
	}
	method posicion() {
		return posicion
	}
	method skills() {
		return skills
	}
	method peso() {
		return peso
	}
	method fuerza() {
		return fuerza
	}
	method escoba() {
		return escoba
	}
	method velocidadDeEscoba() {
		return escoba.velocidadEscoba()
	}
	method saludDeEscoba() {
		return escoba.saludEscoba()
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
		return self.habilidad() >= 2.0 * otroJugador.habilidad()
	}
	method bludgereado() {
		skills -= 2
		escoba.recibeGolpe()
	}
}



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
		return jugadores.filter({unJugador => unJugador.habilidad() > self.promedioHabilidad() && unJugador.velocidad() >= mercadoDeEscobas.velocidadMinimaParaSerGroso()})
	}
	method tieneJugadorEstrellaParaJugarContra(otroEquipo) {
		return jugadores.any({unJugador => otroEquipo.jugadores().all({otroJugador => unJugador.lePasaElTrapoA(otroJugador)})})
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
	method saludEscoba() {
		return salud
	}
	method recibeGolpe() {
		salud -= 10
	}
}



object saetaDeFuego {
	method velocidadEscoba() {
		return 100
	}
	method saludEscoba() {
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