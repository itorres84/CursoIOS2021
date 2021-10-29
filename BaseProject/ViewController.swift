//
//  ViewController.swift
//  BaseProject
//
//  Created by Rom Vargas on 22/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelTitulo: UILabel!
    
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var txtNombre: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelTitulo.backgroundColor = UIColor.purple
        labelTitulo.textColor = UIColor.white
        // Do any additional setup after loading the view.
        labelTitulo.font = UIFont(name: "KomicSundayDemoRegular", size: 22)
        // 	labelTitulo.font = UIFont(name: "orangejuice", size: 25)
        labelTitulo.text = "Tesxto desde codigo"
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.backgroundColor: UIColor.red,
            // 	NSAttributedString.Key.font: UIFont(name: "drift", size: 15)
        ]
        let attributeString = NSAttributedString(string: "Test String", attributes: attributes)
        
        let someString = "Testing String Attribute"
        let attributeSS = NSMutableAttributedString(string: someString)
        
        let firstAttribute: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.blue,
            .backgroundColor: UIColor.yellow,
            .underlineStyle: 1
        ]
        
        let secondAttribute: [NSMutableAttributedString.Key: Any] = [
            .foregroundColor: UIColor.red,
            .backgroundColor: UIColor.blue,
            .underlineStyle: 1
        ]
        
        let thirdAttribute: [NSMutableAttributedString.Key: Any] = [
            .foregroundColor: UIColor.green,
            .backgroundColor: UIColor.black,
            .font : UIFont.boldSystemFont(ofSize: 40)
        ]
        
        attributeSS.addAttributes(firstAttribute, range: NSRange(location: 0, length: 8	))
        attributeSS.addAttributes(secondAttribute, range: NSRange(location: 8, length: 9))
        attributeSS.addAttributes(thirdAttribute, range: NSRange(location: 18, length: 6))
        
        labelTitulo.attributedText = attributeSS
        
        // Button
        button1.backgroundColor = UIColor.black
        button1.setTitle("BOTON 1", for: .normal)
        button1.titleLabel?.font = UIFont(name: "KomicSundayDemoRegular", size: 20)
        button1.layer.cornerRadius = 40
        button1.layer.borderColor = UIColor.white.cgColor
        button1.layer.borderWidth = 5

    }

    @objc func closeKeyboard() {
        txtNombre.endEditing(true)
    }
    
    @IBAction func actionBtn1(_ sender: UIButton) {
        print("Hola Mundo")
        
        guard let textName = txtNombre.text, !textName.isEmpty else { return }
        
        let alertController = UIAlertController(title: "Hola Mundo", message: textName, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Enterado", style: .default) {
            action in print("cerrado")
        }
        
        alertController.addAction(action	)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}

