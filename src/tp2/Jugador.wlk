import Pelotas.*
import Escobas.mercadoDeEscobas
import Suerte.*

class Jugador {
	var skills
	var peso
	var fuerza
	var escoba
	var equipo
	var suerte
	
	constructor(_skills,_peso,_fuerza,_escoba) {
		skills 	= 	_skills
		peso 	=	_peso
		fuerza 	= 	_fuerza
		escoba 	= 	_escoba
	}
	
	method skills() =			return skills
	method ganarSkillsPorBloquear() { self.aumentarSkills(3) }
	method aumentarSkills(num)		{ skills =+ num }
	method disminuirSkills(num)		{ skills =- num }
	method peso() =				return peso
	method fuerza() = 			return fuerza
	method escoba() = 			return escoba
	method velocidad() =			return escoba.velocidadEscoba() * self.manejoDeEscoba()
	method habilidad() =			return self.velocidad() + skills
	method reflejos() =			return self.velocidad() * skills / 100
	method manejoDeEscoba() =		return skills / peso
	method suerte(_suerte)	{ suerte = _suerte }

	method equipo() =			return equipo
	method equipoRival() =	return equipo.rival()
	method asignarEquipo(suEquipo)		{ equipo = suEquipo }
	
	method esBlancoUtil() =	return self.esJugadorEstrella() || self.tieneLaQuaffle()
	method velocidadDeEscoba() = 		return escoba.velocidadEscoba()
	method saludDeEscoba() = 		return escoba.saludEscoba()
	method puedeBloquearA(jugador) = 	return self.lePasaElTrapoA(jugador) || suerte.tieneSuerte()
	method lePasaElTrapoA(otroJug) =		return self.habilidad() >= 2.0 * otroJug.habilidad()

	method hacerJugada()
	
	method puedeTenerLaQuaffle()
	method tieneLaQuaffle() =		return quaffle.laTiene() === self
	
	method esGroso() {
		return self.habilidad() > equipo.promedioHabilidad() 
		&& self.velocidad() >= mercadoDeEscobas.velocidadMinimaParaSerGroso()
	}
	
	method esJugadorEstrella(){
		return self.equipoRival().jugadores().all({jugadorRival => self.lePasaElTrapoA(jugadorRival)})
	}

	method bludgereado() {
		skills -= 2
		escoba.recibeGolpe()
	}
}
