import Jugador.*
import Suerte.*

class Golpeador inherits Jugador {
	var punteria
	constructor(_skills,_peso,_fuerza,_escoba,_punteria) = super(_skills,_peso,_fuerza,_escoba) {
		punteria = _punteria
	}
	method punteria() =				return punteria
	override method habilidad() =			return punteria + fuerza + super()
	override method hacerJugada(rival){
		if( self.elegirBlancoUtil(rival).reflejos() < self.punteria() || suerte.tieneSuerte()){
			skills += 5
			self.elegirBlancoUtil(rival).bludgereado(equipo)
		}
	}
	method elegirBlancoUtil(rival){
		return rival.jugadorUtiles(equipo).max({unJugador => unJugador.habilidad()})
	}
}