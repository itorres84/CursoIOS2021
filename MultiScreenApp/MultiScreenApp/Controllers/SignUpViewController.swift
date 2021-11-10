//
//  SignUpViewController.swift
//  MultiScreenApp
//
//  Created by Abdiel Molina on 05/11/21.
//

import UIKit

enum TypeValidationTextFields {
    
    case texto
    case email
    case password
}

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        txtNombre.delegate = self
        txtLastName.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func SignUpProcess(_ sender: Any) {
        
        guard let name = txtNombre.text, !name.isEmpty,
              let lastName = txtLastName.text, !lastName.isEmpty,
              let email = txtEmail.text, !email.isEmpty,
              let password = txtPassword.text, !password.isEmpty,
              let confirmPassword = txtConfirmPassword.text, !confirmPassword.isEmpty else {
                  showAlert(message: "Debes llenar todos los campos", tittle: "Error")
            return
        }
        
        
    }
    
    func showAlert(message: String, tittle: String){
        
        let alertController = UIAlertController(title: tittle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(action)
        
        self.present(alertController, animated:true, completion: nil)
    }
    
    func valid(text: String, Type: TypeValidationTextFields) -> Bool {
        
        var regex = ""
        switch type {
        case .texto:
            regex =
        case .password:
            let min = 8
            let max = 40
            regex =
        }
    }
    
    
    //validar campo de nombre con expresion regular
    func isValidName(name: String) -> Bool {
        
        let regex = "^[A-Za-z-ñÑÁáÉéÍíÓóÚú ]{0,100}$"
        
        do {
        
        let regExVal = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
        
        let matches = regExVal.numberOfMatches(in: name, options: [], range: NSRange(location: 0, length: name.count))
        
        if matches > 0 {
            return true
        }else{
        
        return false
        }
        
    } catch {
        
        print(error.localizedDescription)
        return false
    }
}
}

//MARK: UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
//        //Opcion 1
//        if textField.tag == 1 { // campo nombre
//        }
//
//        //OPcion 2
//        switch textField.tag {
//
//        case 1 :
//            //TODO: esta validación será implementada después
//            break
//
//
//        default:
//            print("Campo no controlado")
//        }
//
        //Opcion 3
        
        if textField == txtNombre || textfield == txtLastName {
        if let texto = textField.text, !texto.isEmpty {
            
            let isValid = isValidName(name: texto)
            print("El campo es válido?: \(isValid)")
            if !isValid{
                
                showAlert(message: "El campo de nombre contiene caracteres inválidos", tittle: "Error")
            }
        }
        
    }; else if texField == txtEmail { //Campo email
        
        if let texto = textField.text, !texto.isEmpty {
            
            let isValid = valid(text: texto, type: .texto)
        }
    }
}
