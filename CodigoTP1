class Jugador {
	var skills
	var peso
	var fuerza
	var escoba
	constructor(_skills,_peso,_fuerza,_escoba) {
		skills = _skills
		peso = _peso
		fuerza = _fuerza
		escoba = _escoba
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
	method manejoDeEscoba() {
		return skills / peso
	}
	method velocidad() {
		return escoba.velocidadEscoba() * self.manejoDeEscoba()
	}
	method habilidad() {
		return self.velocidad() + skills
	}
	method lePasaElTrapoA(otroJugador) {
		return self.habilidad() >= 2.0 * otroJugador.habilidad()
	}
	method bludgereado() {
		skills -= 2
		escoba.recibeGolpe()
	}
	method esGroso(equipo) {
		return self.habilidad() > equipo.promedioHabilidad() && self.velocidad() >= mercadoDeEscobas.velocidadMinimaParaSerGroso()
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
		return jugadores.filter({unJugador => unJugador.esGroso(self)})
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



class Cazador inherits Jugador {
	var punteria
	constructor(_skills,_peso,_fuerza,_escoba,_punteria) = super(_skills,_peso,_fuerza,_escoba) {
		punteria = _punteria
	}
	method punteria() {
		return punteria
	}
	override method habilidad() {
		return punteria * fuerza + super()
	}
}
class Golpeador inherits Jugador {
	var punteria
	constructor(_skills,_peso,_fuerza,_escoba,_punteria) = super(_skills,_peso,_fuerza,_escoba) {
		punteria = _punteria
	}
	method punteria() {
		return punteria
	}
	override method habilidad() {
		return punteria + fuerza + super()
	}
}
class Guardian inherits Jugador {
	constructor(_skills,_peso,_fuerza,_escoba) = super(_skills,_peso,_fuerza,_escoba)
	override method habilidad() {
		return self.reflejos() + fuerza + super()
	}
	method reflejos() {
		return 20 + self.velocidad() * skills / 100
	}
}
class Buscador inherits Jugador {
	var vision
	constructor(_skills,_peso,_fuerza,_escoba,_vision) = super(_skills,_peso,_fuerza,_escoba) {
		vision = _vision
	}
	override method habilidad() {
		return self.reflejos() * vision + super()
	}
	method reflejos() {
		return self.velocidad() * skills / 100
	}
}
