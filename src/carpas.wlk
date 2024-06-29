import cervezas.*
import personas.*

class Carpa {
	
	const limiteDeGente
	const tieneBanda
	const marcaDeCerveza
	var metodoDeRecargo
	
	const personasDentro = []
	
	method tieneBanda() { return tieneBanda }
	method marcaDeCerveza() { return marcaDeCerveza }
	method cantidadDePersonasDentro() { return personasDentro.size() }
	method dejaIngresarA(persona) { return personasDentro.size() < limiteDeGente and not persona.estaEbria() }
	method ingresar(persona) { 
		if(self.dejaIngresarA(persona)) {
			personasDentro.add(persona)
		}
		else {
			self.error("La persona no puede ingresar a esta carpa.")
		}
	}
	method recibirCervezaA(persona, capacidad) {
		if(personasDentro.contains(persona)) {
			persona.recibirCerveza(new Jarra(capacidad = capacidad, marca = marcaDeCerveza, seSirvioEn = self, precioConRecargo = self.aplicarRecargo()))
		}
		else {
			self.error("La persona no se encuentra dentro de la carpa.")
		}
	}
	method cantidadDeEbriosEmpedernidos() { return personasDentro.count({ persona => persona.esEbrioEmpedernido() }) }
	method esHomogenea() {
		const pais = personasDentro.first().paisDeNacimiento()
		return personasDentro.all({ persona => persona.paisDeNacimiento() == pais })
	}
	method noSeLesSirvioCervezaA() { return personasDentro.filter({ persona => not persona.recibioCervezaDe(self) }) }
	method metodoDeRecargo(nuevo) { metodoDeRecargo = nuevo }
	method hayBastanteGente() { return self.cantidadDePersonasDentro() >= limiteDeGente / 2 }
	method cantidadDeEbrios() { return personasDentro.count({ persona => persona.estaEbria() }) }
	method hayMuchaGenteEbria() { return self.cantidadDeEbrios() >= self.cantidadDePersonasDentro() * 0.75 }
	method aplicarRecargo() {
		if(not metodoDeRecargo.equals(recargoFijo)) {
			const condicion = if(metodoDeRecargo.equals(recargoPorCantidad)) self.hayBastanteGente() else self.hayMuchaGenteEbria()
			return marcaDeCerveza.precioDeVenta() * metodoDeRecargo.recargo(condicion)
		}
		else {
			return marcaDeCerveza.precioDeVenta() * metodoDeRecargo.recargo()
		}
	}
	
}

object recargoFijo {
	
	method recargo() { return 0.3 }
	
}

object recargoPorCantidad {
	
	method recargo(condicion) { return if(condicion) 0.4 else 0.25 }
	
}

object recargoPorEbriedad {
	
	method recargo(condicion) { return if(condicion) 0.5 else 0.20 }
	
}