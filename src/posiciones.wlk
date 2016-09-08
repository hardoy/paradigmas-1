
object cazador {
    
    method habilidad(jugador){
        return jugador.velocidad() + jugador.skills() + jugador.punteria() * jugador.fuerza()
    }
}

object guardian {
    
    method habilidad(jugador){
        return jugador.velocidad() + jugador.skills() + jugador.reflejos() + jugador.fuerza()
    }
}

object golpeador {
    method habilidad(jugador){
        return jugador.velocidad() + jugador.skills() + jugador.punteria() + jugador.fuerza()
    }
}


object buscador {
    method habilidad(jugador){
        return jugador.velocidad() + jugador.skills() + jugador.reflejos() + jugador.vision()
    }
}
