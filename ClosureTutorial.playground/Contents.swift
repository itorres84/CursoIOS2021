import UIKit

//Son funciones anónimas  las cuales tienen la capacidad de almacenarse en una variable

/*
    
 Sintaxis de los clusures en SWIFT
 
    parametros      valor de retorno
 { (parameters) -> return type in
    statements
    contenido
 }
 
*/

func saludar(name: String, lastName: String) {
    print("Hola, \(name) \(lastName)")
}

saludar(name: "Israel", lastName: "Torres")

let closureSaludar = { (name: String, lastName: String) -> Void in
                        print("Hola desde un closure: \(name) \(lastName)")
                     }

closureSaludar("Israel", "Torres")


func getDate() -> String {
    let date = Date()
    return date.description
}

let closureGetDate = { () -> String in
    let date = Date()
    return date.description
}

let fecha = getDate()
print("La fecha de hoy es: \(fecha)")
print("Fecha closure: \(closureGetDate())")


func add42(number: Int) -> Int {
    return number + 42
}

let closureAdd50 = { (number: Int) -> Int in
    return number + 50
}

func add10(number: Int) -> Int {
    return number + 10
}

//Closure como parametro de funcion
func apply(_ closure: (Int) -> Int, whit number: Int) -> Int {
    return closure(number)
}

//1
let result1 = apply(add42, whit: 8)
let result2 = apply(add10, whit: 8)

print("Resultado 1: \(result1)")
print("Resultado 2: \(result2)")

let resultado3 = apply(closureAdd50, whit: 20)
print("Resultado 3: \(resultado3)")

//closure como valor de retorno

func adder(number: Int) -> (Int) -> Int {
    
    func add(x: Int) -> Int {
        return x +  number
    }
    
    return add
}

let add42Dos = adder(number: 42)
let add10Dos = adder(number: 10)

print(type(of: add42Dos))
print(type(of: add10Dos))

print(add42Dos(8))
print(add10Dos(8))

print("Sorted:::::::::::::::::::::::::::::::::::::::::::::::::::::::")

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

print(names)

let namesSorted = names.sorted { name1, name2 in
    return name1 < name2
}

print("middle sorted: \(namesSorted)")

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

let namesBackwardSorted = names.sorted(by: backward)

print("Function sorted: \(namesBackwardSorted)")

let compactSorted = names.sorted(by: {  s1, s2 in s1 < s2 })

print("compact sorted: \(compactSorted)")

let moreCompactSorted = names.sorted(by: { $0 < $1 })

print("More compact sorted: \(moreCompactSorted)")


let numbers = [16, 58, 510]

print(numbers)

let stringsNumbers = numbers.map { number in
    return "Este es el numero: \(number)"
}

print(stringsNumbers)


