import UIKit

var greeting = "Hello, playground"

//Clase
class Automovil {
//Propiedades
    let volate: Bool = true
    let palanca: Bool = true
    
    var puertas: Int
    var motor: String
    var color: UIColor
    var marca: String
    var capacidad: Int
//Inicalizador
    init (puertas: Int,
          motor: String,
          color: UIColor,
          marca: String,
          capacidad: Int) {
        
        self.puertas = puertas
        self.motor = motor
        self.color = color
        self.marca = marca
        self.capacidad = capacidad
    }
//Metodos y Funciones
    func acelerar(velocidad: Double){
        
        if velocidad == 0.0 {
           frenar()
        } else {
            print("El vehiculo esta acelerando a \(velocidad) Km por hora")
        }
    }
    
    func frenar() {
            print("El carro se detuvo")
        }
}

let Gol: Automovil = Automovil(puertas: 5, motor: "2.4", color: UIColor.white, marca: "Volkswagen", capacidad: 5)

dump(Gol)

Gol.acelerar(velocidad: 65.0)
Gol.frenar()


//Estructura
struct Person {
    //Propiedades
    var Name: String
    var Lastname: String
    var Gender: String
    var Age: Int
    
    func ObtenEdad() -> String {
        return "la edad es \(Age)"
    }
}

let miPersona: Person = Person(Name: "Itzel", Lastname: "Lugo", Gender: "F", Age: 23)

print(miPersona)

let mensajeEdad = miPersona.ObtenEdad()

print(mensajeEdad)
