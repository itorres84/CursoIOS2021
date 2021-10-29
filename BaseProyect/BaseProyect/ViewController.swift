//
//  ViewController.swift
//  BaseProyect
//
//  Created by Abdiel Molina on 22/10/21.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    //IBOutlet
    //Son propiedades que nos sirven para conectar componentes de interfaz de ususaerio de nuestro código
    @IBOutlet weak var LblTittle: UILabel!
    @IBOutlet weak var BtnSaludar: UIButton!
    @IBOutlet weak var txtnombre: UITextField!
    
    
    //Ciclo de vida del ViewController este método se ejecuta antes de que la vista se interprete en pantalla
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        LblTittle.backgroundColor = UIColor.purple
        LblTittle.textColor = UIColor.yellow
        LblTittle.numberOfLines = 0
        LblTittle.font = UIFont(name: "eglantine", size: 40)
        
        LblTittle.text = "this is a test string"
        
        let text = "Testing Attribute String"
        let attributedstring = NSMutableAttributedString(string: text)
        
        let firstAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.blue,
            .backgroundColor: UIColor.yellow,
            .underlineStyle : 1
            ]
        
        let secondAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.red,
            .backgroundColor: UIColor.blue,
            .underlineStyle : 1
            ]
        
        let thirdAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.green,
            .backgroundColor: UIColor.black,
            .underlineStyle : 1,
            .font: UIFont.boldSystemFont(ofSize: 40)
            ]
        
        attributedstring.addAttributes(firstAttributes, range: NSRange(location: 0, length: 7))
        attributedstring.addAttributes(secondAttributes, range: NSRange(location: 8, length: 9))
        attributedstring.addAttributes(thirdAttributes, range: NSRange(location: 18, length: 6))
        
        LblTittle.attributedText = attributedstring
        
    // BOTON
        BtnSaludar.backgroundColor = UIColor.yellow
        BtnSaludar.setTitle("saludar dos", for: .normal)
        BtnSaludar.titleLabel?.font = UIFont(name: "eglantine", size: 40)
    
        //redondear boton
        BtnSaludar.layer.cornerRadius = 20
        BtnSaludar.layer.borderColor = UIColor.cyan.cgColor
        BtnSaludar.layer.borderWidth =  5
        
        
        txtnombre.delegate = self
        
        let gesture: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.closekeyboard))
        
        self.view.addGestureRecognizer(gesture)
    }

    @objc func closekeyboard(){
        txtnombre.endEditing(true)
    }
    
    
    @IBAction func Saludo(_ sender: Any) {
        print("Entro")
        guard let textName = txtnombre.text, !textName.isEmpty else {return}
        
        let alertController = UIAlertController(title: "Hola Mundo", message: textName, preferredStyle: .alert)
        
        let accion = UIAlertAction(title: "Enterado", style: .default) {action in
            print("se cerró la alerta")
        }
        
        alertController.addAction(accion)
    
        
        //alertcontroller.show (self, sender:nil)
        self.present(alertController, animated: true, completion: nil)
        
        }
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        changeStyleButton(state: .active)

    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else {return}
        
        if !text.isEmpty {
            changeStyleButton(state: .fill)
        }else{
            changeStyleButton(state: .inactive)
        }
}
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        
        guard let text = textField.text else { return false }
        
        
        if !text.isEmpty {
            textField.endEditing(true)
            return true
        }else{
            return false
        }
        
    
        
    }

    //MARK: Utilities View
    func changeStyleButton(state: stateButtonViewController) {
 
        switch state {
        case .active:
            BtnSaludar.backgroundColor = UIColor.yellow
            BtnSaludar.titleLabel?.textColor = .black
            BtnSaludar.isUserInteractionEnabled = false
            
        case .inactive:
            BtnSaludar.backgroundColor = UIColor.red
            BtnSaludar.titleLabel?.textColor = .white
            BtnSaludar.isUserInteractionEnabled = false
            
        case .fill:
            BtnSaludar.backgroundColor = UIColor.green
            BtnSaludar.titleLabel?.textColor = .blue
            BtnSaludar.isUserInteractionEnabled = true
            
        }
        
}


    enum stateButtonViewController {

case active
    case inactive
    case fill
}
}
