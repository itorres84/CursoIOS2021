//
//  SignInViewController.swift
//  MultiScreenApp
//
//  Created by Isrrael Torres Alvarado on 05/11/21.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var emailValid: Bool = false
    var passwordValid: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email.delegate = self
        password.delegate = self
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier, identifier.elementsEqual("goToHome") {
            
            if let tabbar = segue.destination as? UITabBarController,
               let homeViewController = tabbar.viewControllers?.first as? HomeViewController {
                
                if let name = sender as? String {
                    homeViewController.name = name
                }
                
            }
        }
        
    }
    
    @IBAction func login(_ sender: Any) {
        
        guard let strEmail = email.text, !strEmail.isEmpty,
              let strPassword = password.text, !strPassword.isEmpty else {
            return
        }
        
        emailValid = valid(text: strEmail, type: .email)
        passwordValid = valid(text: strPassword, type: .password)
        
        if emailValid && passwordValid {
            
            let persistenceClient = PersistenceClient()
            
            let name = persistenceClient.login(email: strEmail, password: strPassword)
            
            if !name.isEmpty, !name.elementsEqual("Error") {
                performSegue(withIdentifier: "goToHome", sender: name)
            } else {
                showAlert(message: "usuario no valido", title: "Error")
            }
            
        } else {
                
            showAlert(message: "Los campos tienen formato invalido", title: "Error")
            
        }
            
    }
    
    func showAlert(message: String, title: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    enum TypeValidationTextFields {
        case email
        case password
    }
    
    func valid(text: String, type: TypeValidationTextFields) -> Bool {
            
            var regex = ""
            
            switch type {
            case .email:
                regex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$"
            case .password:
                let min = 8
                let max = 40
                regex = "^[a-zA-Z0-9_ #=!?¿¡,ÑñÁÉÍÓÚáéíóú./()*-]{\(min),\(max)}$"
            }
            
            do {
                    
                let regExVal = try NSRegularExpression(pattern: regex, options: .caseInsensitive)
                let matches = regExVal.numberOfMatches(in: text, options: [], range: NSRange(location: 0, length: text.count))
                if matches > 0 {
                    return true
                } else {
                        
                    return false
                }
            
            } catch {
                
                print(error.localizedDescription)
                return false
                
            }
            
        }
       
    
}

//MARK: UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        if textField == email {
            textField.resignFirstResponder() //que la caja de texto pierda el foco
            password.becomeFirstResponder() //habilitar el foco de manera programatica
        } else if textField == password {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == email { //Campo email
            
            if let texto = textField.text, !texto.isEmpty {
                
                let isValid = valid(text: texto, type: .email)
                
                if !isValid {
                    showAlert(message: "El campo de email no tiene el formato", title: "Error")
                    emailValid = false
                } else {
                    emailValid = true
                }
                
            }
            
        } else if textField == password  { //Campo email
            
            if let texto = textField.text, !texto.isEmpty {
                
                let isValid = valid(text: texto, type: .password)
                
                if !isValid {
                    
                    showAlert(message: "El campo de password no tiene el formato", title: "Error")
                    passwordValid = false

                } else {
                    passwordValid = true
                }
                
            }
            
        }
        
        
    }
    
}
