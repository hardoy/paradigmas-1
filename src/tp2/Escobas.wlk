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