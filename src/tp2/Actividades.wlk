import Suerte.*

object busqueda {
	method realizarla(unJugador) {
		unJugador.incrementarTurno()
		var checkearSuerte = unJugador.turnosBuscando() + unJugador.vision()
		checkearSuerte.times { 
			if (suerte.tieneSuerte()) {
				unJugador.encontroSnitch(true)
				unJugador.cambiarActividad(persecucion)
			} 
		}
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
