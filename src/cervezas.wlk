class MarcaDeCerveza {
	
	const contenidoDeLupulo
	const paisDeOrigen
	const precioPorLitro
	
	method porcentajeDeAlcohol()
	method graduacion() { return self.porcentajeDeAlcohol() / 100 }
	method contenidoDeLupulo() { return contenidoDeLupulo }
	method paisDeOrigen() { return paisDeOrigen }
	method precioPorLitro() { return precioPorLitro }
	
}

class Rubia inherits MarcaDeCerveza {
	
	const porcentajeDeAlcohol
	
	override method porcentajeDeAlcohol() { return porcentajeDeAlcohol }
	
}

class Negra inherits MarcaDeCerveza {
	
	var graduacionReglamentaria = 16
	
	override method porcentajeDeAlcohol() { return graduacionReglamentaria.min(contenidoDeLupulo * 2) }
	method graduacionReglamentaria(nueva) { graduacionReglamentaria = nueva }
	
}

class Roja inherits Negra {
	
	override method porcentajeDeAlcohol() { return super() * 1.25 }
	
}

class Jarra {
	
	const capacidad
	const marca
	const seSirvioEn
	const precioConRecargo
	
	method capacidad() { return capacidad }
	method seSirvioEn() { return seSirvioEn }
	method lupuloPorLitro() { return marca.contenidoDeLupulo() / capacidad }
	method graduacion() { return marca.graduacion() }
	method paisDeOrigen() { return marca.paisDeOrigen() }
	method contenidoDeAlcohol() { return capacidad * marca.graduacion() }
	method esGrande() { return capacidad >= 1 }
	method precioDeVenta() { return marca.precioPorLitro() * capacidad }
	
}