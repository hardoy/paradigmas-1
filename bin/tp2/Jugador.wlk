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
	
	method skills() =			return skills
	method modificarSkills(num)		{ skills =+ num }
	method peso() =				return peso
	method fuerza() = 			return fuerza
	method escoba() = 			return escoba
	method velocidadDeEscoba() = 		return escoba.velocidadEscoba()
	method saludDeEscoba() = 		return escoba.saludEscoba()
	method tieneLaQuaffle() =		return quaffle.laTiene() === self
	method equipo() =			return equipo
	method asignarEquipo(suEquipo)		{ equipo = suEquipo }
	method skillsPorBloquear()		{ skills += 3 }
	method puedeTenerLaQuaffle() = 		return false
	method esBlancoUtil(equipoRival)=	return self.esJugadorEstrella(equipoRival) || self.tieneLaQuaffle()
	method verSiPuedeBloquearA(cazador) = 	return self.lePasaElTrapoA(cazador) || suerte.tieneSuerte()
	method reflejos() =			return self.velocidad() * skills / 100
	method manejoDeEscoba() =		return skills / peso
	method velocidad() =			return escoba.velocidadEscoba() * self.manejoDeEscoba()
	method habilidad() =			return self.velocidad() + skills
	method lePasaElTrapoA(otroJug)=		return self.habilidad() >= 2.0 * otroJug.habilidad()
	method ganaLaQuaffle(){}
	method pierdeLaQuaffle(){}
	method hacerJugada(rival){}
	
	method esGroso() {
		return self.habilidad() > equipo.promedioHabilidad() 
		&& self.velocidad() >= mercadoDeEscobas.velocidadMinimaParaSerGroso()
	}
	method esJugadorEstrella(equipoRival){
		return equipoRival.jugadores().all({jugadorRival => self.lePasaElTrapoA(jugadorRival)})
	}

	method bludgereado(rival) {
		skills -= 2
		escoba.recibeGolpe()
	}
}