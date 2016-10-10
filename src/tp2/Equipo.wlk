import Pelotas.*

class Equipo {
	var jugadores
	var puntos = 0
	var rival
	
	constructor(_jugadores) {
		jugadores = _jugadores
		jugadores.foreach({ unJugador => unJugador.asignarEquipo(self) })
	}
	method jugadores() = 		return jugadores
	method puntos() = 		return puntos
	method rival() =	return rival
	method rival(_rival) { rival = _rival }
	method ganarPuntos(nuevosPuntos){ puntos += nuevosPuntos}
	method promedioHabilidad() = 	return jugadores.sum({unJugador => unJugador.habilidad()}) / jugadores.size() 
	method jugadoresGrosos() = 	return jugadores.filter({unJugador => unJugador.esGroso()})
	method jugadorUtiles() = 	return jugadores.filter({unJugador => unJugador.esBlancoUtil()})
	method tieneLaQuaffle() = 	return jugadores.any({ unJugador => unJugador.tieneLaQuaffle()})
	method jugadoresQuePuedenTenerQuaffle() = return jugadores.filter({unJugador => unJugador.puedeTenerLaQuaffle()})
	
	method jugadoresOrdenadosPorVelocidad(){
		return jugadores.sortedBy({unJugadorRapido, otroJugadorLento  => unJugadorRapido.velocidad() > otroJugadorLento.velocidad()})
	}
	
	method tieneJugadorEstrellaParaJugarContra(otroEquipo) {
		return jugadores.any({unJugador => unJugador.esJugadorEstrella(otroEquipo)})
	}
	
	method ganaLaQuaffle(){
		if(!self.tieneLaQuaffle()){
			self.jugadoresQuePuedenTenerQuaffle().max({ jugador => jugador.velocidad()}).ganaLaQuaffle()
		}
	}
	
	method pierdeLaQuaffle(){
		if(self.tieneLaQuaffle()){
			rival.ganaLaQuaffle()
		}
	}
	
	method encontrarBloqueadorDe(jugador) {
		return self.jugadoresOrdenadosPorVelocidad().find({unJugador => unJugador.puedeBloquearA(jugador)})
	} 
}