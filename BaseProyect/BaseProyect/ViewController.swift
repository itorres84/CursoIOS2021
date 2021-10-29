//
//  ViewController.swift
//  BaseProyect
//
//  Created by Isrrael Torres Alvarado on 22/10/21.
//

import UIKit

class ViewController: UIViewController {

    //@IBOutlet
    //Son propiedades que nos sirven para conectar compentes de interfaz de usuario con nuestro codigo
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSaludar: UIButton!
    @IBOutlet weak var txtNombre: UITextField!
    
    //Ciclo de vida del viewController este metodo se ejecuta antes de que la vista se presente en pantalla
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.numberOfLines = 0
    
        let string = "Testing Attribute String"
        let attributedString = NSMutableAttributedString(string: string)
        
        let firstAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.blue,
            .backgroundColor: UIColor.yellow,
            .underlineStyle: 1
        ]
        
        let secondAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.red,
            .backgroundColor: UIColor.blue,
            .strikethroughStyle: 1
        ]
        
        let thirdAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.green,
            .backgroundColor: UIColor.black,
            .font: UIFont.boldSystemFont(ofSize: 40)
        ]
        
        attributedString.addAttributes(firstAttributes, range: NSRange(location: 0, length: 7))
        attributedString.addAttributes(secondAttributes, range: NSRange(location: 8, length: 9))
        attributedString.addAttributes(thirdAttributes, range: NSRange(location: 18, length: 6))
        
        lblTitle.attributedText = attributedString
        
        //Button
        btnSaludar.backgroundColor = UIColor.red
        btnSaludar.setTitle("Saludar dos", for: .normal)
        btnSaludar.titleLabel?.font = UIFont(name: "drift", size: 20)
        
        //redondear el boton
        btnSaludar.layer.cornerRadius = 20
        btnSaludar.layer.borderColor = UIColor.black.cgColor
        btnSaludar.layer.borderWidth = 5
        
    }
    
    
    @IBAction func saludar(_ sender: UIButton) {
        
        guard let strName = txtNombre.text, !strName.isEmpty else { return }
        
        let alertController = UIAlertController(title: "Hola Mundo", message: strName, preferredStyle: .alert)
        
        let accion = UIAlertAction(title: "enterado", style: UIAlertAction.Style.default) { accion in
            print("se cerro la alerta")
        }
        
        alertController.addAction(accion)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func sumar(_ num1: Int, _ num2: Int) {
        print("El resultado de la suma es: \(num1 + num2)")
    }
    
}

