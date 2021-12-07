import UIKit

//Sintaxis basica de protocolo

// Definicion
// Plantilla o interfaz para onbligar a los tipos que lo conforman a cumplir ciertos requerimientos
// ¿ Que define ?
// Metodos, propiedades, inicializadores

protocol MyProtocol {
    //definicion de mi protocolo
    var mustBeSettableAndGetter: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
    
    func saludar()
    
    init(param1: Int, param2: Int)
    
}

protocol AnotherProtocol {
    //definicion de mi protocolo
}

struct SomeStructure: MyProtocol, AnotherProtocol {

    var doesNotNeedToBeSettable: Int
    var mustBeSettableAndGetter: Int

    func saludar() {
        print("Saludar de mano")
    }
    
    init(param1: Int, param2: Int) {
        doesNotNeedToBeSettable = param1
        mustBeSettableAndGetter = param2
    }
    
}

class SomeClass: MyProtocol {

    var mustBeSettableAndGetter: Int = 0
    var doesNotNeedToBeSettable: Int = 0

    func saludar() {
        print("Saludar de beso")
    }
    
    required init(param1: Int, param2: Int) {
        mustBeSettableAndGetter = param1
        doesNotNeedToBeSettable = param2
    }
    
}

//var someStructure = SomeStructure(doesNotNeedToBeSettable: 0, mustBeSettableAndGetter: 10)
//
//print(someStructure.mustBeSettableAndGetter)
//
//someStructure.mustBeSettableAndGetter = 100
//someStructure.doesNotNeedToBeSettable = 10000
//
//print(someStructure)


let someClass = SomeClass(param1: 0, param2: 0)
someClass.doesNotNeedToBeSettable = 1000
print(someClass.doesNotNeedToBeSettable)




