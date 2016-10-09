import Suerte.*

object busqueda {
	method realizarla(unJugador) {
		unJugador.incrementarTurno()
		unJugador.turnosBuscando().times{ if (suerte.tieneSuerte()) {
			unJugador.cambiarActividad(persecucion) } }
	}
}

object persecucion {
	method realizarla(unJugador) {
		unJugador.reducirMetrosParaAtraparSnitch()
		if (unJugador.metrosParaAtraparSnitch() <= 0) {
			unJugador.atrapaLaSnitch()
		}
	}
}

object aturdido {
	method realizarla(unJugador) { unJugador.recuperarse() }
}
