import Jugador.*
import Suerte.*

class Golpeador inherits Jugador {
	var punteria
	constructor(_skills,_peso,_fuerza,_escoba,_punteria) = super(_skills,_peso,_fuerza,_escoba) {
		punteria = _punteria
	}
	method punteria() = punteria
	override method habilidad() = punteria + fuerza + super()
	
	override method hacerJugada() {
		var blancoUtil = self.elegirBlancoUtil()
		if(blancoUtil.reflejos() < self.punteria() || suerte.tieneSuerte()){
			self.aumentarSkills(5)
			blancoUtil.bludgereado()
		}
	}
	method elegirBlancoUtil(){
		return self.equipoRival().blancosUtiles().max({unJugador => unJugador.habilidad()})
	}
	
	override method puedeTenerLaQuaffle() = false
}