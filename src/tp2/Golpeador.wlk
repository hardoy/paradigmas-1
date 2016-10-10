import Jugador.*
import Suerte.*

class Golpeador inherits Jugador {
	var punteria
	constructor(_skills,_peso,_fuerza,_escoba,_punteria) = super(_skills,_peso,_fuerza,_escoba) {
		punteria = _punteria
	}
	method punteria() =				return punteria
	override method habilidad() =			return punteria + fuerza + super()
	override method hacerJugada(){
		if( self.elegirBlancoUtil().reflejos() < self.punteria() || suerte.tieneSuerte()){
			skills += 5
			self.elegirBlancoUtil().bludgereado()
		}
	}
	method elegirBlancoUtil(){
		return self.equipoRival().jugadorUtiles().max({unJugador => unJugador.habilidad()})
	}
	
	override method puedeTenerLaQuaffle() {
		return false
	}
}