import UIKit

var greeting = "Hello, playground"


//Declarar on objeto o declarar una clase

class Automovil {
    
    //Propiedades
    let palanca: Bool = true
    let volante: Bool = true
    
    var puertas: Int
    var motor: String
    var color: UIColor
    var marca: String
    
    //Inicializadores
    init(puertas: Int,
         motor: String,
         color: UIColor,
         marca: String) {
        
        self.puertas = puertas
        self.motor = motor
        self.color = color
        self.marca = marca
    }
    
    //metodos o funciones
    func acelerar(velocidad: Double) {
        
        if velocidad == 0.0 {
            frenar()
        } else {
            print("El automovil esta acelerando a: \(velocidad) KM por hora")
        }
    }
    
    func frenar() {
        print("El automovil se detuvo")
    }

}

let jetta: Automovil = Automovil(puertas: 4, motor: "2.0", color: UIColor.black, marca: "VW")

print(jetta)
dump(jetta)

jetta.acelerar(velocidad: 50.0)
jetta.frenar()

let audi3: Automovil = Automovil(puertas: 2, motor: "TSI", color: UIColor.red, marca: "Audi")
dump(audi3)

audi3.acelerar(velocidad: 0)

let strNombre = String(describing: "Hola")

print(strNombre.count)

let strApellido = "Mundo"


struct Person {
    
    let name: String
    let lastName: String
    let gender: String
    let age: Int
    
    func obtenEdad() -> String {
        return "la edad es de: \(age)"
    }
    
}

let miPersona: Person = Person(name: "Israel", lastName: "Torres", gender: "M", age: 25)
dump(miPersona)

let mensajeEdad = miPersona.obtenEdad()

print(mensajeEdad)
