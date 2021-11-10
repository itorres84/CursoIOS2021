//
//  ViewController.swift
//  BaseProyect
//
//  Created by Isrrael Torres Alvarado on 22/10/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

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
        
        txtNombre.delegate = self
        
        let gesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.closeKeyboard))
        self.view.addGestureRecognizer(gesture)
        
    }
    
    @objc func closeKeyboard() {
        txtNombre.endEditing(true)
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
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        changeStyleButton(state: .active)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if !text.isEmpty {
            changeStyleButton(state: .fill)
        } else {
            changeStyleButton(state: .inactivo)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard let text = textField.text else { return false }
        
        if !text.isEmpty {
            textField.endEditing(true)
            return true
        } else {
            return false
        }
    
    }

    
    //MARK: Utilities view
    func changeStyleButton(state: StateButtonViewController) {
        
        switch state {
        case .active:
            btnSaludar.backgroundColor = .yellow
            btnSaludar.titleLabel?.textColor = .black
            btnSaludar.isUserInteractionEnabled = false
        case .inactivo:
            btnSaludar.backgroundColor = UIColor.red
            btnSaludar.titleLabel?.textColor = .white
            btnSaludar.isUserInteractionEnabled = false
        case .fill:
            btnSaludar.backgroundColor = .green
            btnSaludar.titleLabel?.textColor = .blue
            btnSaludar.isUserInteractionEnabled = true
        }
        
    }
    
}


enum StateButtonViewController {
    case active
    case inactivo
    case fill
}



