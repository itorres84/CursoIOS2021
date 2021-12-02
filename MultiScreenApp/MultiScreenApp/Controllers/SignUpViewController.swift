//
//  SignUpViewController.swift
//  MultiScreenApp
//
//  Created by Isrrael Torres Alvarado on 05/11/21.
//

import UIKit

// Enumeracion que me indica que tipo de campo de texto es para poder validarlo
enum TypeValidationTextFields {
    case texto //se valida el campo de nombre y apellidos
    case email // se valida el corre electronico
    case password // se valida la contraseña y comprobar contraseña
}

class SignUpViewController: UIViewController {

    //Son propiedades que representan una caja de texto
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
   
    //Son propiedades que son auxiliares para validacion de las cajas de texto
    var nameIsValid: Bool = false
    var lastNameValid: Bool = false
    var emailValid: Bool = false
    var passwordValid: Bool = false
    var confirmPasswordValid: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtNombre.delegate = self
        txtLastName.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
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
    
    @IBAction func SignUpProcess(_ sender: Any) {

        guard let name = txtNombre.text, !name.isEmpty,
        let lastName = txtLastName.text, !lastName.isEmpty,
        let email = txtEmail.text, !email.isEmpty,
        let password = txtPassword.text, !password.isEmpty,
        let confirmPassword = txtConfirmPassword.text, !confirmPassword.isEmpty else {
            showAlert(message: "Debes llenar todos los campos", title: "Error")
            return
        }
        
        if nameIsValid && lastNameValid && emailValid && passwordValid && confirmPasswordValid {
                        
            let networkClient = NetworkClient()
            
            networkClient.signUp(model: NetworkClient.SignUpRequestModel(name: name,
                                                                         lastName: lastName,
                                                                         email: email,
                                                                         password: password,
                                                                         returnSecureToken: true)) { responseData, error in
                
            
                if let errorRespose = error {
                    self.showAlert(message: errorRespose.localizedDescription, title: "Error")
                } else if let data = responseData {
                    
                    self.performSegue(withIdentifier: "goToHome", sender: data.displayName)
                    
                }
                    
            }
                                
        } else {
            showAlert(message: "los campos deben tener un formato valido", title: "Error")
        }
        
    }
    
    func showAlert(message: String, title: String) {
    
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    /*
        
     Parametros
     text: Representa el texto que se quiere validar
     type: Representa el tipo de validacion que se quiere realizar
     
     Return
     Regresa true si es valido o regresa false si el compo no es valido
     
    */
    func valid(text: String, type: TypeValidationTextFields) -> Bool {
        
        var regex = ""
        
        switch type {
        case .texto:
            regex = "^[A-Za-z-ñÑÁáÉéÍíÓóÚú ]{0,100}$"
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
extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //Primera opcion
//        if textField.tag == 1 || textField.tag == 2 { //Campo nombre
//
//            if let texto = textField.text, !texto.isEmpty { //Campo nombre, apellido
//
//                let isValid = isValidName(name: texto)
//                print("el campo es valido?: \(isValid)")
//                if !isValid {
//                    showAlert(message: "El campo de nombre o apellido contiene caracteres invalidos, favor de solo escribir letras", title: "Error")
//                }
//
//
//            }
//
//        } else if textField.tag == 3 { //Campo Apellido
//
//        }
//
//        //Segunda opcion
//
//        switch textField.tag {
//
//        case 1, 2: //Campo nombre, apellido
//
//            if let texto = textField.text, !texto.isEmpty { //Campo nombre, apellido
//
//                let isValid = isValidName(name: texto)
//                print("el campo es valido?: \(isValid)")
//                if !isValid {
//                    showAlert(message: "El campo de nombre o apellido contiene caracteres invalidos, favor de solo escribir letras", title: "Error")
//                }
//
//
//            }
//
//        case 3:
//            //TODO: esta validacion sera implentada despues
//            break
//        case 4:
//            //TODO: esta validacion sera implentada despues
//            break
//        case 5:
//            //TODO: esta validacion sera implentada despues
//            break
//        default:
//            print("Campo no controlado")
//
//        }

        //tercera opcion
        if textField == txtNombre || textField == txtLastName {

            if let texto = textField.text, !texto.isEmpty { //Campo nombre, apellido

                let isValid = valid(text: texto, type: .texto)
                
                if !isValid {
                    showAlert(message: "El campo de nombre contiene caracteres invalidos, favor de solo escribir letras", title: "Error")
                    if textField == txtNombre {
                        nameIsValid = false
                    } else if textField == txtLastName {
                        lastNameValid = false
                    }
                
                } else {
                    
                    if textField == txtNombre {
                        nameIsValid = true
                    } else if textField == txtLastName {
                        lastNameValid = true
                    }
                    
                }

            }

        } else if textField == txtEmail { //Campo email
            
            if let texto = textField.text, !texto.isEmpty {
                
                let isValid = valid(text: texto, type: .email)
                
                if !isValid {
                    showAlert(message: "El campo de email no tiene el formato", title: "Error")
                    emailValid = false
                } else {
                    emailValid = true
                }
                
            }
            
        } else if textField == txtPassword || textField == txtConfirmPassword { //Campo email
            
            if let texto = textField.text, !texto.isEmpty {
                
                let isValid = valid(text: texto, type: .password)
                
                if !isValid {
                    showAlert(message: "El campo de password no tiene el formato", title: "Error")
                    if textField == txtPassword {
                        passwordValid = false
                    } else if textField == txtConfirmPassword {
                        confirmPasswordValid = false
                    }
                    
                } else {
                    
                    if textField == txtPassword {
                        passwordValid = true
                    } else if textField == txtConfirmPassword {
                        confirmPasswordValid = true
                    }
                
                }
                
            }
            
        }
        

    }
    
}
