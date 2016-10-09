class Jugador {
	var skills
	var peso
	var fuerza
	var escoba
	var equipo
	constructor(_skills,_peso,_fuerza,_escoba) {
		skills 	= 	_skills
		peso 	=	_peso
		fuerza 	= 	_fuerza
		escoba 	= 	_escoba
	}
	
	method skills() =			return skills
	method modificarSkills(num)		{ skills =+ num }
	method peso() =				return peso
	method fuerza() = 			return fuerza
	method escoba() = 			return escoba
	method velocidadDeEscoba() = 		return escoba.velocidadEscoba()
	method saludDeEscoba() = 		return escoba.saludEscoba()
	method tieneLaQuaffle() =		return quaffle.laTiene() === self
	method equipo() =			return equipo
	method asignarEquipo(suEquipo)		{ equipo = suEquipo }
	method skillsPorBloquear()		{ skills += 3 }
	method puedeTenerLaQuaffle() = 		return false
	method esBlancoUtil(equipoRival)=	return self.esJugadorEstrella(equipoRival) || self.tieneLaQuaffle()
	method verSiPuedeBloquearA(cazador) = 	return self.lePasaElTrapoA(cazador) || suerte.tieneSuerte()
	method reflejos() =			return self.velocidad() * skills / 100
	method manejoDeEscoba() =		return skills / peso
	method velocidad() =			return escoba.velocidadEscoba() * self.manejoDeEscoba()
	method habilidad() =			return self.velocidad() + skills
	method lePasaElTrapoA(otroJug)=		return self.habilidad() >= 2.0 * otroJug.habilidad()
	method ganaLaQuaffle(){}
	method pierdeLaQuaffle(){}
	method hacerJugada(rival){}
	
	method esGroso() {
		return self.habilidad() > equipo.promedioHabilidad() 
		&& self.velocidad() >= mercadoDeEscobas.velocidadMinimaParaSerGroso()
	}
	method esJugadorEstrella(equipoRival){
		return equipoRival.jugadores().all({jugadorRival => self.lePasaElTrapoA(jugadorRival)})
	}

	method bludgereado(rival) {
		skills -= 2
		escoba.recibeGolpe()
	}
}



// Cazador (en construccion)
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

// Golpeador
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

// Guardian (en construccion)
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

// Buscador (en construccion)
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

object busqueda{
	method realizarla(unJugador){
		unJugador.incrementarTurno()
		unJugador.turnosBuscando().times{if(suerte.tieneSuerte()){ unJugador.cambiarActividad(persecucion) }}
	}
}

object persecucion{
	method realizarla(unJugador){
		unJugador.reducirMetrosParaAtraparSnitch()
		if(unJugador.metrosParaAtraparSnitch() <= 0) { 
			unJugador.atrapaLaSnitch()
		}
	}
}

object aturdido{
	method realizarla(unJugador)		{ unJugador.recuperarse() }
}

object quaffle{
	var duenio
	method laTiene()=			return duenio
	method laGana(unJugador)		{ duenio = unJugador }
}

class Equipo {
	var jugadores
	var puntos = 0
	constructor(_jugadores) {
		jugadores = _jugadores
		jugadores.map({ unJugador => unJugador.asignarEquipo(self) })
	}
	method jugadores() = 		return jugadores
	method puntos() = 		return puntos
	method ganarPuntos(nuevosPuntos){ puntos += nuevosPuntos}
	method promedioHabilidad() = 	return jugadores.sum({unJugador => unJugador.habilidad()}) / jugadores.size() 
	method jugadoresGrosos() = 	return jugadores.filter({unJugador => unJugador.esGroso()})
	method jugadorUtiles(rival) = 	return jugadores.filter({unJugador => unJugador.esBlancoUtil(rival)})
	method tieneLaQuaffle() = 	return jugadores.contains(quaffle.laTiene())
	method jugadoresQuePuedenTenerQuaffle() = return jugadores.filter({unJugador => unJugador.puedeTenerLaQuaffle()})
	method jugadoresOrdenadosPorVelocidad(){
		return jugadores.sortedBy({unJugadorRapido, otroJugadorLento  => unJugadorRapido.velocidad() > otroJugadorLento.velocidad()})
	}
	method tieneJugadorEstrellaParaJugarContra(otroEquipo) {
		return jugadores.any({unJugador => unJugador.esJugadorEstrella(otroEquipo)})
	}
	method ganaLaQuaffle(){
		if(!(self.tieneLaQuaffle())){
			self.jugadoresQuePuedenTenerQuaffle().max({ unJugador => unJugador.velocidad()}).ganaLaQuaffle()
			return true
		}
		else{return false}
	}
	method pierdeLaQuaffleAnte(rival){
		if(self.tieneLaQuaffle()){
			quaffle.laTiene().hacerJugada(rival)
			return true
		}
		else{return false}
	}
	method tratarDeBloquearA(cazador){
		return self.jugadoresOrdenadosPorVelocidad().findOrElse({unJugador => unJugador.verSiPuedeBloquearA(cazador)}, {cazador})
	} 
}

// escobas
object mercadoDeEscobas {
	var velocidadMinimaParaSerGroso
	method velocidadMinimaParaSerGroso() {
		return velocidadMinimaParaSerGroso
	}
	method velocidadMinimaParaSerGroso(nuevaVelocidad) {
		velocidadMinimaParaSerGroso = nuevaVelocidad
	}
}
class Nimbus {
	var modelo
	var salud
	constructor(_modelo,_salud) {
		modelo = _modelo
		salud = _salud
	}
	method velocidadEscoba() {
		return (80 - (new Date().year() - modelo)) * salud / 100
	}
	method saludEscoba() {
		return salud
	}
	method recibeGolpe() {
		salud -= 10
	}
}
object saetaDeFuego {
	method velocidadEscoba() {
		return 100
	}
	method saludEscoba() {
		return 100
	}
	method recibeGolpe() {
	}
}

// suerte
object suerte {
    var tipoDeSuerte = suerteReal
    method tipoDeSuerte(_tipoDeSuerte){
   	 tipoDeSuerte = _tipoDeSuerte
    }
    method tieneSuerte(){
   	 return tipoDeSuerte.tieneSuerte()
    }
}

object suerteReal{
    method tieneSuerte() = (1..5).anyOne() == 1
}

object malaSuerte{
    method tieneSuerte() = false
}

object buenaSuerte{
    method tieneSuerte() = true
}
