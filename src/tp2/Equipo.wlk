import Pelotas.*
import Excepciones.*

class Equipo {
	var jugadores
	var puntos = 0
	var rival
	
	constructor(_jugadores) {
		jugadores = _jugadores
		jugadores.forEach({ unJugador => unJugador.asignarEquipo(self) })
	}
	
	method jugadores() = jugadores
	method puntos() = puntos
	method rival() = rival
	method rival(_rival) { rival = _rival }
	method ganarPuntos(nuevosPuntos) { puntos += nuevosPuntos}
	method promedioHabilidad() = jugadores.sum({unJugador => unJugador.habilidad()}) / jugadores.size() 
	method jugadoresGrosos() = jugadores.filter({unJugador => unJugador.esGroso()})
	method blancosUtiles() = jugadores.filter({unJugador => unJugador.esBlancoUtil()})
	method tieneLaQuaffle() = jugadores.any({ unJugador => unJugador.tieneLaQuaffle()})
	method jugadoresQuePuedenTenerQuaffle() = jugadores.filter({unJugador => unJugador.puedeTenerLaQuaffle()})
	
	method jugadoresOrdenadosPorVelocidad(){
		return jugadores.sortedBy({unJugadorRapido, otroJugadorLento  => unJugadorRapido.velocidad() > otroJugadorLento.velocidad()})
	}
	
	method tieneJugadorEstrella() {
		return jugadores.any({unJugador => unJugador.esJugadorEstrella()})
	}
	
	method ganaLaQuaffle(){
		if(!self.tieneLaQuaffle()){
			self.jugadoresQuePuedenTenerQuaffle().max({ jugador => jugador.velocidad()}).ganaLaQuaffle()
		} else {
			throw new NoPuedeGanarLaQuaffle()
		}
	}
	
	method pierdeLaQuaffle(){
		if(self.tieneLaQuaffle()){
			rival.ganaLaQuaffle()
		} else {
			throw new NoPuedePerderLaQuaffle()
		}
	}
	
	method bloquearA(jugador) {
		try {
			return self.jugadoresOrdenadosPorVelocidad().find({unJugador => unJugador.puedeBloquearA(jugador)}) 
		} catch e:ElementNotFoundException {
			throw new NoPudoBloquear()
		}
	} 
}
