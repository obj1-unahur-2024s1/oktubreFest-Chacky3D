class Persona {
	
	const peso
	const jarrasCompradas = []
	const leGustaLaMusicaTradicional
	const nivelDeAguante
	
	method jarrasCompradas() { return jarrasCompradas }
	method totalDeAlcoholIngerido() { return jarrasCompradas.sum({ jarra => jarra.contenidoDeAlcohol() }) }
	method estaEbria() { return self.totalDeAlcoholIngerido() * peso > nivelDeAguante }
	method leGustaLaMusicaTradicional() { return leGustaLaMusicaTradicional }
	method leGusta(cerveza)
	method quiereEntrarA(carpa) { return self.leGusta(carpa.marcaDeCerveza()) and leGustaLaMusicaTradicional == carpa.tieneBanda() }
	method puedeEntrarA(carpa) { return self.quiereEntrarA(carpa) and carpa.dejaIngresarA(self) }
	method entrarA(carpa) {
		if(self.puedeEntrarA(carpa)) {
			carpa.ingresar(self)
		}
		else {
			self.error("La persona no cumple las condiciones para ingresar a la carpa.")
		}
	}
	method recibirCerveza(jarra) { 
		if(jarra.className().equals("cervezas.jarra")) {
			jarrasCompradas.add(jarra)			
		}
		else {
			self.error("Las personas solo puede comprar jarras de cerveza.")
		}
	}
	method esEbrioEmpedernido() { return jarrasCompradas.all({ jarra => jarra.esGrande() }) }
	method paisDeNacimiento()
	method esPatriota() { return jarrasCompradas.all({ jarra => jarra.paisDeOrigen() == self.paisDeNacimiento() }) }
	method coincidenciasEnJarras(persona) { return jarrasCompradas.asSet().intersection(persona.jarrasCompradas().asSet()) }
	method diferenciasEnJarras(persona) { return jarrasCompradas.asSet().difference(persona.jarrasCompradas().asSet()) }
	method esCompatibleCon(persona) { return self.coincidenciasEnJarras(persona) > self.diferenciasEnJarras(persona) }
	method leSirvieronCervezasEn() { return jarrasCompradas.map({ jarra => jarra.seSirvioEn() }).asSet() }
	method recibioCervezaDe(carpa) { return self.leSirvieronCervezasEn().contains(carpa) }
	method tienenLaMismaCapacidad() {
		const jarraCapacidad = jarrasCompradas.first().capacidad()
		return jarrasCompradas.all({ jarra => jarra.capacidad() == jarraCapacidad })
	}
	method tienenMayorCapacidad() {
		const index = (0..jarrasCompradas.size() - 1)
		return index.all({ i => jarrasCompradas.get(i).capacidad() < jarrasCompradas.get(i + 1).capacidad() })
	}
	method estaEntradoEnElVicio() { return self.tienenLaMismaCapacidad() or self.tienenMayorCapacidad() }
	method gastoTotalEnCerveza() { return jarrasCompradas.sum({ jarra => jarra.precioDeVenta() }) }
	method jarraMasCaraCompradas() { return jarrasCompradas.max({ jarra => jarra.precioDeVenta() }) }
}

class Belga inherits Persona {
	
	override method leGusta(cerveza) { return cerveza.lupuloPorLitro() > 4 }
	override method paisDeNacimiento() { return "Belgica" }
	
}

class Checo inherits Persona {
	
	override method leGusta(cerveza) { return cerveza.graduacion() > 0.08 }
	override method paisDeNacimiento() { return "Republica Checa" }
	
}

class Aleman inherits Persona {
	
	override method leGusta(cerveza) { return true }
	override method quiereEntrarA(carpa) { return super(carpa) and carpa.cantidadDePersonasDentro().even() }
	override method paisDeNacimiento() { return "Alemania" }
	
}