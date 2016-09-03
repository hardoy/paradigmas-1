class Jugador{
    var skills
    var peso
    var posicion
    var escoba
    var posicion = guardian
   
    method nivelManejoEscoba() = skills / peso

    method velocidad() = escoba.velocidad() * self.nivelManejoEscoba()

    method habilidad() = posicion.hablidad(self)

    method reflejos(){
        if (posicion == guardian)
            return self.velocidad() * skills / 100 + 20
        else
            return self.velocidad() * skills / 100

        // Esta materia me generó fobia a los IF, así que fijense ustedes
    }
    
    method lePasaElTrapoA(otroJugador) = self.habilidad() * 2 >= otroJugador.habilidad()
    
	method esBludgereado(){
		skills -= 2
		escoba.recibeGolpe()
	}
	
}
