
object quaffle {
	var duenio
	
	method duenio() = return duenio

	method duenio(unJugador) { 
		duenio = unJugador
	}
	
	method tieneDuenio() = self.duenio() != null
}
