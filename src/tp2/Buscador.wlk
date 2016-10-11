import Jugador.*
import Actividades.*

// (en construccion)
class Buscador inherits Jugador {
	var vision
	var actividad = busqueda 
	var turnosBuscando = 1 
	var metrosParaAtrapar = 5000
	var aturdido = false
	var encontroSnitch = false

	constructor(_skills, _peso, _fuerza, _escoba, _vision) = super ( _skills ,	_peso , _fuerza , _escoba ) {
		vision = _vision
	}

	method vision() = vision
	
	method aturdido() = aturdido
	method aturdir() { aturdido = true }
	method recuperarse() { aturdido = false }
	
	override method habilidad() = self.reflejos() * vision + super()
	override method puedeBloquearA(jugador) = false
	method cambiarDistancia(nuevaDistancia) { metrosParaAtrapar = nuevaDistancia }
	override method esBlancoUtil() = super() || (self.encontroSnitch() && metrosParaAtrapar < 1000)

	override method hacerJugada() {
		if (self.aturdido()) {
			self.recuperarse()
		} else {
			actividad.realizarla(self) 
		}
	}
	
	method encontroSnitch() = encontroSnitch
	method encontroSnitch(encontrada) { encontroSnitch = encontrada }

	method actividad() = actividad
	method turnosBuscando() = turnosBuscando
	method cambiarActividad(nuevaActividad) { actividad = nuevaActividad }
	method metrosParaAtraparSnitch() = metrosParaAtrapar
	
	method reducirMetrosParaAtraparSnitch() { 
		metrosParaAtrapar -= self.velocidad() * 2 
	}
	
	method incrementarTurno() { turnosBuscando += 1 }
	
	method atrapaLaSnitch() {
		equipo.ganarPuntos(150)
		self.aumentarSkills(30)
	}
	
	method reiniciarBusqueda() {
		actividad = busqueda 
		turnosBuscando = 0 
		metrosParaAtrapar = 5000
	}
	
	override method bludgereado() {
		super() 
		if (self.esGroso()) {
			self.aturdir()			
		} else {
			self.reiniciarBusqueda()
		}
	}
	
	override method puedeTenerLaQuaffle() = false
}