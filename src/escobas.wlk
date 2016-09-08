
class Nimbus{
    var anioFabricacion
    var salud

    constructor(_anio, _salud){
        anioFabricacion = _anio
        salud = _salud
    }
    
    method velocidad() = (80 - (new Date().year() - anioFabricacion)) * salud
    method recibeGolpe(){
        salud -= 10
    }
}

object saetaDeFuego {
    method velocidad() = 100
    method recibeGolpe() = null
}