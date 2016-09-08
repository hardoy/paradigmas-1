class Jugador{
    var equipo
    var posicion
    var skills
    var peso
    var fuerza
    var escoba
    var otros
   
   constructor (_equipo, _posicion, _skills, _peso, _fuerza, _escoba, _otros) {
        skills = _skills
        peso = _peso
        posicion = _posicion
        escoba = _escoba
    }
    
    method equipo() = equipo
    method skills() = skills
    method peso() = peso
    method posicion() = posicion
    method escoba() = escoba
   
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




