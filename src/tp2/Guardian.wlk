import Jugador.*

class Guardian inherits Jugador {
	constructor(_skills,_peso,_fuerza,_escoba) = super(_skills,_peso,_fuerza,_escoba)
	override method habilidad() = self.reflejos() + fuerza + super()
	override method reflejos() = 20 + self.velocidad() * skills / 100
	override method puedeTenerLaQuaffle() = true
	
	override method skillsQueGanaPorBloquear() = 10
	
	override method ganaLaQuaffle(){
		var jugadoresMenosSelf = equipo.jugadoresQuePuedenTenerQuaffle().filter({unJugador => unJugador != self})
		jugadoresMenosSelf.max({unJugador => unJugador.habilidad()}).ganaLaQuaffle()
	}
	
	override method hacerJugada() {}
	
	override method esBlancoUtil() {
		return super() || !equipo.tieneLaQuaffle()	
	}
}