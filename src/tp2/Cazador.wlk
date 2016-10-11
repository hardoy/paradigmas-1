import Jugador.*
import Pelotas.*
import Excepciones.*

class Cazador inherits Jugador {
	var punteria

	constructor(_skills, _peso, _fuerza, _escoba, _punteria) = super ( _skills , _peso , _fuerza , _escoba) {
		punteria = _punteria
	}
	
	method punteria() = punteria
	override method habilidad() = punteria * fuerza + super()
	override method puedeTenerLaQuaffle() = true

	override method ganaLaQuaffle() {
		quaffle.duenio(self)
	}

	override method pierdeLaQuaffle() {
		if (self.tieneLaQuaffle()) {
			equipo.pierdeLaQuaffle() 
		} else {
			throw new NoPuedePerderLaQuaffle()
		}
	}

	override method bludgereado() {
		super()
		if (self.tieneLaQuaffle()) { self.pierdeLaQuaffle() }
	}
	
	override method esBlancoUtil() {
		return super() || self.tieneLaQuaffle()
	}

	override method hacerJugada() {
		if (self.tieneLaQuaffle()) {
			try {
				var bloqueador = self.equipoRival().bloquearA(self)
				bloqueador.ganarSkillsPorBloquear()
				self.disminuirSkills(3)
			} catch npb:NoPudoBloquear {
				self.equipo().ganarPuntos(10)
				self.aumentarSkills(5)
			}
			self.pierdeLaQuaffle()
		} 
	}
}