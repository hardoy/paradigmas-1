import Jugador.*
import Pelotas.*

// (en construccion)
class Cazador inherits Jugador {
	var punteria
	constructor(_skills,_peso,_fuerza,_escoba,_punteria) = super(_skills,_peso,_fuerza,_escoba) {
		punteria = _punteria
	}
	method punteria() =				return punteria
	override method habilidad() =			return punteria * fuerza + super()
	override method puedeTenerLaQuaffle()= 		return true
	override method ganaLaQuaffle()			{ quaffle.laGana(self) }
	override method bludgereado(rival){
		super(rival)
		if(self.tieneLaQuaffle()){
			self.pierdeLaQuaffle()
			rival.ganaLaQuaffle()
		}
	}
	override method hacerJugada(rival){
		var alguienQuePudoBloquar_OElMismo = rival.tratarDeBloquearA(self)
		if(alguienQuePudoBloquar_OElMismo === self){
			self.equipo().ganarPuntos(10)
			skills += 5
		}
		else{
			alguienQuePudoBloquar_OElMismo.skillsPorBloquear()
			skills -= 3
		}
		self.pierdeLaQuaffle()
		rival.ganaLaQuaffle()
	}// como hay un factor suerte puse una var, porque sino se pierde el valor en otra consulta :S... creo
	// no puse una condicion para que no permita hacer jugaga sino tiene la quaffle
	
}