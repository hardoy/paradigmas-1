import Jugador.*
import Pelotas.*

// (en construccion)

class Cazador inherits Jugador {
	var punteria

	constructor(_skills, _peso, _fuerza, _escoba, _punteria) = super ( _skills , _peso , _fuerza , _escoba) {
		punteria = _punteria
	}
	method punteria() = return punteria
	override method habilidad() = return punteria * fuerza + super()
	override method puedeTenerLaQuaffle() = return true

	method ganaLaQuaffle() {
		quaffle.laTiene(self)
	}

	method pierdeLaQuaffle() {
		if (self.tieneLaQuaffle()) {
			equipo.pierdeLaQuaffle() 
		}
	}

	override method bludgereado() {
		super() 
		self.pierdeLaQuaffle()
	}

	override method hacerJugada() {
		try {
			var bloqueador = self.equipoRival().encontrarBloqueadorDe(self)
			bloqueador.ganarSkillsPorBloquear()
			self.disminuirSkills(3)
		} catch e:Exception {
			self.equipo().ganarPuntos(10)
			skills += 5
		} 
		self.pierdeLaQuaffle()
	} // como hay un factor suerte puse una var, porque sino se pierde el valor en otra consulta :S... creo
	// no puse una condicion para que no permita hacer jugaga sino tiene la quaffle

}