import UIKit

var greeting = "Hello, playground"

//Arrays
//Sirven para agrupar secuencias de datos

let numbers: [Int] = [1,2,3,4,5,6,7,8,9,]
let personas: [String] = ["Isarel", "Arturo", "Esmeralda"]
let mutante: [Any] = [1,"2", true, 2.0]


print(numbers)

print("el primer valor de mi secuencia es: \(numbers[0])")

//tamaño del arreglo
print("el tamaño del arreglo es:\(numbers.count)")

       
//son para usarlas con propiedades que pueden o no ser inicializadas
var spoiler: String? = nil

if let valorInicial = numbers.first{

print("el primer valor de mi secuencia es: \(valorInicial)")
}

if let valorFinal = numbers.last{
    print("el último valor de mi secuencia es: \(valorFinal)")
}

//Loops o ciclos

//FOOR

for x in numbers {

print("valor: \(x)")

}

for (index, element) in numbers.enumerated(){

print("el valor del index: \(index) es: \(element)")

}

//WHILE
var incremental = 0

repeat {
    
    print (incremental)
    incremental = incremental + 1
    
}while incremental <= 100
    
//FOR EACH
numbers.forEach {
    print("\($0) valor")
}







//Diccionarios
print ("DICCIONARIOS")

struct Persona {
let nombre: String
let apellido: String
}

let persona1 = Persona(nombre: "Israel", apellido: "Torres")

print(persona1.nombre)
print(persona1.apellido)

    let basicDictionary:  [String: String] = ["nombre": "Israel", "Apellido": "Torres"]

let firstValue = basicDictionary.first
    
print("Clave: \(firstValue?.key) valor: \(firstValue?.value)")
    
if let nombre = basicDictionary["nombre"]{
    print("Nombre: \(nombre)")
}
    
          let dictionaryDos: [Int: String] = [1: "Azul", 2:"Rojo"]
          
          print (dictionaryDos[1])
          
          for valor in basicDictionary {
        print (valor)
    }
