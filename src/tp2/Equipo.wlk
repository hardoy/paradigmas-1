import Pelotas.*

class Equipo {
	var jugadores
	var puntos = 0
	constructor(_jugadores) {
		jugadores = _jugadores
		jugadores.map({ unJugador => unJugador.asignarEquipo(self) })
	}
	method jugadores() = 		return jugadores
	method puntos() = 		return puntos
	method ganarPuntos(nuevosPuntos){ puntos += nuevosPuntos}
	method promedioHabilidad() = 	return jugadores.sum({unJugador => unJugador.habilidad()}) / jugadores.size() 
	method jugadoresGrosos() = 	return jugadores.filter({unJugador => unJugador.esGroso()})
	method jugadorUtiles(rival) = 	return jugadores.filter({unJugador => unJugador.esBlancoUtil(rival)})
	method tieneLaQuaffle() = 	return jugadores.contains(quaffle.laTiene())
	method jugadoresQuePuedenTenerQuaffle() = return jugadores.filter({unJugador => unJugador.puedeTenerLaQuaffle()})
	method jugadoresOrdenadosPorVelocidad(){
		return jugadores.sortedBy({unJugadorRapido, otroJugadorLento  => unJugadorRapido.velocidad() > otroJugadorLento.velocidad()})
	}
	method tieneJugadorEstrellaParaJugarContra(otroEquipo) {
		return jugadores.any({unJugador => unJugador.esJugadorEstrella(otroEquipo)})
	}
	method ganaLaQuaffle(){
		if(!(self.tieneLaQuaffle())){
			self.jugadoresQuePuedenTenerQuaffle().max({ unJugador => unJugador.velocidad()}).ganaLaQuaffle()
			return true
		}
		else{return false}
	}
	method pierdeLaQuaffleAnte(rival){
		if(self.tieneLaQuaffle()){
			quaffle.laTiene().hacerJugada(rival)
			return true
		}
		else{return false}
	}
	method tratarDeBloquearA(cazador){
		return self.jugadoresOrdenadosPorVelocidad().findOrElse({unJugador => unJugador.verSiPuedeBloquearA(cazador)}, {cazador})
	} 
}