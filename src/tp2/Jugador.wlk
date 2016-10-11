import Pelotas.*
import Escobas.mercadoDeEscobas
import Suerte.*

class Jugador {
	var skills
	var peso
	var fuerza
	var escoba
	var equipo
	
	constructor(_skills,_peso,_fuerza,_escoba) {
		skills 	= 	_skills
		peso 	=	_peso
		fuerza 	= 	_fuerza
		escoba 	= 	_escoba
	}
	
	method skills() = skills
	method skillsQueGanaPorBloquear() =	3
	method aumentarSkills(num)		{ skills += num }
	method disminuirSkills(num)		{ skills -= num }
	method ganarSkillsPorBloquear() {
		self.aumentarSkills(self.skillsQueGanaPorBloquear())
	}
	
	method peso() = peso
	method fuerza() = fuerza
	method escoba() = escoba
	method velocidad() = escoba.velocidadEscoba() * self.manejoDeEscoba()
	method habilidad() = self.velocidad() + skills
	method reflejos() = self.velocidad() * skills / 100
	method manejoDeEscoba() = skills / peso

	method equipo() = equipo
	method equipoRival() = equipo.rival()
	method asignarEquipo(suEquipo)		{ equipo = suEquipo }
	
	method esBlancoUtil() =	self.esJugadorEstrella()
	method velocidadDeEscoba() = escoba.velocidadEscoba()
	method saludDeEscoba() = escoba.saludEscoba()
	method puedeBloquearA(jugador) = self.lePasaElTrapoA(jugador) || suerte.tieneSuerte()
	method lePasaElTrapoA(otroJug) = self.habilidad() >= 2.0 * otroJug.habilidad()

	method hacerJugada()
	
	method puedeTenerLaQuaffle()
	method tieneLaQuaffle() = quaffle.tieneDuenio() && quaffle.duenio() === self
	method ganaLaQuaffle() {}
	method pierdeLaQuaffle() {}
	
	
	method esGroso() {
		return self.habilidad() > equipo.promedioHabilidad() 
		&& self.velocidad() >= mercadoDeEscobas.velocidadMinimaParaSerGroso()
	}
	
	method esJugadorEstrella(){
		return self.equipoRival().jugadores().all({jugadorRival => self.lePasaElTrapoA(jugadorRival)})
	}

	method bludgereado() {
		self.disminuirSkills(2)
		escoba.recibeGolpe()
	}
}
