import UIKit
import Darwin

var greeting = "Hello, playground"


//Declarar un objeto o declarar una clase

class Automovil {

    //Propiedades
    let volante: Bool = true
    let palanca: Bool = true
    
    var puertas: Int
    var motor: String
    var color: UIColor
    var marca: String
    
    //inicializadores
    init (puertas: Int, motor: String, color: UIColor, marca: String) {
        
        self.puertas = puertas
        self.motor = motor
        self.color = color
        self.marca = marca
    }
    
    //métodos o funciones
    func acelerar(velocidad: Double) {
        print("el automovil está acelerando a: \(velocidad)")
    }
    
    func frenar() {
        print("el automovil se detuvo")
    }
}

let jetta: Automovil = Automovil(puertas: 4, motor: "2.0" , color: UIColor.red, marca: "vw")

print(jetta)
dump(jetta)

jetta.acelerar(velocidad: 50.0)
jetta.frenar()

let audi3: Automovil = Automovil(puertas: 2, motor:"tsi", color: UIColor.yellow, marca: "audi")

audi3.acelerar(velocidad: 0)

let strNombre = String(describing: "Hola")
print(strNombre.count)
print(<#T##items: Any...##Any#>)
let strApellido = Mundo

struct person{
    let name: String
    let lastName: String
    let gender: String
    let age: Int
    
    func obtenEdad() -> String{
        return "la edad es de: \(age)"
    
    }
}
