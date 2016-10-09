import Jugador.*
import Actividades.*

// (en construccion)
class Buscador inherits Jugador {
	var vision
	var actividad = busqueda
	var tunosBuscando = 1
	var metrosParaAtrapar = 5000
	var estadoAnteriorASerGolpeado
	
	constructor(_skills,_peso,_fuerza,_escoba,_vision) = super(_skills,_peso,_fuerza,_escoba) {
		vision = _vision
	}

	method actividad()= 				return actividad
	method turnosBuscando() =			return tunosBuscando
	method cambiarActividad(nuevaActividad)		{ actividad = nuevaActividad }
	method metrosParaAtraparSnitch() = 		return metrosParaAtrapar
	method reducirMetrosParaAtraparSnitch()		{ metrosParaAtrapar -= self.velocidad() * 2 }
	method incrementarTurno()			{tunosBuscando += 1}
	method recuperarse()				{actividad = estadoAnteriorASerGolpeado}
	method atrapaLaSnitch(){
		equipo.ganarPuntos(150)
		skills += 30
		}
	override method habilidad() =			return self.reflejos() * vision + super()
	override method verSiPuedeBloquearA(cazador) = 	return false
	method reiniciarBusqueda(){
		actividad = busqueda
		tunosBuscando = 0
		metrosParaAtrapar = 5000
	}
	override method bludgereado(rival){
		super(rival)
		if(self.esGroso()){
			if(actividad != aturdido){
				estadoAnteriorASerGolpeado = actividad
				actividad = aturdido
				}
		}
		else{self.reiniciarBusqueda()}
	}
	override method hacerJugada(rival) { actividad.realizarla(self) }
	override method esBlancoUtil(equipoRival){
		return super(equipoRival) || (actividad === persecucion && metrosParaAtrapar < 1000)
	}
	//Metodos para hacer test
	method 	cambiarDistancia(nuevaDistancia){ metrosParaAtrapar = nuevaDistancia }

}