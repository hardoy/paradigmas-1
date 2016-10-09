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