import Jugador.*
// (en construccion)
class Guardian inherits Jugador {
	constructor(_skills,_peso,_fuerza,_escoba) = 	super(_skills,_peso,_fuerza,_escoba)
	override method habilidad() =			return self.reflejos() + fuerza + super()
	override method reflejos() =			return 20 + self.velocidad() * skills / 100
	override method puedeTenerLaQuaffle()= 		return true
	override method skillsPorBloquear()		{ skills += 10 }
	override method ganaLaQuaffle(){
		equipo.jugadoresQuePuedenTenerQuaffle().filter({unJugador => unJugador != self}).max({unJugador => unJugador.habilidad()}).ganaLaQuaffle()
	} // no se usa remove ya que retorna null y no la lista sin el mismo
}